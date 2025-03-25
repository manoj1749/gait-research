# for renaming the files
import os
import re

left_dir = 'Joints/Left_Joints_Full'
right_dir = 'Joints/Right_Joints_Full'

def clean_filename(filename):
    return re.sub(r'\s*\(.*?\)\.docx$', '.docx', filename)

def rename_files(directory):
    for filename in os.listdir(directory):
        if filename.endswith('.docx'):
            cleaned_filename = clean_filename(filename)
            old_path = os.path.join(directory, filename)
            new_path = os.path.join(directory, cleaned_filename)
            if old_path != new_path:
                os.rename(old_path, new_path)
                print(f'Renamed: {old_path} to {new_path}')

rename_files(left_dir)
rename_files(right_dir)

print("Renaming completed.")
