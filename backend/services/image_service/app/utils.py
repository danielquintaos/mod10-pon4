from PIL import Image as PILImage
import os

def save_image(file, path):
    with open(path, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)

def apply_black_and_white_filter(input_path, output_path):
    image = PILImage.open(input_path).convert("L")
    image.save(output_path)
