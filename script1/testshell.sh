#!/bin/bash

# Fonction pour demander un prénom non vide
get_first_name() {
    while true; do
        echo "What is your first name?"
        read FIRST_NAME
        if [ -n "$FIRST_NAME" ]; then
            break
        else
            echo "First name cannot be empty. Please try again."
        fi
    done
}

# Fonction pour demander un nom non vide
get_last_name() {
    while true; do
        echo "What is your last name?"
        read LAST_NAME
        if [ -n "$LAST_NAME" ]; then
            break
        else
            echo "Last name cannot be empty. Please try again."
        fi
    done
}

# Appel des fonctions
get_first_name
get_last_name

# Affichage et sauvegarde
echo "Hello $FIRST_NAME $LAST_NAME 👋"
echo "$FIRST_NAME $LAST_NAME" >> noms.txt
echo "Saved in noms.txt ✅"

