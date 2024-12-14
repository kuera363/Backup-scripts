#!/bin/bash

# Variables
BACKUP_DIR="NFFfolefack@37.60.244.227:~/Backup"
LOG_FILE="/home/franco/Documents/Ansible/cleanup.log"

# Vérifier la connexion SSH
if ! ssh -q NFFfolefack@37.60.244.227 exit; then
    echo "Erreur de connexion à NFFfolefack" >> $LOG_FILE
    exit 1
fi

# Supprimer les sauvegardes différentielles âgées de plus de 7 jours
if ssh NFFfolefack@37.60.244.227 "find $BACKUP_DIR/backup_diff_* -mtime +7 -type d -exec rm -rf {} +"; then
    echo "Nettoyage des sauvegardes différentielles effectué." >> $LOG_FILE
else
    echo "Erreur lors du nettoyage des sauvegardes différentielles." >> $LOG_FILE
fi

# Supprimer les sauvegardes hebdomadaires (complètes) âgées de plus de 4 semaines
if ssh NFFfolefack@37.60.244.227 "find $BACKUP_DIR/backup_full_* -mtime +28 -type d -exec rm -rf {} +"; then
    echo "Nettoyage des sauvegardes hebdomadaires effectué." >> $LOG_FILE
else
    echo "Erreur lors du nettoyage des sauvegardes hebdomadaires." >> $LOG_FILE
fi

# Supprimer les sauvegardes mensuelles âgées de plus de 6 mois
if ssh NFFfolefack@37.60.244.227 "find $BACKUP_DIR/backup_full_*_$(date +%Y-%m) -mtime +180 -type d -exec rm -rf {} +"; then
    echo "Nettoyage des sauvegardes mensuelles effectué." >> $LOG_FILE
else
    echo "Erreur lors du nettoyage des sauvegardes mensuelles." >> $LOG_FILE
fi

# Enregistrement du log final
echo "Nettoyage effectué le $(date)" >> $LOG_FILE
