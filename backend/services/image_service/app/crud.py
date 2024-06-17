from sqlalchemy.orm import Session
from . import models, schemas

def get_image(db: Session, image_id: int):
    return db.query(models.Image).filter(models.Image.id == image_id).first()

def create_image(db: Session, image: schemas.ImageCreate, user_id: int, filtered_filename: str):
    db_image = models.Image(**image.dict(), user_id=user_id, filtered_filename=filtered_filename)
    db.add(db_image)
    db.commit()
    db.refresh(db_image)
    return db_image
