cat > /root/cyber-projects/packet-sniffer/app/app.py <<'PY'
from flask import Flask, render_template
import os

app = Flask(__name__, template_folder='templates')

def get_packets(n=100):
    # locate packets.log one level up from this app folder
    log_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'packets.log'))
    if not os.path.exists(log_path):
        return []
    # read last n non-empty lines
    with open(log_path, 'r') as f:
        lines = [l for l in (ll.rstrip() for ll in f) if l]
    return lines[-n:]

@app.route('/')
def home():
    packets = get_packets()
    return render_template('index.html', packets=packets)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8082, debug=True)
PY
