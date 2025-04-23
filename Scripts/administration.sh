#!/bin/bash

# @Authors : Brendan Borne, Sheldon Thurm

# Script permettant la gestion de machines client Ubuntu depuis une machine serveur Debian. 

# --------------------------------- #
#             FONCTIONS             # 
# --------------------------------- #

# Gestion des utilisateurs 
function action_utilisateur_local() 
{
    # On demande à l'utilisateur ce qu'il souhaite faire
    echo "Que voulez vous faire ?"
    echo "--------------------"
    echo "1) Création d'un compte utilisateur"
    echo "2) Changement de mot de passe"
    echo "3) Suppression compte utilisateur"
    echo "4) Désactivation compte utilisateur"
    read -r choix
    # On applique le choix de l'utilisateur
    case $choix in
        1) 
            # On demande à l'utilisateur sur quelle machine il souhaite réaliser son action
            echo "Client où créer l'utilisateur :"
            read -r client
            # On demande à l'utilisateur sur quel utilisateur il souhaite réaliser son action
            echo "Merci de donner un nom d'utilisateur"
            read -r nom_user
            # On lance la commande sur la machine et l'utilisateur ciblés
            ssh $client adduser "$nom_user"
            # On log l'action effectuée
            log_events "ActionCreerUtilisateur$client"
            ;;
        2) 
            # On demande à l'utilisateur sur quelle machine il souhaite réaliser son action
            echo "Client où modifier le mot de passe :"
            read -r client
            # On demande à l'utilisateur sur quel utilisateur il souhaite réaliser son action
            echo "Merci de donner le nom d'utilisateur a qui vous voulez changer de mot de passe"
            read -r nom_passwd
            # On lance la commande sur la machine et l'utilisateur ciblés
            ssh $client passwd "$nom_passwd"
            # On log l'action effectuée
            log_events "ActionModifierMDP$client"
            ;;
        3)
            # On demande à l'utilisateur sur quelle machine il souhaite réaliser son action 
            echo "Client où supprimer un utilisateur :"
            read -r client
            # On demande à l'utilisateur sur quel utilisateur il souhaite réaliser son action
            echo "Merci de donner l'utilisateur que vous souhaitez supprimer"
            read -r user_del
            # On lance la commande sur la machine et l'utilisateur ciblés
            ssh $client deluser "$user_del"
            # On log l'action effectuée
            log_events "ActionSupprimerUtilisateur$client"
            ;;
        4)
            # On demande à l'utilisateur sur quelle machine il souhaite réaliser son action 
            echo "Client où désactiver un compte utilisateur :"
            read -r client
            # On demande à l'utilisateur sur quel utilisateur il souhaite réaliser son action
            echo "Merci de donner l'utilisateur que vous voulez désactiver"
            read -r user_desactive
            # On lance la commande sur la machine et l'utilisateur ciblés
            ssh $client usermod -L "$user_desactive"
            # On log l'action effectuée
            log_events "ActionDesactiverUtilisateur$client"
            ;;
    esac
}
# Gestion des groupes
function action_groupe_local()
{
    # On demande à l'utilisateur ce qu'il souhaite faire
    echo "Que voulez vous faire ?"
    echo "--------------------"
    echo "1) Ajout à un groupe local"
    echo "2) Sortie d'un groupe local"
    read -r choix_groupe_local
    # On applique le choix de l'utilisateur 
    case $choix_groupe_local in 
        1)
            # On demande à l'utilisateur sur quelle machine il souhaite réaliser son action 
            echo "Client de l'utilisateur à ajouter à un groupe ?"
            read -r client
            # On demande à l'utilisateur sur quel utilisateur il souhaite réaliser son action
            echo "Quel utilisateur voulez-vous ajouter à un groupe ?"
            read -r userName
            # On demande à l'utilisateur sur quel groupe il souhaite réaliser son action
            echo "A quel groupe voulez-vous ajouter l'utilisateur ?"
            read -r group_add
            # On lance la commande sur la machine et l'utilisateur ciblés
            ssh $client usermod -a -G $group_add $userName
            # On log l'action effectuée 
            log_events "ActionAjouterUtilisateurGroupe$client"
            ;; 
        2)
            # On demande à l'utilisateur sur quelle machine il souhaite réaliser son action 
            echo "Client de l'utilisateur à sortir d'un groupe ?"
            read -r client
            # On demande à l'utilisateur sur quel utilisateur il souhaite réaliser son action
            echo "Quel utilisateur voulez-vous sortir d'un groupe ?"
            read -r userName
            # On demande à l'utilisateur sur quel groupe il souhaite réaliser son action
            echo "De quel groupe voulez-vous sortir l'utilisateur ?"
            read -r group_out
            # On lance la commande sur la machine et l'utilisateur ciblés
            ssh $client usermod -r -G $group_out $userName
            # On log l'action effectuée 
            log_event "ActionSupprimerUtilisateurGroupe$client"
            ;;
    esac
}
# Gestion alimentation
function action_shut()
{
    # On demande à l'utilisateur ce qu'il souhaite faire
    echo "Que voulez vous faire ?"
    echo "--------------------"
    echo "1) Arret"
    echo "2) Redémarrage"
    echo "3) Déconnecter utilisateur"
    read -r choix_shut
    # On applique le choix de l'utilisateur 
    case $choix_shut in
        1)
            # On demande à l'utilisateur sur quelle machine il souhaite réaliser son action 
            echo "Quel client voulez-vous arrêter ?"
            read -r client
            # On lance la commande sur la machine ciblée
            ssh $client poweroff
            # On log l'action effectuée 
            log_events "ActionEteindre$client"
            ;; 
        2)
            # On demande à l'utilisateur sur quelle machine il souhaite réaliser son action 
            echo "Quel client voulez-vous redémarrer ?"
            read -r client
            # On lance la commande sur la machine ciblée
            ssh $client reboot
            # On log l'action effectuée
            log_events "ActionRedemarrer$client"
            ;; 
        3)
            # On demande à l'utilisateur sur quelle machine il souhaite réaliser son action  
            echo "Quel client voulez-vous déconnecter ?"
            read -r client
            echo "Quel utilisateur voulez-vous déconnecter ?"
            read -r user
            # On lance la commande sur la machine ciblée
            ssh $client pkill -KILL -u $user
            # On log l'action effectuée
            log_events "ActionDeconnecter$client"
            ;;
    esac
}
# Mise à jour client
function action_update()
{
    # On demande à l'utilisateur sur quelle machine il souhaite réaliser son action  
    echo "Quel client voulez-vous mettre à jour ?"
    read -r client
    # On lance la commande sur la machine ciblée
    ssh $client apt update && apt upgrade -y
    # On log l'action effectuée
    log_events "ActionMiseAJour$client"
}
# Gestion des répertoires
function action_repertoire()
{   
    # On demande à l'utilisateur ce qu'il souhaite faire
    echo "Que voulez vous faire ?"
    echo "--------------------"
    echo "1) Création de répertoire"
    echo "2) Modification de répertoire"
    echo "3) Suppression de répertoire"
    read -r choix_repertoire
    # On applique le choix de l'utilisateur
    case $choix_repertoire in 
        1)
            # On demande à l'utilisateur sur quelle machine il souhaite réaliser son action  
            echo "Sur quel client voulez-vous créer un répertoire ?"
            read -r client
            # On demande à l'utilisateur quel nom donner au répertoire
            echo "Comment voulez vous nommer le repertoire ?"
            read -r name_dir
            # On lance la commande sur la machine ciblée
            ssh $client mkdir "$name_dir"
            # On log l'action effectuée
            log_events "ActionCreerDossier$client"
            ;;
        2) 
            # On demande à l'utilisateur sur quelle machine il souhaite réaliser son action
            echo "Sur quel client voulez-vous modifier un répertoire ?"
            read -r client
            # On demande à l'utilisateur quel répertoire modifier
            echo "Quel repertoire voulez vous modifier ?"
            read -r mod_dir
            # On demande à l'utilisateur le nouveau nom du répertoire
            echo "Quel est le nouveau nom ?"
            read -r new_dir
            # On lance la commande sur la machine ciblée
            ssh $client mv "$mod_dir" "$new_dir"
            # On log l'action effectuée
            log_events "ActionModifDossier$client"
            ;; 
        3)
            # On demande à l'utilisateur sur quelle machine il souhaite réaliser son action
            echo "Sur quel client voulez-vous supprimer un répertoire ?"
            read -r client 
            # On demande à l'utilisateur le nom du répertoire à supprimer
            echo "Quel repertoire voulez vous supprimer ?"
            read -r dir_del
            # On lance la commande sur la machine cible
            ssh $client rmdir "$dir_del"
            # On log l'action effectuée
            log_events "ActionSupprimerDossier$client"
            ;;
    esac
}
# Prise en main à distance
function action_prise_en_main()
{   
    # On demande à l'utilisateur sur quelle machine il souhaite réaliser son action
    echo "Sur quel ordinateur voulez-vous prendre la main ?"
    read -r client
    # On prend la main sur la machine
    ssh $client
    # On log l'action effectuée
    log_events "ActionPriseEnMain$client"
}
# Gestion pare-feu
function action_pare_feu()
{
    # On demande à l'utilisateur ce qu'il souhaite faire
    echo "Gestion du pare-feu"
    echo "--------------------"
    echo "Que voulez-vous faire ?"
    echo "1) Définir une règle de pare-feu"
    echo "2) Activer le pare-feu"
    echo "3) Désactiver le pare-feu"
    read -r choix
    # On applique le choix de l'utilisateur
    case $choix in
    1)
        # On demande à l'utilisateur sur quelle machine il souhaite réaliser son action
        echo "Sur quel client voulez-vous définir une règle de pare-feu ?"
        read -r client
        # On demande à l'utilisateur ce qu'il souhaite faire
        echo "Définition de règle"
        echo "Que voulez-vous faire ?"
        echo "1) Autoriser adresse"
        echo "2) Interdire adresse"
        read -r choix2
        # On applique le choix de l'utilisateur
        case $choix2 in
        1)
            # On demande à l'utilisateur l'adresse à gérer
            echo "Entrez adresse à autoriser"
            read -r adresse
            # On lance la commande sur la machine cible
            ssh $client ufw allow from $adresse
            # On log l'action effectuée
            log_events "ActionAutorPareFeu$client"
            ;;
        2)
            # On demande à l'utilisateur l'adresse à gérer
            echo "Entrez adresse à interdire"
            read -r adresse
            # On lance la commande sur la machine cible
            ssh $client ufw deny from $adresse
            # On log l'action effectuée
            log_events "ActionSupprPareFeu$client"
            ;;
        esac
        ;;
    2)
        # On demande à l'utilisateur sur quelle machine il souhaite réaliser son action
        echo "Sur quel client voulez-vous activer le pare-feu ?"
        read -r client
        # On lance la commande sur la machine cible
        ssh $client ufw enable
        # On log l'action effectuée
        log_events "ActionActiverPareFeu$client"
        ;;
    3)
        # On demande à l'utilisateur sur quelle machine il souhaite réaliser son action
        echo "Sur quel client voulez-vous désactiver le pare-feu ?"
        read -r client
        # On lance la commande sur la machine cible
        ssh $client ufw disable
        # On log l'action effectuée
        log_events "ActionDesactiverPareFeu$client"
        ;;
    esac
}
# Gestion des logiciels
function action_logiciel()
{
    echo "Gestion de logiciels"
    echo "--------------------"
    # On demande à l'utilisateur sur quelle machine il souhaite réaliser son action
    echo "Sur quel client voulez-vous gérer vos logiciels ?"
    read -r client
    echo "--------------------"
    # On demande à l'utilisateur ce qu'il souhaite faire
    echo "Que voulez-vous faire ?"
    echo "1) Installer un logiciel"
    echo "2) Supprimer un logiciel"
    echo "3) Exécuter un script"
    read -r choix
    # On applique le choix de l'utilisateur
    case $choix in
    1)
        # On demande quel logiciel installer
        echo "Quel logiciel souhaitez-vous installer ?"
        read -r logiciel
        # On lance la commande sur la machine ciblée
        ssh $client apt install $logiciel
        # On log l'action effectuée
        log_events "ActionInstallApp$client"
        ;;
    2)
        # On demande quel logiciel supprimer
        echo "Quel logiciel souhaitez-vous supprimer ?"
        read -r logiciel
        # On lance la commande sur la machine ciblée
        ssh $client apt remove $logiciel
        # On log l'action effectuée
        log_events "ActionSupprApp$client"
        ;;
    3)
        # On demande quel script lancer
        echo "Quel script souhaitez-vous lancer ?"
        read -r script
        # On lance la commande sur la machine ciblée
        ssh $client bash $script 
        # On log l'action effectuée
        log_events "ActionLancerScript$client"
        ;;
    esac
}
# Informations sur comptes utilisateurs
function info_compte()
{
    echo "Informations sur le compte"
    echo "--------------------"
    # On demande sur quelle machine récupérer les informations
    echo "Sur quel client récupérer vos informations ?"
    read -r client
    # On demande sur quel utilisateur récupérer les informations
    echo "Sur quel utilisateur récupérer vos informations ?"
    read -r user
    # On demande l'information désirée
    echo "Que voulez-vous savoir ?"
    echo "1) Date de dernière connexion de $user"
    echo "2) Date de dernière modification du mot de passe de $user"
    echo "3) Liste des sessions de $user"
    read -r choix
    # On applique le choix de l'utilisateur
    case $choix in
        1) 
            # On garde l'information voulue dans une variable
            command=$(ssh $client last $user | head -n 1)
            # On affiche l'information
            echo $command
            # On log l'information récupérée
            log_info "$client"_"$user" "$command"
            # On log l'action effectuée
            log_events "InfoDateConnexion$client"
            ;;
        2)
            # On garde l'information voulue dans une variable
            command=$(ssh $client passwd $user -S)
            # On affiche l'information
            echo $command
            # On log l'information récupérée
            log_info "$client"_"$user" "$command"
            # On log l'action effectuée
            log_events "InfoDateModifMDP$client"
            ;;
        3)
            # On garde l'information voulue dans une variable
            command=$(ssh $client last $user)
            # On affiche l'information
            echo $command
            # On log l'information récupérée
            log_info "$client"_"$user" "$command"
            # On log l'action effectuée
            log_events "InfoSessions$client"
            ;;
    esac

}
# Informations sur groupes
function info_groupe()
{
    
    echo "Info groupe & commandes"
    echo "--------------------"
    # On demande sur quelle machine récupérer les informations
    echo "Sur quel client récupérer vos informations ?"
    read -r client
    # On demande sur quel utilisateur récupérer les informations
    echo "Sur quel utilisateur récupếrer vos informations ?"
    read -r user
    # On demande l'information désirée
    echo "Que voulez-vous savoir ?"
    echo "1) Groupe de $user"
    echo "2) Historique commandes de $user"
    read -r choix
    # On applique le choix de l'utilisateur
    case $choix in
        1)
            # On garde l'information voulue dans une variable
            command=$(ssh $client groups $user)
            # On affiche l'information
            echo $command
            # On log l'information récupérée
            log_info "$client"_"$user" "$command"
            # On log l'action effectuée
            log_events "InfoGroupeUtilisateur$client"
            ;;
        2)
            # On garde l'information voulue dans une variable
            command=$(ssh $client cat /home/$user/.bash_history)
            # On affiche l'information
            echo $command
            # On log l'information récupée
            log_info "$client"_"$user" "$command"
            # On log l'action effectuée
            log_events "InfoHistoriqueUtilisateur$client"
            ;;
    esac
}
# Informations sur les droits
function info_droits()
{
    echo "Info droits fichier/dossier"
    echo "--------------------"
    # On demande sur quelle machine récupérer les informations
    echo "Sur quel client recuperer vos informations ?"
    read -r client
    # On demande sur quel utilisateur récupérer les informations
    echo "Sur quel utilisateur recuperer vos informations ?"
    read -r user
    # On demande sur quel élément récupérer les informations
    echo "Sur quel dossier/fichier recuperer vos informations ?"
    read -r target
    # On garde l'information voulue dans une variable
    command=$(ssh $client getfacl $target)
    # On affiche l'information
    echo $command
    # On log l'information récupérée
    log_info "$client"_"$user" "$command"
    # On log l'action effectuée
    log_events "InfoDroitsRepertoire$client"
}
# Informations sur l'OS
function info_os_version()
{
    # On demande sur quelle machine récupérer les informations
    echo "Sur quel client récupérer vos informations ?"
    read -r client
    # On garde l'information voulue dans une variable
    command=$(ssh $client cat /etc/os-release | grep "PRETTY_NAME" | cut -d = -f 2 | tr -d '"')
    # On affiche l'information
    echo $command
    # On log l'information récupérée
    log_info $client-GEN "$command"
    # On log l'action effectuée
    log_events "InfoOS$client"
}
# Informations sur les disques
function info_disk_number()
{
    echo "Infos disque"
    echo "--------------------"
    # On demande sur quelle machine récupérer les informations
    echo "Sur quel client voulez-vous récupérer vos informations ?"
    read -r client
    # On demande l'information désirée
    echo "Que voulez-vous savoir ?"
    echo "1) Nombre de disques"
    echo "2) Partitions"
    read -r choix
    # On applique le choix de l'utilisateur
    case $choix in
    1)
        # Calcul du nombre de disques
        amount=$(ssh $client hwinfo --disk --short | wc -l)
        amount=$(($amount-1))
        # On garde l'information voulue dans une variable
        command=$(echo "Nombre de disques : $amount")
        # On log l'information récupérée
        log_info $client-GEN "$command"
        # On log l'action effectuée
        log_events "InfoNombreDisques$client"
        ;;
    2)
        # On garde l'information voulue dans une variable
        command=$(ssh $client lsblk -f)
        # On affiche l'information
        echo $command
        # On log l'information récupérée
        log_info $client-GEN "$command"
        # On log l'action effectuée
        log_events "InfoPartitions$client"
        ;;
    esac
}
# Informations sur les applis installées
function info_app()
{
    # On demande sur quelle machine on souhaite récupérer l'information
    echo "Sur quel client voulez-vous récupérer vos informations ?"
    read -r client
    # On demande l'information désirée
    echo "Que voulez vous faire ?"
    echo "1) Voir la liste des applications/paquets installées"
    echo "2) Voir la liste des services en cours d'execution"
    echo "3) Voir la liste des utilisateurs locaux"
    read -r choix_app
    # On applique le choix de l'utilisateur
    case $choix_app in 
        1) 
            # On garde l'information voulue dans une variable
            command=$(ssh $client apt --installed list)
            # On affiche l'information
            echo $command
            # On log l'information récupérée
            log_info $client-GEN "$command"
            # On log l'action effectuée
            log_events "InfoApplisInstallées$client"
            ;;
        2)
            # On garde l'information voulue dans une variable
            command=$(ssh $client systemctl)
            # On affiche l'information
            echo $command
            # On log l'information récupérée
            log_info $client-GEN "$command"
            # On log l'action effectuée
            log_events "InfoServicesEnCours$client"
            ;;
        3)
            # On garde l'information voulue dans une variable
            command=$(ssh $client cut -d: -f1 /etc/passwd)
            # On affiche l'information
            echo $command
            # On log l'information récupérée
            log_info $client-GEN "$command"
            # On log l'action effectuée
            log_events "InfoUtilisateursLocaux$client"
            ;;
    esac
}
# Informations sur le PC
function info_computer()
{
    # On demande sur quelle machine récupérer l'information
    echo "Sur quel client voulez-vous récupérer vos informations ?"
    read -r client
    # On demande l'information désirée
    echo "Que voulez vous faire ?"
    echo "1) Voir le type de CPU, le nombre de coeur, etc."
    echo "2) Voir la mémoire RAM totale"
    echo "3) Voir l'utilisation de la RAM"
    echo "4) Voir l'utilisation du disque"
    echo "5) Voir l'utilisation du processeur"
    read -r choix
    # On applique le choix de l'utilisateur
    case $choix in 
        1) 
            # On garde l'information voulue dans une variable
            command=$(ssh $client lscpu)
            # On affiche l'information
            echo $command
            # On log l'information récupérée
            log_info $client-GEN "$command"
            # On log l'action effectuée
            log_events "InfoCPU$client"
            ;;
        2)
            # On garde l'information voulue dans une variable 
            command=$(ssh $client free)
            # On affiche l'information
            echo $command
            # On log l'information récupérée
            log_info $client-GEN "$command"
            # On log l'action effectuée
            log_events "InfoRAM$client"
            ;;
        3) 
            # On garde l'information voulue dans une variable
            command=$(ssh $client free)
            # On affiche l'information
            echo $command
            # On log l'information récupérée
            log_info $client-GEN "$command"
            # On log l'action effectuée
            log_events "InfoRAM$client"
            ;;
        4)  
            # On garde l'information voulue dans une variable
            command=$(ssh $client df)
            # On affiche l'information
            echo $command
            # On log l'information récupérée
            log_info $client-GEN "$command"
            # On log l'action effectuée
            log_events "InfoUtilisationDisque$client"
            ;;
        5)
            # On garde l'information voulue dans une variable
            command=$(ssh $client htop)
            # On affiche l'information
            echo $command
            # On log l'information récupérée
            log_info $client-GEN "$command"
            # On log l'action effectuée
            log_events "InfoUtilisationCPU$client"
            ;;
    esac
}
# Recherche dans les logs
function info_search()
{
    # On demande à l'utilisateur l'information qu'il désire
    echo "Que voulez vous faire ?"
    echo "1) Rechercher des évenements dans le fichier log_evt.log pour un utilisateur"
    echo "2) Rechercher des évenements dans le fichier log_evt.log pour un ordinateur"
    read -r choix_search
    # On applique le choix de l'utilisateur
    case $choix_search in 
        1)
            # On demande à l'utilisateur quel nom d'utilisateur il cherche
            echo "Quel utilisateur recherchez vous ?"
            read -r event_user
            # On affiche l'information voulue
            cat /var/log/log_evt.log | grep $event_user
            ;;
        2)
            # On demande à l'utilisateur quel machine il cherche
            echo "Quel ordinateur recherchez vous ?"
            read -r event_computer
            # On affiche l'information voulue
            cat /var/log/log_evt.log | grep $event_computer
            ;;
    esac
}
# Journalisation des actions
function log_events()
{
    # On passe l'action effectuée en premier argument positionnel de la fonction
    event=$1
    # Au cas où le fichier de log n'existe pas déjà, on le crée
    touch /var/log/log_evt.log
    # On récupère la date au format yyyymmjj
    logDate=$(date -I | tr -d -)
    # On récupère l'heure au format hhmmss
    logHeure=$(date +%H%M%S)
    # On récupère le nom de l'utilisateur du script
    user=$(whoami)
    # On construit la chaîne de caractère du log
    log="$logDate"-"$logHeure"-"$user"-"$event"
    # On ajoute la chaîne au fichier de log
    echo $log >> /var/log/log_evt.log
}
# Journalisation des informations récupérées
function log_info()
{
    # On passe la cible sur laquelle a été récupérée l'information en premier paramètre positionnel de la fonction
    logCible=$1
    # On passe l'information à logger en second paramètre positionnel de la fonction
    logRes=$2
    # On récupère la date au format yyyymmjj
    logDate=$(date -I | tr -d -)
    # On crée le nom du fichier à construire
    logFile=info_"$logCible"_"$logDate".txt
    # On créé le fichier
    touch log/"$logFile"
    # On ajoute les informations récupérées dans le fichier
    echo "$logRes" >> log/"$logFile"
}

