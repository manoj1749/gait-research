import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.animation as animation
from mpl_toolkits.mplot3d import Axes3D

# 📌 Load dataset
file_path = "./dataset_final/patient2/test1.csv"
df = pd.read_csv(file_path)

# 📌 Define segment lengths (meters)
thigh_length = 0.4
shank_length = 0.4
foot_length = 0.1

# 📌 Convert gyroscope data to radians per second
deg_to_rad = np.pi / 180.0

# 📌 Extract Gyroscope Data (X and Y axes for 3D)
gyro_rt_x = df["RT_GyroX"].values * deg_to_rad  # Right Thigh (X-axis)
gyro_rt_y = df["RT_GyroY"].values * deg_to_rad  # Right Thigh (Y-axis)

gyro_rs_x = df["RS_GyroX"].values * deg_to_rad  # Right Shank (X-axis)
gyro_rs_y = df["RS_GyroY"].values * deg_to_rad  # Right Shank (Y-axis)

gyro_ra_x = df["RA_GyroX"].values * deg_to_rad  # Right Ankle (X-axis)
gyro_ra_y = df["RA_GyroY"].values * deg_to_rad  # Right Ankle (Y-axis)

gyro_lt_x = df["LT_GyroX"].values * deg_to_rad  # Left Thigh (X-axis)
gyro_lt_y = df["LT_GyroY"].values * deg_to_rad  # Left Thigh (Y-axis)

gyro_ls_x = df["LS_GyroX"].values * deg_to_rad  # Left Shank (X-axis)
gyro_ls_y = df["LS_GyroY"].values * deg_to_rad  # Left Shank (Y-axis)

gyro_la_x = df["LA_GyroX"].values * deg_to_rad  # Left Ankle (X-axis)
gyro_la_y = df["LA_GyroY"].values * deg_to_rad  # Left Ankle (Y-axis)

# 📌 Compute Joint Angles (Relative to Each Other)
theta_rt_x = np.cumsum(gyro_rt_x)  # Right Thigh (X-axis rotation → Leg Swing)
theta_rt_y = np.cumsum(gyro_rt_y)  # Right Thigh (Y-axis rotation → Knee Flexion)

theta_rs_x = np.cumsum(gyro_rs_x - gyro_rt_x)  # Right Shank (Relative Swing)
theta_rs_y = np.cumsum(gyro_rs_y - gyro_rt_y)  # Right Shank (Relative Knee Bend)

theta_ra_x = np.cumsum(gyro_ra_x - gyro_rs_x)  # Right Ankle (Relative Swing)
theta_ra_y = np.cumsum(gyro_ra_y - gyro_rs_y)  # Right Ankle (Relative Knee Bend)

theta_lt_x = np.cumsum(gyro_lt_x)  # Left Thigh (X-axis rotation → Leg Swing)
theta_lt_y = np.cumsum(gyro_lt_y)  # Left Thigh (Y-axis rotation → Knee Flexion)

theta_ls_x = np.cumsum(gyro_ls_x - gyro_lt_x)  # Left Shank (Relative Swing)
theta_ls_y = np.cumsum(gyro_ls_y - gyro_lt_y)  # Left Shank (Relative Knee Bend)

theta_la_x = np.cumsum(gyro_la_x - gyro_ls_x)  # Left Ankle (Relative Swing)
theta_la_y = np.cumsum(gyro_la_y - gyro_ls_y)  # Left Ankle (Relative Knee Bend)

# 📌 Clip Angles to Avoid Unrealistic Rotations
theta_rs_x = np.clip(theta_rs_x, -2.0, 2.0)
theta_rs_y = np.clip(theta_rs_y, -2.0, 2.0)

theta_ra_x = np.clip(theta_ra_x, -0.8, 1.2)
theta_ra_y = np.clip(theta_ra_y, -0.8, 1.2)

theta_ls_x = np.clip(theta_ls_x, -2.0, 2.0)
theta_ls_y = np.clip(theta_ls_y, -2.0, 2.0)

