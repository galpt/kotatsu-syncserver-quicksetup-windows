@echo off
echo ========================================
echo Kotatsu Sync Server - Docker Compose
echo ========================================
echo.

:: Change to the directory where this script is located
cd /d "%~dp0"

:: Check if Docker is running
docker version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker is not running or not installed!
    echo Please start Docker Desktop and try again.
    pause
    exit /b 1
)

echo Docker is running...
echo.

:: Check if docker-compose.yml exists
if not exist "docker-compose.yml" (
    echo ERROR: docker-compose.yml not found!
    echo Please make sure you're in the correct directory.
    pause
    exit /b 1
)

echo Starting Kotatsu Sync Server...
echo.

:: Start the services
docker-compose up -d

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo SUCCESS! Services are starting up...
    echo ========================================
    echo.
    echo Sync Server will be available at: http://localhost:8081
    echo.
    echo Please wait 1-2 minutes for MySQL to fully initialize.
    echo You can check the status with: docker-compose logs -f
    echo.
    echo To configure Kotatsu app:
    echo 1. Go to Options ^> Settings ^> Services ^> Synchronization
    echo 2. Set server address to: http://YOUR_COMPUTER_IP:8081
    echo 3. Create an account with email and password
    echo.
    echo To stop the services, run: docker-compose down
    echo.
) else (
    echo.
    echo ERROR: Failed to start services!
    echo Check the error messages above.
    echo.
)

pause