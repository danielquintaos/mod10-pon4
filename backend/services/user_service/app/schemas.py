from pydantic import BaseModel

class UserBase(BaseModel):
    username: str
    email: str

class UserCreate(UserBase):
    password: str

class UserUpdate(UserBase):
    password: str

class UserInDB(UserBase):
    id: int
    hashed_password: str

    class Config:
        orm_mode = True

class UserOut(UserBase):
    id: int

    class Config:
        orm_mode = True

class Token(BaseModel):
    access_token: str
    token_type: str
