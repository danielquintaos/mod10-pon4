from fastapi import APIRouter, Depends, HTTPException
import requests
import logging

router = APIRouter()

logger = logging.getLogger("gateway_logger")

@router.post("/logs/")
def create_log(log: dict):
    try:
        response = requests.post("http://localhost:8002/logs/", json=log)
        response.raise_for_status()
        logger.info(f"Log created: {log}")
        return response.json()
    except requests.exceptions.RequestException as e:
        logger.error(f"Log creation failed: {log} - {str(e)}")
        raise HTTPException(status_code=response.status_code, detail=response.json())

@router.get("/logs/")
def read_logs(skip: int = 0, limit: int = 10):
    try:
        response = requests.get(f"http://localhost:8002/logs/?skip={skip}&limit={limit}")
        response.raise_for_status()
        logger.info("Logs retrieved")
        return response.json()
    except requests.exceptions.RequestException as e:
        logger.error(f"Log retrieval failed - {str(e)}")
        raise HTTPException(status_code=response.status_code, detail=response.json())

@router.get("/logs/{log_id}")
def read_log(log_id: int):
    try:
        response = requests.get(f"http://localhost:8002/logs/{log_id}")
        response.raise_for_status()
        logger.info(f"Log retrieved: {log_id}")
        return response.json()
    except requests.exceptions.RequestException as e:
        logger.error(f"Log retrieval failed: {log_id} - {str(e)}")
        raise HTTPException(status_code=response.status_code, detail=response.json())
