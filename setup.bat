@echo off
REM CI/CD Demo App - Setup Script for Windows

setlocal enabledelayedexpansion

echo.
echo ============================================================
echo     CI/CD Demo App - Setup Script
echo ============================================================
echo.

REM Check if Git is installed
echo Checking prerequisites...
git --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Git is not installed
    echo Download from: https://git-scm.com/downloads
    pause
    exit /b 1
)
echo [OK] Git found

REM Check if Node is installed
node --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Node.js is not installed
    echo Download from: https://nodejs.org/
    pause
    exit /b 1
)
echo [OK] Node.js found: %NODEVER%

REM Check if npm is installed
npm --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] npm is not installed
    pause
    exit /b 1
)
echo [OK] npm found

REM Check if Docker is installed
docker --version >nul 2>&1
if errorlevel 1 (
    echo [WARNING] Docker is not installed (optional)
    echo Download from: https://www.docker.com/products/docker-desktop
) else (
    echo [OK] Docker found
)

REM Install dependencies
echo.
echo Installing dependencies...
call npm install
if errorlevel 1 (
    echo [ERROR] Failed to install dependencies
    pause
    exit /b 1
)
echo [OK] Dependencies installed

REM Run tests
echo.
echo Running tests...
call npm test
if errorlevel 1 (
    echo [WARNING] Some tests failed
) else (
    echo [OK] Tests passed
)

REM Lint check
echo.
echo Checking code style...
call npm run lint:check
if errorlevel 1 (
    echo [WARNING] Some linting issues found. Run: npm run lint
) else (
    echo [OK] Code style check passed
)

REM Summary
echo.
echo ============================================================
echo              Setup Complete!
echo ============================================================
echo.
echo Next steps:
echo 1. Start the app:        npm start
echo 2. Test the app:         curl http://localhost:3000/api/users
echo 3. Create GitHub repo
echo 4. Push code to GitHub
echo 5. Add Docker secrets in GitHub settings
echo 6. Watch workflows run in Actions tab!
echo.
echo Useful commands:
echo   npm start           - Start server
echo   npm test            - Run tests
echo   npm run lint        - Fix code style
echo   npm run docker:build - Build Docker image
echo   npm run docker:run   - Run Docker container
echo.
echo Read README.md for full documentation
echo Read QUICKSTART.md for quick start guide
echo.
echo Happy coding!
echo.
pause
