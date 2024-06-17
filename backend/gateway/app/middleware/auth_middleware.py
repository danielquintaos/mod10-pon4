from fastapi import Request, HTTPException
from fastapi.security import OAuth2PasswordBearer
from jose import JWTError, jwt
import os
from starlette.middleware.base import BaseHTTPMiddleware

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")
SECRET_KEY = os.getenv("SECRET_KEY")
ALGORITHM = os.getenv("ALGORITHM")

class AuthMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request: Request, call_next):
        if request.url.path in ["/users/login", "/users/signup", "/"]:
            response = await call_next(request)
            return response
        token = request.headers.get("Authorization")
        if token:
            try:
                payload = jwt.decode(token.split(" ")[1], SECRET_KEY, algorithms=[ALGORITHM])
                request.state.user = payload
            except JWTError:
                raise HTTPException(status_code=401, detail="Invalid token")
        else:
            raise HTTPException(status_code=401, detail="Authorization header missing")
        response = await call_next(request)
        return response
