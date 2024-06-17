from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from . import models, schemas, crud
from .database import SessionLocal

router = APIRouter()

# Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/logs/", response_model=schemas.LogOut)
def create_log(log: schemas.LogCreate, db: Session = Depends(get_db)):
    return crud.create_log(db=db, log=log)

@router.get("/logs/", response_model=list[schemas.LogOut])
def read_logs(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    logs = crud.get_logs(db, skip=skip, limit=limit)
    return logs

@router.get("/logs/{log_id}", response_model=schemas.LogOut)
def read_log(log_id: int, db: Session = Depends(get_db)):
    db_log = crud.get_log(db, log_id=log_id)
    if db_log is None:
        raise HTTPException(status_code=404, detail="Log not found")
    return db_log
