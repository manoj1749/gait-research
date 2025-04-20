import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

# ----------------------------------------
# Load CSV
# ----------------------------------------
df = pd.read_csv("labeled_gait_output.csv")

# Use a subset to keep animation fast
# df = df.iloc[::5].reset_index(drop=True)

# ----------------------------------------
# Segment Lengths (in meters)
# ----------------------------------------
thigh_length = 0.4
shank_length = 0.45

from sklearn.decomposition import PCA

def estimate_joint_angle(df, part1_prefix, part2_prefix, axes=["X", "Y", "Z"], fs=100):
    # Extract filtered gyro vectors
    gyro1 = df[[f"{part1_prefix}_Gyro{a}_filtered" for a in axes]].to_numpy()
    gyro2 = df[[f"{part2_prefix}_Gyro{a}_filtered" for a in axes]].to_numpy()
    
    # Compute relative motion
    relative_gyro = gyro1 - gyro2
    pca = PCA(n_components=1)
    pca.fit(relative_gyro)
    joint_axis = pca.components_[0]

    # Project both onto joint axis
    proj1 = np.dot(gyro1, joint_axis)
    proj2 = np.dot(gyro2, joint_axis)

    # Estimate angle by integrating difference
    time = df["Time"].values[:len(proj1)] / 1000  # convert to sec
    angle = np.cumsum((proj1 - proj2) * np.gradient(time))
    angle -= np.mean(angle[:50])  # zero-mean for consistency
    return angle

df["Left_Thigh_Angle"] = estimate_joint_angle(df, "LT", "LS")
df["Right_Thigh_Angle"] = estimate_joint_angle(df, "RT", "RS")

# ----------------------------------------
# 3D Joint Position Calculator
# ----------------------------------------
# def compute_leg_positions(hip, thigh_angle, ankle_angle):
#     # All movement in YZ plane, X is fixed
#     thigh_angle = ankle_angle * 0.5  # or 0.3 for subtle motion
#     knee = hip + np.array([0, np.cos(thigh_angle), -np.sin(thigh_angle)]) * thigh_length
#     ankle = knee + np.array([0, np.cos(ankle_angle), -np.sin(ankle_angle)]) * shank_length
#     return knee, ankle

def compute_leg_positions(hip, thigh_angle, ankle_angle):
    # Add thigh bend
    knee = hip + np.array([0, np.cos(thigh_angle), -np.sin(thigh_angle)]) * thigh_length
    ankle = knee + np.array([0, np.cos(thigh_angle + ankle_angle), -np.sin(thigh_angle + ankle_angle)]) * shank_length
    return knee, ankle

# Gait phase color map
PHASE_COLORS = {
    "Stance": "blue",
    "Swing": "green",
    "Heel Strike": "red",
    "Toe-Off": "orange"
}


# ----------------------------------------
# Setup Plot
# ----------------------------------------
fig = plt.figure(figsize=(10, 6))
ax = fig.add_subplot(111, projection='3d')
ax.set_xlim(-0.2, 0.5)
ax.set_ylim(-0.5, 1.5)
ax.set_zlim(0, 1.6)
ax.plot([-0.2, 0.5], [0, 0], [0, 0], color='gray', linestyle='--', linewidth=1)
ax.set_xlabel('X (lateral)')
ax.set_ylabel('Y (forward)')
ax.set_zlabel('Z (up)')
ax.set_title("3D Gait Stick Figure")

# Plot elements
left_leg_line, = ax.plot([], [], [], 'o-', lw=4, label="Left Leg")
right_leg_line, = ax.plot([], [], [], 'o-', lw=4, label="Right Leg", color='orange')
time_text = ax.text2D(0.05, 0.95, "", transform=ax.transAxes)
force_text = ax.text2D(0.75, 0.95, "", transform=ax.transAxes)  # new

# ----------------------------------------
# Animation Update Function
# ----------------------------------------
def update(frame):
    t = df.loc[frame, "Time"] / 1000.0

    # Angles with scaling
    L_angle = np.radians(df.loc[frame, "Left_Ankle_Angle"]) * 1.5
    R_angle = np.radians(df.loc[frame, "Right_Ankle_Angle"]) * 1.5

    # Joint positions
    hip_L = np.array([0, 0, 1])
    hip_R = np.array([0.2, 0, 1])
    
    T_angle_L = np.radians(df.loc[frame, "Left_Thigh_Angle"])
    T_angle_R = np.radians(df.loc[frame, "Right_Thigh_Angle"])

    knee_L, ankle_L = compute_leg_positions(hip_L, T_angle_L, L_angle)
    knee_R, ankle_R = compute_leg_positions(hip_R, T_angle_R, R_angle)

    # Get gait phase for color
    phase_L = df.loc[frame, "Left_Gait_Phase"]
    phase_R = df.loc[frame, "Right_Gait_Phase"]
    color_L = PHASE_COLORS.get(phase_L, "black")
    color_R = PHASE_COLORS.get(phase_R, "black")

    # Update stick figure lines
    left_leg_line.set_data([hip_L[0], knee_L[0], ankle_L[0]],
                           [hip_L[1], knee_L[1], ankle_L[1]])
    left_leg_line.set_3d_properties([hip_L[2], knee_L[2], ankle_L[2]])
    left_leg_line.set_color(color_L)

    right_leg_line.set_data([hip_R[0], knee_R[0], ankle_R[0]],
                            [hip_R[1], knee_R[1], ankle_R[1]])
    right_leg_line.set_3d_properties([hip_R[2], knee_R[2], ankle_R[2]])
    right_leg_line.set_color(color_R)

    # Force sensor values
    force_L = df.loc[frame, "Left_Force"]
    force_R = df.loc[frame, "Right_Force"]

    # Update on-screen text
    time_text.set_text(f"Time: {t:.2f}s")
    force_text.set_text(f"L_Force: {force_L:.0f}  |  R_Force: {force_R:.0f}")
    
    # # Optional: Visualize foot contact when in stance
    # if phase_L == "Stance":
    #     ax.scatter(ankle_L[0], ankle_L[1], 0, color='blue', s=20)

    # if phase_R == "Stance":
    #     ax.scatter(ankle_R[0], ankle_R[1], 0, color='orange', s=20)


    return left_leg_line, right_leg_line, time_text, force_text

# ----------------------------------------
# Run Animation
# ----------------------------------------
ani = FuncAnimation(fig, update, frames=len(df), interval=40, blit=False)
plt.legend()
plt.tight_layout()
plt.show()
ani.save("gait_animation.gif", writer='pillow', fps=25)

# ----------------------------------------