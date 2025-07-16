#!/bin/bash

echo "===== MENU PRINCIPAL ====="
echo "1) Dire bonjour"
echo "2) Afficher la date"
echo "3) Afficher le répertoire courant"
echo "4) Quitter"
echo "=========================="

read -p "Fais ton choix (1-4) : " choix

case $choix in
    1)
        echo "👋 Bonjour Demba !"
        ;;
    2)
        echo "📅 La date d'aujourd'hui est : $(date)"
        ;;
    3)
        echo "📁 Tu es ici : $(pwd)"
        ;;
    4)
        echo "👋 Au revoir !"
        exit 0
        ;;
    *)
        echo "❌ Choix invalide. Tape un nombre entre 1 et 4."
        ;;
esac

