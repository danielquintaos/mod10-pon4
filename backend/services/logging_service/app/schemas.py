from pydantic import BaseModel
from datetime import datetime

class LogBase(BaseModel):
    user_id: int
    action: str
    details: str

class LogCreate(LogBase):
    pass

class LogInDB(LogBase):
    id: int
    timestamp: datetime

    class Config:
        orm_mode: True

class LogOut(LogBase):
    id: int
    timestamp: datetime

    class Config:
        orm_mode: True
