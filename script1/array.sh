#!/bin/bash

# Déclaration d'un tableau
noms=("Demba" "Awa" "Fatou" "Cheick")

# Affichage de tout le tableau
echo "📋 Liste des noms : ${noms[@]}"

# Longueur du tableau
echo "🔢 Il y a ${#noms[@]} personnes dans le tableau."

# Accès à un élément (indice commence à 0)
echo "👤 Le premier nom est : ${noms[0]}"
echo "👤 Le dernier nom est : ${noms[${#noms[@]}-1]}"

# Boucle sur les éléments
echo "🔁 Parcours du tableau :"
for nom in "${noms[@]}"; do
    echo "- $nom"
done

# Ajouter un nom
noms+=("Ousmane")
echo "✅ 'Ousmane' a été ajouté. Nouvelle liste : ${noms[@]}"

# Supprimer un élément (exemple : index 1)
unset noms[1]
echo "❌ Après suppression de l'index 1 : ${noms[@]}"

