#!/bin/bash

# Variables
SOURCE_DIR="/home/franco/Documents/Ansible"  # Répertoire source à sauvegarder
DEST_DIR="NFFfolefack@37.60.244.227:~/Backup/backup_full"  # Répertoire distant pour la sauvegarde complète
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")  # Horodatage
LOG_FILE="/home/franco/Documents/Ansible/backup.log"  # Fichier de journalisation

# Vérifier si le répertoire source existe
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Le répertoire source n'existe pas : $SOURCE_DIR"
    exit 1
fi

# Commande rsync pour une sauvegarde complète
rsync -avz --delete "$SOURCE_DIR/" "$DEST_DIR" > "$LOG_FILE" 2>&1

# Vérifier le succès
if [ $? -eq 0 ]; then
    echo "Sauvegarde complète réussie. Log : $LOG_FILE"
else
    echo "Erreur lors de la sauvegarde complète. Voir le log : $LOG_FILE"
    exit 1
fi