# ------------------------------ #
#           EXECUTION            #
# ------------------------------ #

# On inscrit dans les logs le début de l'exécution du script
log_events "********StartScript********"
# Variable pour gérer l'arrêt du script
run=1
# On lance la boucle
while [ $run -eq 1 ]
do
    #clear
    # On demande l'action que l'utilisateur souhaite faire
    echo "Que voulez-vous faire ?"
    echo "--------------------"
    echo "1) Effectuer une action"
    echo "2) Récupérer une information"
    echo "q) Quitter"
    read -r choix
    # On applique le choix de l'utilisateur
    case $choix in
        1)
            #clear
            # On demande à l'utilisateur sur quelle cible il souhaite effectuer son action
            echo "Sur quelle cible effectuer l'action ?"
            echo "--------------------"
            echo "1) Utilisateur"
            echo "2) Ordinateur"
            echo "r) Retour"
            echo "q) Quitter"
            read -r choix2
            # On applique le choix de l'utilisateur
            case $choix2 in
                1)
                    #clear
                    # On demande à l'utilisateur quelle action il souhaite effectuer
                    echo "Que voulez-vous faire ?"
                    echo "--------------------"
                    echo "1) Gestion compte utilisateur"
                    echo "2) Gestion groupe utilisateur"
                    echo "r) Retour"
                    echo "q) Quitter"
                    read -r choix3
                    # On applique le choix de l'utilisateur
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
                    # On demande à l'utilisateur quelle action il souhaite effectuer
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
                    # On applique le choix de l'utilisateur
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
            # On demande à l'utilisateur sur quelle cible il souhaite récupérer son information
            echo "Sur quelle cible récupérer l'information ?"
            echo "--------------------"
            echo "1) Utilisateur"
            echo "2) Ordinateur"
            echo "r) Retour"
            echo "q) Quitter"
            read -r choix2
            # On applique le choix de l'utilisateur
            case $choix2 in
                1)
                    #clear
                    # On demande à l'utilisateur quelle information il souhaite récupérer
                    echo "Que voulez-vous savoir ?"
                    echo "--------------------"
                    echo "1) Informations compte utilisateur"
                    echo "2) Informations groupes et commandes utilisateur"
                    echo "3) Droits et permissions utilisateur"
                    echo "r) Retour"
                    echo "q) Quitter"
                    read -r choix3
                    # On applique le choix de l'utilisateur
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
                    # On demande à l'utilisateur quelle information il souhaite récupérer
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
                    # On applique le choix de l'utilisateur
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