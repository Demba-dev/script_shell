#!/bin/bash

# Nom du fichier log
LOGFILE="log.txt"

# Demande à l'utilisateur un message
echo "Entrez un message à enregistrer dans le journal :"
read MESSAGE

# Date et heure actuelles
NOW=$(date '+%Y-%m-%d %H:%M:%S')

# Enregistrement dans le fichier avec horodatage
echo "[$NOW] $MESSAGE" >> $LOGFILE

echo "✅ Message enregistré dans $LOGFILE"

