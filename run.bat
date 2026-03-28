@echo off
echo ============================================
echo   Credential Stuffing Simulator - Starting
echo ============================================

IF NOT EXIST "venv" (
    echo [ERROR] Virtual environment not found.
    echo         Please run setup.bat first.
    pause
    exit /b 1
)

call venv\Scripts\activate.bat
echo [OK] Virtual environment activated.
echo [OK] Starting Flask server on http://127.0.0.1:5000
echo.
echo   Open your browser at: http://127.0.0.1:5000
echo   Press Ctrl+C to stop.
echo ============================================
echo.

python app.py
pause
