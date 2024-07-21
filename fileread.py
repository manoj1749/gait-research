import os
import csv
from docx import Document

left_dir = 'Joints/Left_Joints_Full'
right_dir = 'Joints/Right_Joints_Full'
left_output_dir = 'Output_CSVs/Left_Joints'
right_output_dir = 'Output_CSVs/Right_Joints'

os.makedirs(left_output_dir, exist_ok=True)
os.makedirs(right_output_dir, exist_ok=True)

def read_docx(file_path):
    try:
        doc = Document(file_path)
        content = [para.text for para in doc.paragraphs]
        return content
    except Exception as e:
        print(f"Could not read {file_path}: {str(e)}")
        return []

def write_to_csv(output_directory, file_path, content):
    base_name = os.path.splitext(os.path.basename(file_path))[0]
    csv_file_path = os.path.join(output_directory, base_name + '.csv')
    try:
        with open(csv_file_path, mode='w', newline='', encoding='utf-8') as csv_file:
            writer = csv.writer(csv_file)
            for line in content:
                writer.writerow([line])
        print(f"Written to {csv_file_path}")
    except Exception as e:
        print(f"Could not write {csv_file_path}: {str(e)}")

def process_directory(input_directory, output_directory):
    for filename in os.listdir(input_directory):
        if filename.endswith('.docx'):
            file_path = os.path.join(input_directory, filename)
            print(f"Processing file: {file_path}")
            content = read_docx(file_path)
            write_to_csv(output_directory, file_path, content)

print("Processing files in Left_Joints_Full directory:")
process_directory(left_dir, left_output_dir)

print("Processing files in Right_Joints_Full directory:")
process_directory(right_dir, right_output_dir)

print("Conversion to CSV completed.")
