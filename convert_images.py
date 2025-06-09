from PIL import Image
import os

def convert_png_to_jpg(input_folder):
    # Get all PNG files in the folder
    png_files = [f for f in os.listdir(input_folder) if f.lower().endswith('.png')]
    
    # Convert each PNG to JPG
    for png_file in png_files:
        try:
            # Full path of input PNG file
            png_path = os.path.join(input_folder, png_file)
            
            # Create output JPG filename
            jpg_file = os.path.splitext(png_file)[0] + '.jpg'
            jpg_path = os.path.join(input_folder, jpg_file)
            
            # Open and convert image
            with Image.open(png_path) as img:
                # Convert to RGB if necessary (in case of RGBA images)
                if img.mode in ('RGBA', 'LA'):
                    bg = Image.new('RGB', img.size, (255, 255, 255))
                    bg.paste(img, mask=img.split()[-1])
                    img = bg
                elif img.mode != 'RGB':
                    img = img.convert('RGB')
                    
                # Save as JPG
                img.save(jpg_path, 'JPEG', quality=95)
                print(f"Converted: {png_file} -> {jpg_file}")
                
        except Exception as e:
            print(f"Error converting {png_file}: {str(e)}")

if __name__ == "__main__":
    output_folder = "OUTPUTs"
    convert_png_to_jpg(output_folder) 