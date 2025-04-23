# import pandas as pd
# import numpy as np
# import matplotlib.pyplot as plt
# from matplotlib.animation import FuncAnimation
# from ahrs.filters import Madgwick
# from ahrs.common.orientation import q2R

# # ----------------------------------------
# # Load Your Raw Data
# # ----------------------------------------
# df = pd.read_csv("combined_dataset.csv")  # Must contain LA_Accel*, LA_Gyro*, etc.
# fs = 100  # sampling frequency (Hz)
# dt = 1.0 / fs
# N = len(df)

# # List of IMUs to process
# imus = ["LA", "LS", "RA", "RS"]
# axes = ["X", "Y", "Z"]

# # ----------------------------------------
# # Run Madgwick Filter for Each IMU
# # ----------------------------------------
# quaternions = {}

# for imu in imus:
#     acc = df[[f"{imu}_Accel{a}" for a in axes]].to_numpy()
#     gyr = df[[f"{imu}_Gyro{a}" for a in axes]].to_numpy()
#     madgwick = Madgwick(frequency=fs)
#     q = np.zeros((N, 4))
#     q[0] = [1.0, 0.0, 0.0, 0.0]  # initial orientation
#     for t in range(1, N):
#         q[t] = madgwick.updateIMU(q[t-1], gyr[t], acc[t])
#     quaternions[imu] = q

# # ----------------------------------------
# # Segment Lengths
# # ----------------------------------------
# thigh_length = 0.4
# shank_length = 0.45

# # ----------------------------------------
# # Compute Joint Positions per Frame
# # ----------------------------------------
# def compute_positions(q_thigh, q_shank, hip_pos):
#     R_thigh = q2R(q_thigh)
#     R_shank = q2R(q_shank)

#     knee = hip_pos + R_thigh @ np.array([0.0, -thigh_length, 0.0])
#     ankle = knee + R_shank @ np.array([0.0, -shank_length, 0.0])
#     return knee, ankle

# # ----------------------------------------
# # Animation Setup
# # ----------------------------------------
# fig = plt.figure()
# ax = fig.add_subplot(111, projection='3d')
# ax.set_xlim(-0.2, 0.6)
# ax.set_ylim(-1.5, 0.5)
# ax.set_zlim(0, 1.6)
# ax.set_xlabel('X')
# ax.set_ylabel('Y')
# ax.set_zlabel('Z')

# hip_L = np.array([0.0, 0.0, 1.0])
# hip_R = np.array([0.2, 0.0, 1.0])

# line_L, = ax.plot([], [], [], 'o-', lw=3, label="Left Leg", color='blue')
# line_R, = ax.plot([], [], [], 'o-', lw=3, label="Right Leg", color='red')
# time_txt = ax.text2D(0.05, 0.95, "", transform=ax.transAxes)

# # ----------------------------------------
# # Animation Update Function
# # ----------------------------------------
# def update(frame):
#     q_LS = quaternions["LS"][frame]
#     q_LA = quaternions["LA"][frame]
#     q_RS = quaternions["RS"][frame]
#     q_RA = quaternions["RA"][frame]

#     knee_L, ankle_L = compute_positions(q_LS, q_LA, hip_L)
#     knee_R, ankle_R = compute_positions(q_RS, q_RA, hip_R)

#     line_L.set_data([hip_L[0], knee_L[0], ankle_L[0]], [hip_L[1], knee_L[1], ankle_L[1]])
#     line_L.set_3d_properties([hip_L[2], knee_L[2], ankle_L[2]])

#     line_R.set_data([hip_R[0], knee_R[0], ankle_R[0]], [hip_R[1], knee_R[1], ankle_R[1]])
#     line_R.set_3d_properties([hip_R[2], knee_R[2], ankle_R[2]])

#     time_txt.set_text(f"Time: {frame/fs:.2f}s")
#     return line_L, line_R, time_txt

# # ----------------------------------------
# # Run Animation
# # ----------------------------------------
# ani = FuncAnimation(fig, update, frames=N, interval=1000/fs, blit=False)
# plt.legend()
# plt.tight_layout()
# plt.show()
