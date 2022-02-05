from logging.config import listen
import socket, threading, time

SERVER_ADDR = "127.0.0.1"
SERVER_PORT = 8080
BUFFER_SIZE = 1024 * 128 #128KB max size

server_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_sock.bind((SERVER_ADDR, SERVER_PORT))

def listening_screen():
    while True:
        print("|-   |", end="\r")
        time.sleep(1)
        print("|--  |", end="\r")
        time.sleep(1)
        print("|--- |", end="\r")
        time.sleep(1)
        print("|----|", end="\r")
        time.sleep(1)


def startServer():
    server_sock.listen(5)
    print()
    print(f"Server is listening on {SERVER_ADDR}:{SERVER_PORT}")
    print()
    listening = threading.Thread(target=listening_screen)
    # listening.start()
    while True:
        client_sock, addr = server_sock.accept()
        # listening.join()
        client = threading.Thread(target=handleClient,args=(client_sock,addr))
        client.start()
        

def handleClient(client_sock,addr):
    print(f"Connection Recieved From: {addr[0]}:{addr[1]}")

    curDir = client_sock.recv(BUFFER_SIZE).decode()
    print(curDir + "# ", end="")

    while True:
        user_in = input()
        if user_in == 'exit':
            client_sock.send(user_in.encode())
            break
        elif user_in == '':
            print("#")
        else:
            client_sock.send(user_in.encode())
            serv_resp = client_sock.recv(BUFFER_SIZE).decode()
            print(serv_resp, end="")

    client_sock.close()
    

if __name__ == "__main__":
    print("[SERVER] Server is starting...")
    startServer()
