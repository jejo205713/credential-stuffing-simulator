#!/usr/bin/env bash
set -e

echo "============================================"
echo "  Credential Stuffing Simulator - Setup"
echo "============================================"

# Check Python 3
if ! command -v python3 &> /dev/null; then
    echo "[ERROR] Python 3 is not installed. Please install Python 3.8+ and retry."
    exit 1
fi

PYTHON_VERSION=$(python3 -c 'import sys; print(sys.version_info.major * 10 + sys.version_info.minor)')
if [ "$PYTHON_VERSION" -lt 38 ]; then
    echo "[ERROR] Python 3.8 or higher is required."
    exit 1
fi

echo "[OK] Python 3 found: $(python3 --version)"

# Create virtual environment
if [ ! -d "venv" ]; then
    echo "[...] Creating virtual environment..."
    python3 -m venv venv
    echo "[OK] Virtual environment created."
else
    echo "[OK] Virtual environment already exists."
fi

# Activate venv
source venv/bin/activate

# Upgrade pip silently
pip install --upgrade pip -q

# Install dependencies
echo "[...] Installing dependencies..."
pip install -r requirements.txt -q
echo "[OK] Dependencies installed."

echo ""
echo "============================================"
echo "  Setup complete!"
echo "  Run the app with:  bash run.sh"
echo "============================================"
