@echo off
echo ========================================
echo Kotatsu Sync Server - Stopping Services
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

echo Stopping Kotatsu Sync Server...
echo.

:: Stop the services
docker-compose down

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo SUCCESS! Services have been stopped.
    echo ========================================
    echo.
    echo Your data is preserved in Docker volumes.
    echo To start again, run: start.bat or docker-compose up -d
    echo.
    echo To completely remove all data, run: docker-compose down -v
    echo.
) else (
    echo.
    echo ERROR: Failed to stop services!
    echo Check the error messages above.
    echo.
)

pause