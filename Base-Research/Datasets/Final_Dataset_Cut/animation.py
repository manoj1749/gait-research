import pandas as pd
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from matplotlib.animation import FuncAnimation

# Load the dataset
file_path = './Kavya.csv'
gait_data = pd.read_csv(file_path)

# Joints to track
joints = ['LK', 'RK', 'LH', 'RH', 'LA', 'RA']

# Choose Left Hip (LH) as the global reference joint
ref_x = gait_data['X (m/s2)_LH']
ref_y = gait_data['Y (m/s2)_LH']
ref_z = gait_data['Z (m/s2)_LH']

# Transform coordinates relative to LH (Left Hip) with scaling for more length
scale_factor = 3  # Add more length to the joints
transformed_data = pd.DataFrame()
for joint in joints:
    transformed_data[f'{joint}_X'] = (gait_data[f'X (m/s2)_{joint}'] - ref_x) * scale_factor
    transformed_data[f'{joint}_Y'] = (gait_data[f'Y (m/s2)_{joint}'] - ref_y) * scale_factor
    transformed_data[f'{joint}_Z'] = (gait_data[f'Z (m/s2)_{joint}'] - ref_z) * scale_factor

# Create figure and 3D axis for the animation
fig = plt.figure(figsize=(8, 6))
ax = fig.add_subplot(111, projection='3d')
ax.set_xlim(transformed_data.min().min() - 1, transformed_data.max().max() + 1)
ax.set_ylim(transformed_data.min().min() - 1, transformed_data.max().max() + 1)
ax.set_zlim(transformed_data.min().min() - 1, transformed_data.max().max() + 1)

# Initialize stickman lines
connections = [
    ('LH', 'LK'), ('LK', 'LA'),  # Left leg: Hip → Knee → Ankle
    ('RH', 'RK'), ('RK', 'RA')   # Right leg: Hip → Knee → Ankle
]
colors = ['blue', 'orange', 'green', 'red']  # Colors for each connection
labels = ['LH to LK', 'LK to LA', 'RH to RK', 'RK to RA']  # Labels for each line
lines = [ax.plot([], [], [], 'o-', lw=4, color=colors[i], label=labels[i])[0] for i in range(len(connections))]

# Initialize function
def init():
    for line in lines:
        line.set_data([], [])
        line.set_3d_properties([])
    return lines

# Update function for each frame
def update(frame):
    for i, (joint1, joint2) in enumerate(connections):
        x_data = [transformed_data[f'{joint1}_X'][frame], transformed_data[f'{joint2}_X'][frame]]
        y_data = [transformed_data[f'{joint1}_Y'][frame], transformed_data[f'{joint2}_Y'][frame]]
        z_data = [transformed_data[f'{joint1}_Z'][frame], transformed_data[f'{joint2}_Z'][frame]]
        lines[i].set_data(x_data, y_data)
        lines[i].set_3d_properties(z_data)
    return lines

# Create the animation
ani = FuncAnimation(fig, update, frames=len(transformed_data), init_func=init, blit=True, interval=100)

ax.set_title("GAIT Simulation with Full Lower Body Joints (3D, Scaled)")
ax.set_xlabel("X-axis")
ax.set_ylabel("Y-axis")
ax.set_zlabel("Z-axis")
ax.legend()  # Add legend to display labels
plt.show()
