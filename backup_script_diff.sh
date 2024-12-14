#!/bin/bash

# Variables
SOURCE_DIR="/home/franco/Documents/Ansible"
DEST_DIR="NFFfolefack@37.60.244.227:~/Backup/backup_diff_$(date +%F)"
BASE_BACKUP="NFFfolefack@37.60.244.227:~/Backup/backup_full"
LOG_FILE="/home/franco/Documents/Ansible/backup.log"

# Vérifier si le répertoire source existe
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Le répertoire source n'existe pas : $SOURCE_DIR" >> $LOG_FILE
    exit 1
fi

# Sauvegarde différentielle
if rsync -avz --delete --link-dest="$BASE_BACKUP" "$SOURCE_DIR/" "$DEST_DIR"; then
    echo "Sauvegarde différentielle faite le $(date)" >> $LOG_FILE
else
    echo "Erreur lors de la sauvegarde différentielle le $(date)" >> $LOG_FILE
    exit 1
fi
