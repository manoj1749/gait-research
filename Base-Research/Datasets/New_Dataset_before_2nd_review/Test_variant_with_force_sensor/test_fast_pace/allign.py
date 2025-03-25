import pandas as pd
import matplotlib.pyplot as plt
import scipy.signal as signal

# Load sensor 5 (left ankle) data and force sensor (test8L) data.
sensor5 = pd.read_csv('./sensor_6.csv')
force_data = pd.read_csv('./test15R.csv')

# Verify expected columns are present.
print("Sensor 5 columns:", sensor5.columns)
print("Force sensor columns:", force_data.columns)

if 'AccelX' not in sensor5.columns:
    raise ValueError("The sensor5 data does not contain an 'AccelX' column.")
if 'ForceValue' not in force_data.columns:
    raise ValueError("The force sensor data does not contain a 'ForceValue' column.")

# Resample the force sensor data to match the sensor sampling rate.
# Assuming sensor data is 250Hz and force data is 1000Hz,
# then the number of force samples should be 4x that of sensor5.
if len(force_data) == 4 * len(sensor5):
    # Use decimation (which applies an anti-aliasing filter)
    force_resampled = signal.decimate(force_data['ForceValue'], 4)
else:
    # If not, resample to exactly the length of sensor5's data.
    force_resampled = signal.resample(force_data['ForceValue'], len(sensor5))

# Plot sensor5 AccelX and the resampled force data together.
fig, ax1 = plt.subplots(figsize=(12, 6))
color1 = 'tab:blue'
ax1.set_xlabel("Sample Index")
ax1.set_ylabel("Sensor 5 AccelX", color=color1)
ax1.plot(sensor5['AccelX'], color=color1, label='Sensor 5 AccelX')
ax1.tick_params(axis='y', labelcolor=color1)

# Create a secondary axis for the resampled force data.
ax2 = ax1.twinx()
color2 = 'tab:orange'
ax2.set_ylabel("Resampled Test8L ForceValue", color=color2)
ax2.plot(force_resampled, color=color2, label='Resampled Test8L ForceValue', alpha=0.7)
ax2.tick_params(axis='y', labelcolor=color2)

plt.title("Left Ankle AccelX and Resampled Test8L Force (250Hz)")
fig.tight_layout()
plt.show()
