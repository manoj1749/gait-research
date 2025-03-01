import csv
from collections import defaultdict

def separate_data_by_sensor(input_filename):
    # Use a dictionary to collect rows for each sensor
    sensor_data = defaultdict(list)
    
    with open(input_filename, "r") as file:
        reader = csv.reader(file)
        header = next(reader)  # Read the header row
        
        # Process each row in the file
        for row in reader:
            # Skip empty rows that might appear in the file
            if not row or all(cell.strip() == "" for cell in row):
                continue
            
            # The SensorID is the second column (index 1)
            sensor_id = row[1]
            sensor_data[sensor_id].append(row)
    
    # For each sensor, write the collected rows into a new CSV file
    for sensor_id, rows in sensor_data.items():
        output_filename = f"sensor_{sensor_id}.csv"
        with open(output_filename, "w", newline="") as out_file:
            writer = csv.writer(out_file)
            writer.writerow(header)  # Write the header first
            writer.writerows(rows)
        print(f"Data for SensorID {sensor_id} written to {output_filename}")

if __name__ == "__main__":
    # Change 'data.csv' to the path of your data file if needed
    separate_data_by_sensor("/home/zer0_tw0/Documents/python/Final_Year/patient1/test1.csv")
