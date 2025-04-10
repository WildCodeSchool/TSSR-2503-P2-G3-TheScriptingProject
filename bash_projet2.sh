#!/bin/bash

# ------------------------------ #
#           FONCTIONS
# ------------------------------ #

function action_utilisateur_local() 
{
    #Fonction 1 :
    # - Création compte utilisateur local 
    # - Changement de mot de passe 
    # - Suppression compte utilisateur local
    # - Désactivation compte utilisateur local 
    echo "Que voulez vous faire ?"
    echo "--------------------"
    echo "1) Création d'un compte utilisateur"
    echo "2) Changement de mot de passe"
    echo "3) Suppression compte utilisateur"
    echo "4) Désactivation compte utilisateur"
    read -r choix
    case $choix in
        1) 
        echo "Client où créer l'utilisateur :"
        read -r client
        echo "Merci de donner un nom d'utilisateur"
        read -r nom_user
        ssh $client adduser "$nom_user" ;;
        2) 
        echo "Client où modifier le mot de passe :"
        read -r client
        echo "Merci de donner le nom d'utilisateur a qui vous voulez changer de mot de passe"
        read -r nom_passwd
        ssh $client passwd "$nom_passwd" ;;
        3) 
        echo "Client où supprimer un utilisateur :"
        read -r client
        echo "Merci de donner l'utilisateur que vous souhaitez supprimer"
        read -r user_del
        deluser "$user_del" ;;
        4)
        echo "Client où désactiver un compte utilisateur :"
        read -r client
        echo "Merci de donner l'utilisateur que vous voulez désactiver"
        read -r user_desactive
        usermod -L "$user_desactive" ;;
        #chage -E 0 username
    esac
}
#SSH
function action_groupe_local()
{
    #Fonction 2 : 
    # - Ajout à un groupe local 
    # - Sortie d'un groupe local 
    echo "Que voulez vous faire ?"
    echo "--------------------"
    echo "1) Ajout à un groupe local"
    echo "2) Sortie d'un groupe local"
    read -r choix_groupe_local 
    case $choix_groupe_local in 
        1)
        echo "A quel groupe voulez vous être ajouté ?"
        read -r group_add
        groupadd "$group_add" ;; 
        2)
        echo "Vous voulez sortir de quel groupe ?"
        read -r group_out
        usermod -r "$group_out" ;;
    esac
}
#SSH
function action_shut()
{
    #Fonction 3 : 
    # - Arret 
    # - Redémarrage 
    # - Vérouillage 
    echo "Que voulez vous faire ?"
    echo "--------------------"
    echo "1) Arret"
    echo "2) Redémarrage"
    echo "3) Verrouillage"
    read -r choix_shut
    case $choix_shut in
        1)
        poweroff ;; 
        2)
        reboot ;; 
        3) 
        nano /etc/passwd ;;
        esac
}
#SSH
function action_update()
{
    #Fonction 4 : 
    # - Mise-à-jour du système 
    apt update && apt upgrade -y 
}
#SSH
function action_repertoire()
{   
    #Fonction 5 :
    # - Création de répertoire 
    # - Modification de repertoire 
    # - -Suppression de répertoire 
    echo "Que voulez vous faire ?"
    echo "--------------------"
    echo "1) Création de répertoire"
    echo "2) Modification de répertoire"
    echo "3) Suppression de répertoire"
    read -r choix_repertoire
    case $choix_repertoire in 
        1)
        echo "Comment voulez vous nommer le repertoire ?"
        read -r name_dir
        mkdir "$name_dir" ;;
        2) 
        echo "Quel repertoire voulez vous modifier ?"
        read -r mod_dir
        echo "Quel est le nouveau nom ?"
        read -r new_dir
        mv "$mod_dir" "$new_dir" ;; 
        3) 
        echo "Quel repertoire voulez vous supprimer ?"
        read -r dir_del
        rmdir "$dir_del" ;;
        esac
}
#SSH
function action_prise_en_main()
{   
    #Fonction 6 : 
    # Cette fonction nécessite d'avoir une connexion ssh disponible (voir ssh.service et openssh)
    # - Prise en main a distance (CLI)
    user=$1
    computer=$2
    echo "Prise en main à distance"
    echo "--------------------"
    ssh "$user@$computer"
}
#SSH
function action_pare_feu()
{

    # Fonction 7 : 
    # Cette fonction nécessitera d'avoir installé UFW (uncomplicated firewall)
    # - Définition de règle de pare-feu 
    # - Activation du pare-feu
    # - Désactivation du pare feu 
    echo "Gestion du pare-feu"
    echo "--------------------"
    echo "Que voulez-vous faire ?"
    echo "1) Définir une règle de pare-feu"
    echo "2) Activer le pare-feu"
    echo "3) Désactiver le pare-feu"
    read -r choix
    case $choix in
    1)
        echo "Définition de règle"
        echo "Que voulez-vous faire ?"
        echo "1) Autoriser adresse"
        echo "2) Interdire adresse"
        read -r choix2
        case $choix2 in
        1)
            echo "Entrez adresse à autoriser"
            read -r adresse
            ufw allow from $adresse
            ;;
        2)
            echo "Entrez adresse à interdire"
            read -r adresse
            ufw deny from $adresse
            ;;
        esac
        ;;
    2)
        echo "Activation du pare-feu"
        ufw enable
        ;;
    3)
        echo "Désactivation du pare-feu"
        ufw disable
        ;;
    esac
}
#SSH
function action_logiciel()
{
    #Fonction 8 : 
    # - Installation de logiciel
    # - Désinstallation de logiciel 
    # - Execution de script sur la machine distante 
    # ./script.sh
    echo "Gestion de logiciels"
    echo "--------------------"
    echo "Que voulez-vous faire ?"
    echo "1) Installer un logiciel"
    echo "2) Supprimer un logiciel"
    echo "3) Exécuter un script"
    read -r choix
    case $choix in
    1)
        echo "Quel logiciel souhaitez-vous installer ?"
        read -r logiciel
        apt install $logiciel
        ;;
    2)
        echo "Remove"
        echo "Quel logiciel souhaitez-vous supprimer ?"
        read -r logiciel
        apt remove $logiciel
        ;;
    3)
        echo "Quel script souhaitez-vous lancer ?"
        read -r script
        ./$script
        ;;
    esac
}
#SSH
function info_compte()
{
    #Fonction 9 :
    # - Date de dernière connexion d’un utilisateur
    # Commande last $user
    # - Date de dernière modification du mot de passe
    # Commande passwd $user -S
    # - Liste des sessions ouvertes par l'utilisateur
    # Commande last $user
    user=$1
    echo "Informations sur le compte"
    echo "--------------------"
    echo "Que voulez-vous savoir ?"
    echo "1) Date de dernière connexion de $user"
    echo "2) Date de dernière modification du mot de passe de $user"
    echo "3) Liste des sessions de $user"
    read -r choix
    case $choix in
        1) 
            echo "Date de dernière connexion :"
            last $user | head -n 1
            ;;
        2)
            echo "Dernière modification de mot de passe :"
            passwd $user -S
            ;;
        3)
            echo "Sessions :"
            last $user
            ;;
    esac

}
#SSH
function info_groupe()
{
    #Fonction 10 : 
    # - Groupe d’appartenance d’un utilisateur
    # - Historique des commandes exécutées par l'utilisateur
    user=$1
    echo "Info groupe & commandes"
    echo "--------------------"
    echo "Que voulez-vous savoir ?"
    echo "1) Groupe de $user"
    echo "2) Historique commandes de $user"
    read -r choix
    case $choix in
        1)
            echo "Groupes de l'utilisateur :"
            groups $user
            ;;
        2)
            echo "Historiques des commandes :"
            cat /home/$user/.bash_history
            ;;
    esac
}
#SSH
function info_droits()
{
    #Fonction 11 : 
    # - Droits/permissions de l’utilisateur sur un dossier
    # Utiliser getfacl
    # - Droits/permissions de l’utilisateur sur un fichier
    user=$1
    target=$2
    echo "Info droits fichier/dossier"
    echo "--------------------"
    echo "Que voulez-vous savoir ?"
    echo "1) Droits de $user sur dossier $target"
    echo "2) Droits de $user sur fichier $target"
    read -r choix
    case $choix in
        1) 
            getfacl $target 
            ;;
        2)
            getfacl $target 
            ;;
    esac
}
#SSH
function info_os_version()
{
    #Fonction 12 : 
    # - Version de l'OS
    cat /etc/os-release | grep "PRETTY_NAME" | cut -d = -f 2 | tr -d '"'
}
#SSH
function info_disk_number()
{
    #Fonction 13 : 
    # - Nombre de disque
    # - Partition (nombre, nom, FS, taille) par disque
    # Nécessite d'avoir installé hwinfo
    echo "Que voulez-vous savoir ?"
    echo "--------------------"
    echo "1) Nombre de disques"
    echo "2) Partitions par disque"
    read -r choix
    case $choix in
    1)
        amount=$(hwinfo --disk --short | wc -l)
        amount=$(($amount-1))
        echo "Vous avez $amount disques installés."
        ;;
    2)
        lsblk -f
        ;;
    esac
}
#SSH
function info_app()
{
    echo "Que voulez vous faire ?"
    echo "1) Voir la liste des applications/paquets installées"
    echo "2) Voir la liste des services en cours d'execution"
    echo "3) Voir la liste des utilisateurs locaux"
    read -r choix_app
    case $choix_app in 
        1) 
            apt --installed list
            ;;
        2)
            systemctl
            ;;
        3)
            cut -d: -f1 /etc/passwd
            ;;
    esac
}
#SSH
function info_computer()
{
    #Fonction 15 : 
    # - Type de CPU, nombre de coeurs, etc.
    # - Mémoire RAM totale
    # - Utilisation de la RAM
    # - Utilisation du disque
    # - Utilisation du processeur
    # INSTALLATION htop requise
    echo "Que voulez vous faire ?"
    echo "1) Voir le type de CPU, le nombre de coeur, etc."
    echo "2) Voir la mémoire RAM total"
    echo "3) Voir l'utilisation de la RAM"
    echo "4) Voir l'utilisation du disque"
    echo "5) Voir l'utilisation du processeur"
    case $choix_computeur in 
        1) 
            lscpu
            ;;
        2) 
            free
            ;;
        3) 
            free
            ;;
        4)
            df
            ;;
        5)
            sudo apt install htop
            htop
            ;;
    esac
}
#SSH
function info_search()
{
    #Fonction 16 : 
    # - Recherche des evenements dans le fichier log_evt.log pour un utilisateur
    # - Recherche des evenements dans le fichier log_evt.log pour un ordinateur
    echo "Que voulez vous faire ?"
    echo "1) Rechercher des évenements dans le fichier log_evt.log pour un utilisateur"
    echo "2) Rechercher des évenements dans le fichier log_evt.log pour un ordinateur"
    case $choix_search in 
        1)
            echo "Quel évenement recherchez vous ?"
            read -r event_user
            cat log_evt.log | grep $event_user
            ;;
        2)
            echo "Quel évenement recherchez vous ?"
            read -r event_computer
            cat log_evt.log | grep $event_computer
            ;;
    esac
}

