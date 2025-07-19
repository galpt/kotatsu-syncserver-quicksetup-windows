@echo off
echo ========================================
echo Kotatsu Sync Server - View Logs
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

echo Showing logs for all services...
echo Press Ctrl+C to stop viewing logs.
echo.

:: Show logs with follow option
docker-compose logs -f

echo.
echo Logs viewing stopped.
pause