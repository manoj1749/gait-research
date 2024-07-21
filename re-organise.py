import os
import shutil
import re

# Define base directories
output_base_dir = 'Output_CSVs'
left_output_base_dir = os.path.join(output_base_dir, 'Left_Joints')
right_output_base_dir = os.path.join(output_base_dir, 'Right_Joints')
final_dataset_dir = 'Final_Dataset'

# Ensure the final dataset directory exists
os.makedirs(final_dataset_dir, exist_ok=True)

# Regex pattern to match dates
date_pattern = re.compile(r'\d{1,2}_\d{1,2}_\d{2,4}')

# Function to remove dates from filenames
def remove_dates_from_filename(filename):
    return re.sub(date_pattern, '', filename)

# Function to organize files into the final dataset structure
def organize_files(directory):
    for filename in os.listdir(directory):
        if filename.endswith('.csv'):
            # Remove dates from filename
            cleaned_filename = remove_dates_from_filename(filename)
            parts = cleaned_filename.split('_')
            prefix = parts[0]
            common_name = '_'.join(parts[1:]).strip('_')  # Remove leading/trailing underscores
            common_name = common_name.replace('.csv', '')  # Remove the .csv extension
            
            # Create the target directory based on the common name
            target_dir = os.path.join(final_dataset_dir, common_name)
            os.makedirs(target_dir, exist_ok=True)
            
            # Determine the target path for the file
            target_path = os.path.join(target_dir, f"{prefix}.csv")
            
            # Move the file to the target directory
            source_path = os.path.join(directory, filename)
            print(f"Moving {source_path} to {target_path}")  # Debug print
            shutil.move(source_path, target_path)

# Organize files in both Left_Joints and Right_Joints directories
print("Organizing files in Left_Joints directory:")
organize_files(left_output_base_dir)

print("Organizing files in Right_Joints directory:")
organize_files(right_output_base_dir)

print("Reorganization of CSV files completed.")
