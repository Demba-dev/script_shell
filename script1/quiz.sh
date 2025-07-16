#!/bin/bash

score=0
total=3

echo "🧠 Bienvenue dans le Quiz Bash !"
echo "----------------------------------"
echo ""

# Question 1
echo "1) Quel est le créateur du système Linux ?"
echo "   a) Richard Stallman"
echo "   b) Linus Torvalds"
echo "   c) Bill Gates"
read -p "Votre réponse (a/b/c) : " rep1
if [[ "$rep1" == "b" ]]; then
    echo "✅ Bonne réponse !"
    ((score++))
else
    echo "❌ Mauvaise réponse. C'était b) Linus Torvalds."
fi
echo ""

# Question 2
echo "2) Quelle commande sert à lister les fichiers dans un dossier ?"
echo "   a) cd"
echo "   b) ls"
echo "   c) pwd"
read -p "Votre réponse (a/b/c) : " rep2
if [[ "$rep2" == "b" ]]; then
    echo "✅ Bonne réponse !"
    ((score++))
else
    echo "❌ Mauvaise réponse. C'était b) ls."
fi
echo ""

# Question 3
echo "3) Quelle extension est utilisée pour les scripts Bash ?"
echo "   a) .sh"
echo "   b) .bashrc"
echo "   c) .txt"
read -p "Votre réponse (a/b/c) : " rep3
if [[ "$rep3" == "a" ]]; then
    echo "✅ Bonne réponse !"
    ((score++))
else
    echo "❌ Mauvaise réponse. C'était a) .sh."
fi
echo ""

# Résultat
echo "----------------------------------"
echo "🎯 Vous avez obtenu $score / $total points !"

if [[ $score -eq $total ]]; then
    echo "🔥 Parfait, tu es un expert Bash !"
elif [[ $score -ge 2 ]]; then
    echo "👏 Pas mal du tout !"
else
    echo "📘 Tu peux encore t'entraîner 😉"
fi

