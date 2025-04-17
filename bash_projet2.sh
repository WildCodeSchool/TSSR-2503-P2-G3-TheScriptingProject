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
            ssh $client adduser "$nom_user"
            log_events "ActionCreerUtilisateur"
            ;;
        2) 
            echo "Client où modifier le mot de passe :"
            read -r client
            echo "Merci de donner le nom d'utilisateur a qui vous voulez changer de mot de passe"
            read -r nom_passwd
            ssh $client passwd "$nom_passwd"
            log_events "ActionModifierMDP"
            ;;
        3) 
            echo "Client où supprimer un utilisateur :"
            read -r client
            echo "Merci de donner l'utilisateur que vous souhaitez supprimer"
            read -r user_del
            ssh $client deluser "$user_del"
            log_events "ActionSupprimerUtilisateur"
            ;;
        4)
            echo "Client où désactiver un compte utilisateur :"
            read -r client
            echo "Merci de donner l'utilisateur que vous voulez désactiver"
            read -r user_desactive
            ssh $client usermod -L "$user_desactive"
            log_events "ActionDesactiverUtilisateur"
            ;;
        #chage -E 0 username
    esac
}

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
            echo "Client de l'utilisateur à ajouter à un groupe ?"
            read -r client
            echo "Quel utilisateur voulez-vous ajouter à un groupe ?"
            read -r userName
            echo "A quel groupe voulez-vous ajouter l'utilisateur ?"
            read -r group_add
            ssh $client usermod -a -G $group_add $userName 
            log_events "ActionAjouterUtilisateurGroupe"
            ;; 
        2)
            echo "Client de l'utilisateur à sortir d'un groupe ?"
            read -r client
            echo "Quel utilisateur voulez-vous sortir d'un groupe ?"
            read -r userName
            echo "De quel groupe voulez-vous sortir l'utilisateur ?"
            read -r group_out
            ssh $client usermod -r -G $group_out $userName
            log_event "ActionSupprimerUtilisateurGroupe"
            ;;
    esac
}

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
    echo "3) Déconnecter utilisateur"
    read -r choix_shut
    case $choix_shut in
        1)
            echo "Quel client voulez-vous arrêter ?"
            read -r client
            ssh $client poweroff
            log_events "ActionEteindre"
            ;; 
        2)
            echo "Quel client voulez-vous redémarrer ?"
            read -r client
            ssh $client reboot
            log_events "ActionRedemarrer"
            ;; 
        3) 
            echo "Quel client voulez-vous déconnecter ?"
            read -r client
            echo "Quel utilisateur voulez-vous déconnecter ?"
            read -r user
            ssh $client pkill -KILL -u $user
            log_events "ActionDeconnecter"
            ;;
    esac
}

function action_update()
{
    #Fonction 4 : 
    # - Mise-à-jour du système 
    echo "Quel client voulez-vous mettre à jour ?"
    read -r client
    ssh $client apt update && apt upgrade -y
    log_events "ActionMiseAJour"
}

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
            echo "Sur quel client voulez-vous créer un répertoire ?"
            read -r client
            echo "Comment voulez vous nommer le repertoire ?"
            read -r name_dir
            ssh $client mkdir "$name_dir"
            log_events "ActionCreerDossier"
            ;;
        2) 
            echo "Sur quel client voulez-vous modifier un répertoire ?"
            read -r client
            echo "Quel repertoire voulez vous modifier ?"
            read -r mod_dir
            echo "Quel est le nouveau nom ?"
            read -r new_dir
            ssh $client mv "$mod_dir" "$new_dir"
            log_events "ActionModifDossier"
            ;; 
        3)
            echo "Sur quel client voulez-vous supprimer un répertoire ?"
            read -r client 
            echo "Quel repertoire voulez vous supprimer ?"
            read -r dir_del
            ssh $client rmdir "$dir_del"
            log_events "ActionSupprimerDossier"
            ;;
    esac
}

