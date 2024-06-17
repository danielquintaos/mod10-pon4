import logging
from fastapi import FastAPI, Request
from starlette.middleware.cors import CORSMiddleware
from .routes import user_routes, image_routes, log_routes
from .logging_handler import APILoggingHandler

# Create a logger
logger = logging.getLogger("gateway_logger")
logger.setLevel(logging.INFO)

# Create a file handler
file_handler = logging.FileHandler("gateway.log")
file_handler.setLevel(logging.INFO)

# Create an API logging handler
api_handler = APILoggingHandler("http://localhost:8002/logs/")
api_handler.setLevel(logging.INFO)

# Create a logging format
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
file_handler.setFormatter(formatter)
api_handler.setFormatter(formatter)

# Add the handlers to the logger
logger.addHandler(file_handler)
logger.addHandler(api_handler)

app = FastAPI()

# CORS configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Update this with your allowed origins
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(user_routes.router, prefix="/users", tags=["users"])
app.include_router(image_routes.router, prefix="/images", tags=["images"])
app.include_router(log_routes.router, prefix="/logs", tags=["logs"])

@app.middleware("http")
async def log_requests(request: Request, call_next):
    logger.info(f"Request: {request.method} {request.url}")
    response = await call_next(request)
    logger.info(f"Response status: {response.status_code}")
    return response

@app.get("/")
def read_root():
    return {"message": "Welcome to the Black and White Image Filtering API"}
