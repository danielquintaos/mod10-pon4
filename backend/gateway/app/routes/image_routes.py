from fastapi import APIRouter, Depends, HTTPException, UploadFile, File
import requests
from fastapi.responses import JSONResponse, FileResponse

router = APIRouter()

@router.post("/upload/")
def upload_image(file: UploadFile = File(...)):
    files = {'file': (file.filename, file.file, file.content_type)}
    response = requests.post("http://localhost:8001/images/upload/", files=files)
    if response.status_code != 200:
        raise HTTPException(status_code=response.status_code, detail=response.json())
    return JSONResponse(content=response.json())

@router.get("/download/{image_id}", response_class=FileResponse)
def download_image(image_id: int):
    response = requests.get(f"http://localhost:8001/images/download/{image_id}")
    if response.status_code != 200:
        raise HTTPException(status_code=response.status_code, detail=response.json())
    return FileResponse(response.content, filename=response.headers['content-disposition'].split("filename=")[-1])