function action_prise_en_main()
{   
    #Fonction 6 : 
    # - Prise en main a distance (CLI)
    echo "Sur quel ordinateur voulez-vous prendre la main ?"
    read -r client
    ssh $client
    log_events "ActionPriseEnMain"
}

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
        echo "Sur quel client voulez-vous définir une règle de pare-feu ?"
        read -r client
        echo "Définition de règle"
        echo "Que voulez-vous faire ?"
        echo "1) Autoriser adresse"
        echo "2) Interdire adresse"
        read -r choix2
        case $choix2 in
        1)
            echo "Entrez adresse à autoriser"
            read -r adresse
            ssh $client ufw allow from $adresse
            log_events "ActionAutorPareFeu"
            ;;
        2)
            echo "Entrez adresse à interdire"
            read -r adresse
            ssh $client ufw deny from $adresse
            log_events "ActionSupprPareFeu"
            ;;
        esac
        ;;
    2)
        echo "Sur quel client voulez-vous activer le pare-feu ?"
        read -r client
        echo "Activation du pare-feu"
        ssh $client ufw enable
        log_events "ActionActiverPareFeu"
        ;;
    3)
        echo "Sur quel client voulez-vous désactiver le pare-feu ?"
        read -r client
        echo "Désactivation du pare-feu"
        ssh $client ufw disable
        log_events "ActionDesactiverPareFeu"
        ;;
    esac
}

function action_logiciel()
{
    #Fonction 8 : 
    # - Installation de logiciel
    # - Désinstallation de logiciel 
    # - Execution de script sur la machine distante 
    # ./script.sh
    echo "Gestion de logiciels"
    echo "--------------------"
    echo "Sur quel client voulez-vous gérer vos logiciels ?"
    read -r client
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
        ssh $client apt install $logiciel
        log_events "ActionInstallApp"
        ;;
    2)
        echo "Remove"
        echo "Quel logiciel souhaitez-vous supprimer ?"
        read -r logiciel
        ssh $client apt remove $logiciel
        log_events "ActionSupprApp"
        ;;
    3)
        echo "Quel script souhaitez-vous lancer ?"
        read -r script
        ssh $client bash $script 
        log_events "ActionLancerScript"
        ;;
    esac
}

function info_compte()
{
    #Fonction 9 :
    # - Date de dernière connexion d’un utilisateur
    # Commande last $user
    # - Date de dernière modification du mot de passe
    # Commande passwd $user -S
    # - Liste des sessions ouvertes par l'utilisateur
    # Commande last $user
    echo "Informations sur le compte"
    echo "--------------------"
    echo "Sur quel client récupérer vos informations ?"
    read -r client
    echo "Sur quel utilisateur récupérer vos informations ?"
    read -r user
    echo "Que voulez-vous savoir ?"
    echo "1) Date de dernière connexion de $user"
    echo "2) Date de dernière modification du mot de passe de $user"
    echo "3) Liste des sessions de $user"
    read -r choix
    case $choix in
        1) 
            command=$(ssh $client last $user | head -n 1)
            echo $command
            log_info "$client"_"$user" "$command"
            log_events "InfoDateConnexion"
            ;;
        2)
            command=$(ssh $client passwd $user -S)
            echo $command
            log_info "$client"_"$user" "$command"
            log_events "InfoDateModifMDP"
            ;;
        3)
            command=$(ssh $client last $user)
            echo $command
            log_info "$client"_"$user" "$command"
            log_events "InfoSessions"
            ;;
    esac

}

function info_groupe()
{
    #Fonction 10 : 
    # - Groupe d’appartenance d’un utilisateur
    # - Historique des commandes exécutées par l'utilisateur
    echo "Info groupe & commandes"
    echo "--------------------"
    echo "Sur quel client récupérer vos informations ?"
    read -r client
    echo "Sur quel utilisateur récupếrer vos informations ?"
    read -r user
    echo "Que voulez-vous savoir ?"
    echo "1) Groupe de $user"
    echo "2) Historique commandes de $user"
    read -r choix
    case $choix in
        1)
            command=$(ssh $client groups $user)
            echo $command
            log_info "$client"_"$user" "$command"
            log_events "InfoGroupeUtilisateur"
            ;;
        2)
            command=$(ssh $client cat /home/$user/.bash_history)
            echo $command
            log_info "$client"_"$user" "$command"
            log_events "InfoHistoriqueUtilisateur"
            ;;
    esac
}

