from fastapi import APIRouter, Depends, HTTPException, UploadFile, File
import requests
from fastapi.responses import JSONResponse, FileResponse
import logging

router = APIRouter()

logger = logging.getLogger("gateway_logger")

@router.post("/upload/")
def upload_image(file: UploadFile = File(...)):
    try:
        files = {'file': (file.filename, file.file, file.content_type)}
        response = requests.post("http://localhost:8001/images/upload/", files=files)
        response.raise_for_status()
        logger.info(f"Image uploaded: {file.filename}")
        return JSONResponse(content=response.json())
    except requests.exceptions.RequestException as e:
        logger.error(f"Image upload failed: {file.filename} - {str(e)}")
        raise HTTPException(status_code=response.status_code, detail=response.json())

@router.get("/download/{image_id}", response_class=FileResponse)
def download_image(image_id: int):
    try:
        response = requests.get(f"http://localhost:8001/images/download/{image_id}")
        response.raise_for_status()
        logger.info(f"Image downloaded: {image_id}")
        return FileResponse(response.content, filename=response.headers['content-disposition'].split("filename=")[-1])
    except requests.exceptions.RequestException as e:
        logger.error(f"Image download failed: {image_id} - {str(e)}")
        raise HTTPException(status_code=response.status_code, detail=response.json())
