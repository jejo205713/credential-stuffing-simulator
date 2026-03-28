#!/usr/bin/env bash
set -e

echo "============================================"
echo "  Credential Stuffing Simulator - Starting"
echo "============================================"

if [ ! -d "venv" ]; then
    echo "[ERROR] Virtual environment not found."
    echo "        Please run: bash setup.sh first."
    exit 1
fi

source venv/bin/activate

echo "[OK] Virtual environment activated."
echo "[OK] Starting Flask server on http://127.0.0.1:5000"
echo ""
echo "  Open your browser at: http://127.0.0.1:5000"
echo "  Press Ctrl+C to stop."
echo "============================================"
echo ""

python app.py