function info_droits()
{
    #Fonction 11 : 
    # - Droits/permissions de l’utilisateur sur un dossier
    # Utiliser getfacl
    # - Droits/permissions de l’utilisateur sur un fichier
    echo "Info droits fichier/dossier"
    echo "--------------------"
    echo "Sur quel client recuperer vos informations ?"
    read -r client
    echo "Sur quel utilisateur recuperer vos informations ?"
    read -r user
    echo "Sur quel dossier/fichier recuperer vos informations ?"
    read -r target
    command=$(ssh $client getfacl $target)
    echo $command
    log_info "$client"_"$user" "$command"
    log_events "InfoDroitsRepertoire"
}

function info_os_version()
{
    #Fonction 12 : 
    # - Version de l'OS
    echo "Sur quel client récupérer vos informations ?"
    read -r client
    command=$(ssh $client cat /etc/os-release | grep "PRETTY_NAME" | cut -d = -f 2 | tr -d '"')
    echo $command
    log_info $client-GEN "$command"
    log_events "InfoOS"
}

function info_disk_number()
{
    #Fonction 13 : 
    # - Nombre de disque
    # - Partition (nombre, nom, FS, taille) par disque
    # Nécessite d'avoir installé hwinfo
    echo "Infos disque"
    echo "--------------------"
    echo "Sur quel client voulez-vous récupérer vos informations ?"
    read -r client
    echo "Que voulez-vous savoir ?"
    echo "1) Nombre de disques"
    echo "2) Partitions"
    read -r choix
    case $choix in
    1)
        amount=$(ssh $client hwinfo --disk --short | wc -l)
        amount=$(($amount-1))
        command=$(echo "Nombre de disques : $amount")
        log_info $client-GEN "$command"
        log_events "InfoNombreDisques"
        ;;
    2)
        command=$(ssh $client lsblk -f)
        echo $command
        log_info $client-GEN "$command"
        log_events "InfoPartitions"
        ;;
    esac
}

function info_app()
{
    echo "Sur quel client voulez-vous récupérer vos informations ?"
    read -r client
    echo "Que voulez vous faire ?"
    echo "1) Voir la liste des applications/paquets installées"
    echo "2) Voir la liste des services en cours d'execution"
    echo "3) Voir la liste des utilisateurs locaux"
    read -r choix_app
    case $choix_app in 
        1) 
            command=$(ssh $client apt --installed list)
            echo $command
            log_info $client-GEN "$command"
            log_events "InfoApplisInstallées"
            ;;
        2)
            command=$(ssh $client systemctl)
            echo $command
            log_info $client-GEN "$command"
            log_events "InfoServicesEnCours"
            ;;
        3)
            command=$(ssh $client cut -d: -f1 /etc/passwd)
            echo $command
            log_info $client-GEN "$command"
            log_events "InfoUtilisateursLocaux"
            ;;
    esac
}

