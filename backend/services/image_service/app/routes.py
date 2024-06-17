from fastapi import APIRouter, Depends, HTTPException, UploadFile, File
from sqlalchemy.orm import Session
from . import models, schemas, crud, utils
from .database import SessionLocal
from fastapi.responses import FileResponse
import os
from pathlib import Path
import requests

router = APIRouter()

# Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/upload/", response_model=schemas.ImageOut)
def upload_image(file: UploadFile = File(...), db: Session = Depends(get_db)):
    filename = file.filename
    file_location = f"uploads/{filename}"
    filtered_filename = f"filtered_{filename}"
    filtered_location = f"filtered/{filtered_filename}"

    utils.save_image(file, file_location)
    utils.apply_black_and_white_filter(file_location, filtered_location)
    
    db_image = crud.create_image(db=db, image=schemas.ImageCreate(filename=filename), user_id=1, filtered_filename=filtered_filename)

    # Log the upload action
    log_data = {
        "user_id": 1,
        "action": "upload",
        "details": f"Uploaded image {filename} and created filtered image {filtered_filename}"
    }
    requests.post("http://localhost:8002/logs/", json=log_data)

    return db_image

@router.get("/download/{image_id}", response_class=FileResponse)
def download_image(image_id: int, db: Session = Depends(get_db)):
    db_image = crud.get_image(db, image_id=image_id)
    if db_image is None:
        raise HTTPException(status_code=404, detail="Image not found")
    
    file_location = f"filtered/{db_image.filtered_filename}"
    if not os.path.exists(file_location):
        raise HTTPException(status_code=404, detail="Filtered image not found")

    # Log the download action
    log_data = {
        "user_id": 1,
        "action": "download",
        "details": f"Downloaded filtered image {db_image.filtered_filename}"
    }
    requests.post("http://localhost:8002/logs/", json=log_data)

    return FileResponse(path=file_location, filename=db_image.filtered_filename)
