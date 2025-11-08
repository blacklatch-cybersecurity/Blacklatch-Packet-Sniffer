from flask import Flask, render_template
import os

app = Flask(__name__, template_folder='templates')

def read_packets(n=150):
    """Read the last n lines from packets.log."""
    log_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'packets.log'))
    if not os.path.exists(log_path):
        return ["No packets captured yet."]
    with open(log_path, 'r') as f:
        lines = [line.strip() for line in f if line.strip()]
    return lines[-n:]

@app.route('/')
def index():
    packets = read_packets()
    return render_template('index.html', packets=packets)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8082, debug=True)
