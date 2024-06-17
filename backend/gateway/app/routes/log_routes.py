from fastapi import APIRouter, Depends, HTTPException
import requests

router = APIRouter()

@router.post("/logs/")
def create_log(log: dict):
    response = requests.post("http://localhost:8002/logs/", json=log)
    if response.status_code != 200:
        raise HTTPException(status_code=response.status_code, detail=response.json())
    return response.json()

@router.get("/logs/")
def read_logs(skip: int = 0, limit: int = 10):
    response = requests.get(f"http://localhost:8002/logs/?skip={skip}&limit={limit}")
    if response.status_code != 200:
        raise HTTPException(status_code=response.status_code, detail=response.json())
    return response.json()

@router.get("/logs/{log_id}")
def read_log(log_id: int):
    response = requests.get(f"http://localhost:8002/logs/{log_id}")
    if response.status_code != 200:
        raise HTTPException(status_code=response.status_code, detail=response.json())
    return response.json()