theta_la_x = np.clip(theta_la_x, -0.8, 1.2)
theta_la_y = np.clip(theta_la_y, -0.8, 1.2)

# 📌 Define Stick Figure Update Function (3D)
def update_3d(frame, ax):
    ax.clear()
    ax.set_xlim([-0.5, 0.5])
    ax.set_ylim([-0.5, 0.5])
    ax.set_zlim([0, 1])
    ax.set_title("3D Gait Cycle Animation")
    ax.set_xlabel("X position (m)")
    ax.set_ylabel("Y position (m)")
    ax.set_zlabel("Height (m)")

    # 📌 Compute Right Leg Joint Positions (3D)
    hip = np.array([0.2, 0, 0.8])  # Fixed reference in 3D
    knee_r = hip + thigh_length * np.array([np.sin(theta_rt_x[frame]), np.cos(theta_rt_y[frame]), -np.cos(theta_rt_y[frame])])
    ankle_r = knee_r + shank_length * np.array([np.sin(theta_rs_x[frame] + theta_rt_x[frame]), np.cos(theta_rs_y[frame] + theta_rt_y[frame]), -np.cos(theta_rs_y[frame] + theta_rt_y[frame])])
    foot_r = ankle_r + foot_length * np.array([np.sin(theta_ra_x[frame] + theta_rs_x[frame] + theta_rt_x[frame]), np.cos(theta_ra_y[frame] + theta_rs_y[frame] + theta_rt_y[frame]), -np.cos(theta_ra_y[frame] + theta_rs_y[frame] + theta_rt_y[frame])])

    # 📌 Compute Left Leg Joint Positions (3D)
    hip_l = np.array([-0.2, 0, 0.8])
    knee_l = hip_l + thigh_length * np.array([np.sin(theta_lt_x[frame]), np.cos(theta_lt_y[frame]), -np.cos(theta_lt_y[frame])])
    ankle_l = knee_l + shank_length * np.array([np.sin(theta_ls_x[frame] + theta_lt_x[frame]), np.cos(theta_ls_y[frame] + theta_lt_y[frame]), -np.cos(theta_ls_y[frame] + theta_lt_y[frame])])
    foot_l = ankle_l + foot_length * np.array([np.sin(theta_la_x[frame] + theta_ls_x[frame] + theta_lt_x[frame]), np.cos(theta_la_y[frame] + theta_ls_y[frame] + theta_lt_y[frame]), -np.cos(theta_la_y[frame] + theta_ls_y[frame] + theta_lt_y[frame])])

    # 📌 Plot Right Leg (3D)
    ax.plot([hip[0], knee_r[0]], [hip[1], knee_r[1]], [hip[2], knee_r[2]], 'ro-', label="Right Thigh")
    ax.plot([knee_r[0], ankle_r[0]], [knee_r[1], ankle_r[1]], [knee_r[2], ankle_r[2]], 'bo-', label="Right Shank")
    ax.plot([ankle_r[0], foot_r[0]], [ankle_r[1], foot_r[1]], [ankle_r[2], foot_r[2]], 'go-', label="Right Foot")

    # 📌 Plot Left Leg (3D)
    ax.plot([hip_l[0], knee_l[0]], [hip_l[1], knee_l[1]], [hip_l[2], knee_l[2]], 'ro-')
    ax.plot([knee_l[0], ankle_l[0]], [knee_l[1], ankle_l[1]], [knee_l[2], ankle_l[2]], 'bo-')
    ax.plot([ankle_l[0], foot_l[0]], [ankle_l[1], foot_l[1]], [ankle_l[2], foot_l[2]], 'go-')

    ax.legend(loc="upper right")

# 📌 Create Animation (3D)
fig = plt.figure(figsize=(6, 6))
ax = fig.add_subplot(111, projection='3d')
ani = animation.FuncAnimation(fig, update_3d, frames=len(df)//5, interval=50, fargs=(ax,))

plt.show()
