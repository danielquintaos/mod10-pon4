from fastapi import FastAPI
from . import models
from .database import engine
from .routes import router as image_router

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

app.include_router(image_router, prefix="/images")
