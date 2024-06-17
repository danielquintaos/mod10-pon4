from pydantic import BaseModel

class ImageBase(BaseModel):
    filename: str

class ImageCreate(ImageBase):
    pass

class ImageInDB(ImageBase):
    id: int
    user_id: int
    filtered_filename: str

    class Config:
        orm_mode: True

class ImageOut(ImageBase):
    id: int
    filtered_filename: str

    class Config:
        orm_mode: True
