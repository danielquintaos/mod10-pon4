from fastapi import FastAPI
from . import models
from .database import engine
from .routes import router as log_router

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

app.include_router(log_router, prefix="/logs")
