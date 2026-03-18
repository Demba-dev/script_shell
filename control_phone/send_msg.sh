#!/bin/bash
# Syntaxe : ./send_msg.sh "Mon message"
SERVER_IP="127.0.0.1" # Changez par l'IP du serveur cible
PORT=1234

echo "$1" | nc -w 1 $SERVER_IP $PORT
