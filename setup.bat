@echo off
echo ============================================
echo   Credential Stuffing Simulator - Setup
echo ============================================

where python >nul 2>&1
IF ERRORLEVEL 1 (
    echo [ERROR] Python is not installed or not in PATH.
    echo         Please install Python 3.8+ from https://python.org
    pause
    exit /b 1
)

echo [OK] Python found:
python --version

IF NOT EXIST "venv" (
    echo [...] Creating virtual environment...
    python -m venv venv
    echo [OK] Virtual environment created.
) ELSE (
    echo [OK] Virtual environment already exists.
)

echo [...] Activating virtual environment...
call venv\Scripts\activate.bat

echo [...] Upgrading pip...
python -m pip install --upgrade pip -q

echo [...] Installing dependencies...
pip install -r requirements.txt -q
echo [OK] Dependencies installed.

echo.
echo ============================================
echo   Setup complete!
echo   Run the app with:  run.bat
echo ============================================
pause
