import psutil
import socket
import os as os_module
import pwd

def get_process_name(pid):
    try:
        process = psutil.Process(int(pid))
        return process.name()
    except (psutil.NoSuchProcess, ValueError):
        return "N/A"

def get_remote_connections():
    connections = []
    for conn in psutil.net_connections(kind='inet4'):
        if conn.status == 'ESTABLISHED' and conn.raddr and conn.raddr.ip:
            remote_ip = conn.raddr.ip
            remote_port = conn.raddr.port
            local_ip = conn.laddr.ip
            local_port = conn.laddr.port
            pid = conn.pid or "N/A"
            connections.append((local_ip, local_port, remote_ip, remote_port, pid))
    return connections

def get_username(uid):
    try:
        return pwd.getpwuid(uid).pw_name
    except KeyError:
        return "N/A"

def main():
    connections = get_remote_connections()
    print("Local IP       Port       Remote IP        Port          PID     Name             User")
    print("---------------------------------------------------------------------------------------")
    for conn in connections:
        local_ip, local_port, remote_ip, remote_port, pid = conn
        process_name = get_process_name(pid)
        user = get_username(psutil.Process(int(pid)).uids().real) if pid != "N/A" else "N/A"
        print(f"{local_ip: <15}{local_port: <11}{remote_ip: <18}{remote_port: <13}{pid: <7}{process_name: <18}{user}")

if __name__ == "__main__":
    if os_module.geteuid() == 0:
        main()
    else:
        print("Este script requer privilégios de superusuário (root). Execute-o com 'sudo'.")

