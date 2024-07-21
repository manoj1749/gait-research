import os

# Define the final dataset directory
final_dataset_dir = 'Final_Dataset'

# Function to clean up filenames
def clean_filenames(directory):
    for subdir, _, files in os.walk(directory):
        for filename in files:
            if filename.endswith('.csv'):
                # Remove spaces between the filename and the extension
                new_filename = filename.replace(' .csv', '.csv')
                old_file_path = os.path.join(subdir, filename)
                new_file_path = os.path.join(subdir, new_filename)
                
                # Rename the file if the new filename is different
                if old_file_path != new_file_path:
                    print(f"Renaming {old_file_path} to {new_file_path}")  # Debug print
                    os.rename(old_file_path, new_file_path)

# Clean filenames in the final dataset directory
clean_filenames(final_dataset_dir)

print("Renaming of CSV files completed.")
