# Journalisation des actions
function log_events{
    # On passe l'action réalisée en premier argument positionnel de la fonction
    param (
        [string[]]$Event
    )
    # On récupère la date au format yyyymmjj
    $logDate = Get-Date -Format "yyyymmdd"
    # On récupère l'heure au format hhmmss
    $logHeure = Get-Date -Format "hhmmss"
    # On récupère le nom de l'utilisateur du script
    $user = [Environment]::UserName
    # On construit la chaîne de caractère du log
    $log = "$logDate-$logHeure-$user-$Event"
    # On ajoute la chaîne au fichier de log
    Write-Output $log >> C:\Windows\System32\LogFiles\log_evt.log
}
# Journalisation des informations récupérées
function log_infos{
    # On passe la cible sur laquelle a été récupérée l'information en premier paramètre positionnel de la fonction
    # On passe l'information à logger en second paramètre positionnel de la fonction
    param (
        [string[]]$LogCible,
        [string[]]$LogInfo
    )
    # On récupère la date au format yyyymmjj
    $logDate = Get-Date -Format "yyyymmdd"
    # On crée le nom du fichier à construire
    $logFile = "info_$LogCible_$LogDate.txt"
    # On créé le fichier avec les informations
    Write-Output $LogInfo >> log/$logFile
}
# log_infos -LogCible CLILIN01 -LogInfo Information

# ------------------------------ #
#           EXECUTION            #
# ------------------------------ #

# On inscrit dans les logs le début de l'exécution du script
log_events "********StartScript********"
# Variable pour gérer l'arrêt du script
$run=1
# On lance la boucle
While($run -eq 1){
    Write-Host "Que voulez-vous faire ?"
    Write-Host "--------------------"
    Write-Host "1) Effectuer une action"
    Write-Host "2) Récupérer une information"
    Write-Host "q) Quitter"
    $choix = Read-Host
    Switch($choix){
        "1" {
            # On demande à l'utilisateur sur quelle cible il souhaite effectuer son action
            Write-Host "Sur quelle cible effectuer l'action ?"
            Write-Host "--------------------"
            Write-Host "1) Utilisateur"
            Write-Host "2) Ordinateur"
            Write-Host "r) Retour"
            Write-Host "q) Quitter"
            $choix2 = Read-Host
            # On applique le choix de l'utilisateur
            Switch($choix2){
                "1" {
                    # On demande à l'utilisateur quelle action il souhaite effectuer
                    Write-Host "Que voulez-vous faire ?"
                    Write-Host "--------------------"
                    Write-Host "1) Gestion compte utilisateur"
                    Write-Host "2) Gestion groupe utilisateur"
                    Write-Host "r) Retour"
                    Write-Host "q) Quitter"
                    $choix3 = Read-Host
                    # On applique le choix de l'utilisateur
                    #Switch($choix3){ # Là on met les fonctions}
                }
                "2" {
                    Write-Host "Que voulez-vous faire ?"
                    Write-Host "--------------------"
                    Write-Host "1) Gestion alimentation ordinateur"
                    Write-Host "2) Mise à jour système"
                    Write-Host "3) Gestion des répertoires"
                    Write-Host "4) Prise en main à distance"
                    Write-Host "5) Gestion du pare-feu"
                    Write-Host "6) Gestion des logiciels"
                    Write-Host "r) Retour"
                    Write-Host "q) Quitter"
                    $choix3 = Read-Host
                    # On applique le choix de l'utilisateur
                    #Switch($choix3) {# Là on met les fonctions}
                }
                "r" {
                    break
                }
                "q" {
                    $run=0
                }
                default {
                    Write-Host "Entrée erronée"
                }
            }
        }
        "2" {
            # On demande à l'utilisateur quelle action il souhaite effectuer
            Write-Host "Sur quelle cible récupérer l'information ?"
            Write-Host "--------------------"
            Write-Host "1) Utilisateur"
            Write-Host "2) Ordinateur"
            Write-Host "r) Retour"
            Write-Host "q) Quitter"
            $choix2 = Read-Host
            # On applique le choix de l'utilisateur
            Switch($choix2){
                "1" {
                    # On demande à l'utilisateur quelle information il souhaite récupérer
                    Write-Host "Que voulez-vous savoir ?"
                    Write-Host "--------------------"
                    Write-Host "1) Informations compte utilisateur"
                    Write-Host "2) Informations groupes et commandes utilisateur"
                    Write-Host "3) Droits et permissions utilisateur"
                    Write-Host "r) Retour"
                    Write-Host "q) Quitter"
                    $choix3 = Read-Host
                    # On applique le choix de l'utilisateur
                    #Switch($choix3){# Là on met les fonctions}
                }
                "2" {
                    # On demande à l'utilisateur quelle information il souhaite récupérer
                    Write-Host "Que voulez-vous savoir ?"
                    Write-Host "--------------------"
                    Write-Host "1) Informations OS"
                    Write-Host "2) Informations disques"
                    Write-Host "3) Informations applications"
                    Write-Host "4) Informations matériel"
                    Write-Host "5) Recherche dans les logs"
                    Write-Host "r) Retour"
                    Write-Host "q) Quitter"
                    $choix3 = Read-Host
                    # On applique le choix de l'utilisateur
                    #Switch($choix3){# Là on met les fonctions}
                }
                "r" {
                    break
                }
                "q" {
                    $run=0
                }
                default {
                    Write-Host "Entrée erronée"
                }

            }
        }
        "q" {
            $run=0
        }
        default {
            Write-Host "Entrée erronée"
        }
    }
}
# On inscrit dans les logs la fin de l'exécution du script
log_events "********EndScript********"