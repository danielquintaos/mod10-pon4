from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session
import requests
from . import user_crud
from .database import get_db
from .schemas import UserCreate, UserOut, Token
import logging

router = APIRouter()

logger = logging.getLogger("gateway_logger")

@router.post("/signup", response_model=UserOut)
def create_user(user: UserCreate, db: Session = Depends(get_db)):
    db_user = user_crud.get_user_by_email(db, email=user.email)
    if db_user:
        logger.warning(f"Signup failed for email: {user.email} - Email already registered")
        raise HTTPException(status_code=400, detail="Email already registered")
    new_user = user_crud.create_user(db=db, user=user)
    logger.info(f"User created: {new_user.email}")
    return new_user

@router.post("/login", response_model=Token)
def login_for_access_token(db: Session = Depends(get_db), form_data: OAuth2PasswordRequestForm = Depends()):
    user = user_crud.authenticate_user(db, form_data.username, form_data.password)
    if not user:
        logger.warning(f"Login failed for username: {form_data.username} - Incorrect username or password")
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token = user_crud.create_access_token(data={"sub": user.username})
    logger.info(f"User logged in: {user.username}")
    return {"access_token": access_token, "token_type": "bearer"}
