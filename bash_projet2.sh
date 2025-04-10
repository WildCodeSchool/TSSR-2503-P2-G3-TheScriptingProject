#!/bin/bash

#Squelette projet 2 => sprint 1 

# Faire des logs a chaques actions pour garder une trace => journalisation log_evt.log
# Pour le serveur windows, dans C:\Windows\System32\LogFiles
# Pour le serveur Linux, dans /var/log
# <Date>-<Heure>-<Utilisateur>-<Evenement>
# Avec :
# <Date> : Date de l’evenement au format yyyymmdd
# <Heure> : Heure de l'événement au format hhmmss
# <Utilisateur> : Nom de l’utilisateur courant exécutant le script
# <Evenement> : Action effectuée (à définir par le groupe)


#Fonction 1 :
# - Création compte utilisateur local 
# - Changement de mot de passe 
# - Suppression compte utilisateur local
# - Désactivation compte utilisateur local 

function utilisateur_local() 
{
    user=$1
    echo "Que voulez vous faire Mister ?"
    echo "1 : création d'un compte utilisateur local."
    echo "2 : Changement de mot de passe."
    echo "3 : Suppression compte utilisateur local."
    echo "4 : Désactivation compte utilisateur local."
    read -r choix
    case $choix in
        1) 
        adduser "$user" ;;
        2) 
        passwd "$user" ;;
        3) 
        deluser "$user" ;;
        4)
        usermod -L "$user" ;;
        #chage -E 0 username
    esac
}

#Fonction 2 : 
# - Ajout à un groupe local 
# - Sortie d'un groupe local 

#Fonction 3 : 
# - Arret 
# - Redémarrage 
# - Vérouillage 

#Fonction 4 : 
# - Mise-à-jour du système 

#Fonction 5 :
# - Création de répertoire 
# - Modification de repertoire 
# - -Suppression de répertoire 

#Fonction 6 : 
# - Prise en main a distance (CLI)

# Fonction 7 : 
# - Définition de règle de pare-feu 
# - Activation du pare-feu
# - Désactivation du pare feu 

#Fonction 8 : 
# - Installation de logiciel
# - Désinstallation de logiciel 
# - Execution de script sur la machine distante 

#Fonction 9 :
# - Date de dernière connexion d’un utilisateur
# - Date de dernière modification du mot de passe
# - Liste des sessions ouvertes par l'utilisateur

#Fonction 10 : 
# - Groupe d’appartenance d’un utilisateur
# - Historique des commandes exécutées par l'utilisateur

#Fonction 11 : 
# - Droits/permissions de l’utilisateur sur un dossier
# - Droits/permissions de l’utilisateur sur un fichier

#Fonction 12 : 
# - Version de l'OS

#Fonction 13 : 
# - Nombre de disque
# - Partition (nombre, nom, FS, taille) par disque

#Fonction 14 : 
# - Liste des applications/paquets installées
# - Liste des services en cours d'execution
# - Liste des utilisateurs locaux

#Fonction 15 : 
# - Type de CPU, nombre de coeurs, etc.
# - Mémoire RAM totale
# - Utilisation de la RAM
# - Utilisation du disque
# - Utilisation du processeur

#Fonction 16 : 
# - Recherche des evenements dans le fichier log_evt.log pour un utilisateur
# - Recherche des evenements dans le fichier log_evt.log pour un ordinateur
