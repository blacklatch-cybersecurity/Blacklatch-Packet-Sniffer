#!/bin/bash
# ==================================================
# 🛰️ Blacklatch Packet Sniffer — Auto Launcher
# ==================================================

PROJECT_DIR="/root/cyber-projects/packet-sniffer"
VENV_DIR="$PROJECT_DIR/venv"
LOG_FILE="$PROJECT_DIR/packets.log"

echo "🚀 Starting Blacklatch Packet Sniffer..."

# 1️⃣ Move to project directory
cd "$PROJECT_DIR" || { echo "❌ Project directory not found."; exit 1; }

# 2️⃣ Create virtual environment if missing
if [ ! -d "$VENV_DIR" ]; then
    echo "⚙️ Creating Python virtual environment..."
    python3 -m venv "$VENV_DIR"
fi

# 3️⃣ Activate venv
source "$VENV_DIR/bin/activate"

# 4️⃣ Ensure Flask is installed
pip show flask >/dev/null 2>&1 || {
    echo "📦 Installing Flask..."
    pip install flask >/dev/null
}

# 5️⃣ Kill any old sniffer or Flask processes
echo "🧹 Cleaning up old processes..."
sudo pkill -f sniffer.py >/dev/null 2>&1
sudo pkill -f app.py >/dev/null 2>&1

# 6️⃣ Start sniffer backend in background
echo "📡 Starting packet capture backend..."
sudo python3 sniffer.py > "$LOG_FILE" 2>&1 &

# 7️⃣ Start Flask web UI
echo "🌐 Launching web dashboard..."
python3 app/app.py

# 8️⃣ When Flask stops, clean up sniffer
echo "🧹 Stopping background sniffer..."
sudo pkill -f sniffer.py >/dev/null 2>&1

echo "✅ Blacklatch Packet Sniffer shut down cleanly."
