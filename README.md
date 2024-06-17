# Black and White Image Filter Application

## Overview

The Black and White Image Filter Application is a Flutter-based mobile application that allows users to sign up, log in, upload images, and view black-and-white filtered versions of their uploaded images. The backend is powered by FastAPI, providing APIs for user authentication, image processing, and logging user activities.

## Features

- User Authentication (Sign Up, Sign In)
- Image Upload
- Image Download and View
- Black and White Image Filtering
- Logging user actions

## Project Structure

### Backend

The backend is divided into multiple microservices, each with specific responsibilities:

1. **User Service**: Manages user authentication and CRUD operations.
2. **Image Service**: Handles image upload, processing, and download.
3. **Logging Service**: Logs user actions such as sign up, sign in, and image uploads.

### Frontend

The frontend is built using Flutter and consists of several pages:

1. **Sign Up Page**
2. **Sign In Page**
3. **Home Page**
4. **Image Upload Page**
5. **Image Download Page**

## Technologies Used

- **Frontend**: Flutter, Provider for state management
- **Backend**: FastAPI, SQLAlchemy, PostgreSQL, Alembic for migrations
- **Other Tools**: Docker for containerization, GitHub Actions for CI/CD

## Installation

### Prerequisites

- Flutter SDK
- Docker
- Python 3.8+
- PostgreSQL

### Backend Setup

1. **Clone the repository**

```sh
git clone https://github.com/danielquintaos/mod10-pon3.git
cd mod10-pon3
```

2. **Set up the backend**

```sh
cd backend
docker-compose up --build
```

### Frontend Setup

1. **Navigate to the frontend directory**

```sh
cd frontend
```

2. **Install dependencies**

```sh
flutter pub get
```

3. **Run the application**

```sh
flutter run
```

## Usage

### Backend

The backend services will be available at the following URLs:
- **User Service**: `http://localhost:8001`
- **Image Service**: `http://localhost:8002`
- **Logging Service**: `http://localhost:8003`
- **API Gateway**: `http://localhost:8000`

### Frontend

1. **Sign Up**
   - Open the app and navigate to the Sign Up page.
   - Enter your username, email, and password, then click "Sign Up".

2. **Sign In**
   - Navigate to the Sign In page.
   - Enter your username and password, then click "Sign In".

3. **Upload Image**
   - After signing in, navigate to the Upload Image page.
   - Choose an image from your device and upload it.

4. **View Images**
   - Navigate to the View Images page to see the list of your uploaded images along with their black-and-white filtered versions.

## Running Tests

### Backend

To run the backend tests, use the following command:

```sh
cd mod10-pon3
pytest
```

### Frontend

To run the frontend tests, use the following command:

```sh
cd black_and_white_filter_frontend
flutter test
```

## API Documentation

The backend API documentation is automatically generated by FastAPI and available at `http://localhost:8000/docs`.