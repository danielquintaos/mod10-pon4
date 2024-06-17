from fastapi import Request, HTTPException
from starlette.middleware.base import BaseHTTPMiddleware
from starlette.responses import JSONResponse

class ErrorHandlerMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request: Request, call_next):
        try:
            response = await call_next(request)
            return response
        except HTTPException as ex:
            return JSONResponse(status_code=ex.status_code, content={"detail": ex.detail})
        except Exception as ex:
            return JSONResponse(status_code=500, content={"detail": "Internal server error"})
