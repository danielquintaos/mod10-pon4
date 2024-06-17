from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware
from .routes import user_routes, image_routes, log_routes
from .middleware.auth_middleware import AuthMiddleware
from .middleware.error_handler import ErrorHandlerMiddleware

app = FastAPI()

# CORS configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Update this with your allowed origins
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include middleware
app.add_middleware(AuthMiddleware)
app.add_middleware(ErrorHandlerMiddleware)

# Include routers
app.include_router(user_routes.router, prefix="/users", tags=["users"])
app.include_router(image_routes.router, prefix="/images", tags=["images"])
app.include_router(log_routes.router, prefix="/logs", tags=["logs"])

@app.get("/")
def read_root():
    return {"message": "Welcome to the Black and White Image Filtering API"}