function log_events()
{
    # Fonction log
    # Journalisation dans log_evt.log
    # Format: Date-Heure-User-Event
    event=$1
    logDate=$(date -I | tr -d -)
    logHeure=$(date +%H%M%S)
    user=$(whoami)
    log="$logDate"-"$logHeure"-"$user"-"$event"
    echo $log
    # echo $log >> /var/log/log_evt.log
}

# FONCTIONS INFO A LOGGER AUSSI

# ------------------------------ #
#           EXECUTION
# ------------------------------ #

# Variable pour gérer l'arrêt
run=1
while [ $run -eq 1 ]
do
    #clear
    echo "Que voulez-vous faire ?"
    echo "--------------------"
    echo "1) Effectuer une action"
    echo "2) Récupérer une information"
    echo "q) Quitter"
    read -r choix
    case $choix in
        1)
            #clear
            echo "Sur quelle cible effectuer l'action ?"
            echo "--------------------"
            echo "1) Utilisateur"
            echo "2) Ordinateur"
            echo "q) Quitter"
            read -r choix2
            case $choix2 in
                1)
                    #clear
                    echo "Que voulez-vous faire ?"
                    echo "--------------------"
                    echo "1) Gestion compte utilisateur"
                    echo "2) Gestion groupe utilisateur"
                    echo "q) Quitter"
                    read -r choix3
                    case $choix3 in
                        1)
                            action_utilisateur_local
                            ;;
                        2)
                            action_groupe_local
                            ;;
                        q)
                            exit 0
                            ;;
                    esac
                    ;;
                2)
                    #clear
                    echo "Que voulez-vous faire ?"
                    echo "--------------------"
                    echo "1) Gestion alimentation ordinateur"
                    echo "2) Mise à jour système"
                    echo "3) Gestion des répertoires"
                    echo "4) Prise en main à distance"
                    echo "5) Gestion du pare-feu"
                    echo "6) Gestion des logiciels"
                    echo "q) Quitter"
                    read -r choix3
                    case $choix3 in
                        1)
                            action_shut
                            ;;
                        2)
                            action_update
                            ;;
                        3)
                            action_repertoire
                            ;;
                        4)
                            action_prise_en_main
                            ;;
                        5)
                            action_pare_feu
                            ;;
                        6)
                            action_logiciel
                            ;;
                        q)
                            exit 0
                            ;;
                    esac
                    ;;
                q)
                    exit 0
                    ;;
            esac
            ;;
        2)
            #clear
            echo "Sur quelle cible récupérer l'information ?"
            echo "--------------------"
            echo "1) Utilisateur"
            echo "2) Ordinateur"
            echo "q) Quitter"
            read -r choix2
            case $choix2 in
                1)
                    #clear
                    echo "Que voulez-vous savoir ?"
                    echo "--------------------"
                    echo "1) Informations compte utilisateur"
                    echo "2) Informations groupes et commandes utilisateur"
                    echo "3) Droits et permissions utilisateur"
                    echo "q) Quitter"
                    read -r choix3
                    case $choix3 in
                        1)
                            info_compte
                            ;;
                        2)
                            info_groupe
                            ;;
                        3)
                            info_droits
                            ;;
                        q)
                            exit 0
                            ;;
                    esac
                    ;;
                2)
                    #clear
                    echo "Que voulez-vous savoir ?"
                    echo "--------------------"
                    echo "1) Informations OS"
                    echo "2) Informations disques"
                    echo "3) Informations matériel"
                    echo "4) Recherche dans les logs"
                    echo "q) Quitter"
                    read -r choix3
                    case $choix3 in
                        1)
                            info_os_version
                            ;;
                        2)
                            info_disk_number
                            ;;
                        3)
                            info_computer
                            ;;
                        4)
                            info_search
                            ;;
                        q)
                            exit 0
                            ;;
                    esac
                    ;;
                q)
                    exit 0
                    ;;
            esac
            ;;
        q)
            exit 0
            ;;
    esac
done