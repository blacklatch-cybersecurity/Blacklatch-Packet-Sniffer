#!/usr/bin/env python3
import subprocess

# Live tcpdump output piped in real-time
cmd = ["sudo", "tcpdump", "-l", "-n", "-i", "any"]
process = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)

# Write every line to log
with open("packets.log", "a") as f:
    for line in process.stdout:
        f.write(line)
        f.flush()