function info_computer()
{
    #Fonction 15 : 
    # - Type de CPU, nombre de coeurs, etc.
    # - Mémoire RAM totale
    # - Utilisation de la RAM
    # - Utilisation du disque
    # - Utilisation du processeur
    # INSTALLATION htop requise
    echo "Sur quel client voulez-vous récupérer vos informations ?"
    read -r client
    echo "Que voulez vous faire ?"
    echo "1) Voir le type de CPU, le nombre de coeur, etc."
    echo "2) Voir la mémoire RAM totale"
    echo "3) Voir l'utilisation de la RAM"
    echo "4) Voir l'utilisation du disque"
    echo "5) Voir l'utilisation du processeur"
    read -r choix
    case $choix in 
        1) 
            command=$(ssh $client lscpu)
            echo $command
            log_info $client-GEN "$command"
            log_events "InfoCPU"
            ;;
        2) 
            command=$(ssh $client free)
            echo $command
            log_info $client-GEN "$command"
            log_events "InfoRAM"
            ;;
        3) 
            command=$(ssh $client free)
            echo $command
            log_info $client-GEN "$command"
            log_events "InfoRAM"
            ;;
        4)
            command=$(ssh $client df)
            echo $command
            log_info $client-GEN "$command"
            log_events "InfoUtilisationDisque"
            ;;
        5)
            command=$(ssh $client htop)
            echo $command
            log_info $client-GEN "$command"
            log_events "InfoUtilisationCPU"
            ;;
    esac
}

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
            echo "Quel utilisateur recherchez vous ?"
            read -r event_user
            cat log_evt.log | grep $event_user
            ;;
        2)
            echo "Quel ordinateur recherchez vous ?"
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
    touch /var/log/log_evt.log
    logDate=$(date -I | tr -d -)
    logHeure=$(date +%H%M%S)
    user=$(whoami)
    log="$logDate"-"$logHeure"-"$user"-"$event"
    echo $log >> /var/log/log_evt.log
}

function log_info()
{
    logCible=$1
    logRes=$2
    logDate=$(date -I | tr -d -)
    logFile=info_"$logCible"_"$logDate".txt
    touch log/"$logFile"
    echo "$logRes" >> log/"$logFile"
}

# ------------------------------ #
#           EXECUTION
# ------------------------------ #

# On inscrit dans les logs le début de l'exécution du script
log_events "********StartScript********"
# Variable pour gérer l'arrêt
run=1
# On lance la boucle
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
            echo "r) Retour"
            echo "q) Quitter"
            read -r choix2
            case $choix2 in
                1)
                    #clear
                    echo "Que voulez-vous faire ?"
                    echo "--------------------"
                    echo "1) Gestion compte utilisateur"
                    echo "2) Gestion groupe utilisateur"
                    echo "r) Retour"
                    echo "q) Quitter"
                    read -r choix3
                    case $choix3 in
                        1)
                            action_utilisateur_local
                            ;;
                        2)
                            action_groupe_local
                            ;;
                        r)
                            echo "Retour"
                            ;;
                        q)
                            break
                            ;;
                        *)
                            echo "Entrée erronée"
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
                    echo "r) Retour"
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
                        r)
                            echo "Retour"
                            ;;
                        q)
                            break
                            ;;
                        *)
                            echo "Entrée erronée"
                            ;;
                    esac
                    ;;
                q)
                    break
                    ;;
            esac
            ;;
        2)
            #clear
            echo "Sur quelle cible récupérer l'information ?"
            echo "--------------------"
            echo "1) Utilisateur"
            echo "2) Ordinateur"
            echo "r) Retour"
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
                    echo "r) Retour"
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
                        r)
                            echo "Retour"
                            ;;
                        q)
                            break
                            ;;
                        *)
                            echo "Entrée erronée"
                            ;;
                    esac
                    ;;
                2)
                    #clear
                    echo "Que voulez-vous savoir ?"
                    echo "--------------------"
                    echo "1) Informations OS"
                    echo "2) Informations disques"
                    echo "3) Informations applications"
                    echo "4) Informations matériel"
                    echo "5) Recherche dans les logs"
                    echo "r) Retour"
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
                            info_app
                            ;;
                        4)
                            info_computer
                            ;;
                        5)
                            info_search
                            ;;
                        r)
                            echo "Retour"
                            ;;
                        q)
                            break
                            ;;
                        *)
                            echo "Entrée erronnée"
                            ;;
                    esac
                    ;;
                r)
                    echo "Retour"
                    ;;
                q)
                    break
                    ;;
            esac
            ;;
        q)
            break
            ;;
        *)
            echo "Entrée erronée"
            ;;
    esac
done

# On inscrit dans les logs la fin de l'exécution du script
log_events "********EndScript********"