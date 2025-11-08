#!/bin/bash
cd ~/cyber-projects/packet-sniffer || exit
# create venv if missing
[ -d venv ] || python3 -m venv venv
# activate
source venv/bin/activate
echo "✅ Virtual environment activated at: $(pwd)/venv"
echo "To run your Flask app: python3 app/app.py"
