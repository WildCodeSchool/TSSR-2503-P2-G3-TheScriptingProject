# Fonction gestion des comptes utilisateurs
function utilisateur_local{

# On demande à l'utilisateur l'action qu'il souhaite effectuer
$utilisateur_local = @"
    Taper 1 pour créer un compte utilisateur 
    Taper 2 pour changer le mot de passe 
    Taper 3 pour supprimer un compte utilisateur 
    Taper 4 pour désactiver un compte
"@

    Write-Host $utilisateur_local

    # On lit le choix de l'utilisateur
    $choix = Read-Host -Prompt "choix ?"

    # On applique le choix
    switch ($choix)
    {
        1{
            # On demande sur quel client lancer la commande
            $client = Read-Host -Prompt "Client où créer l'utilisateur ?"
            # On lance la commande
            Invoke-Command -ComputerName $client -ScriptBlock {New-LocalUser}
            # On log l'action effectuée
            log_events "ActionCreerUtilisateur$client"
        }
        
        2{
            # On demande sur quel client lancer la commande
            $client = Read-Host -Prompt "Client où modifier le mot de passe ?"
            # On demande sur quel compte modifier le mot de passe
            $choix2 = Read-Host -Prompt "De quel compte voulez vous modifier le mot de passe ?"
            # On demande le nouveau mot de passe
            $choix3 = Read-Host -Prompt "Quel est le nouveau mot de passe ?" -AsSecureString
            # On lance la commande
            Invoke-Command -ComputerName $client -ScriptBlock { Get-LocalUser -Name $Using:choix2 | Set-LocalUser -Password $Using:choix3 }
            # On log l'action effectuée
            log_events "ActionModifierMDP$client"
        }
        
        3{
            # On demande sur quel client lancer la commande
            $client = Read-Host -Prompt "Client où supprimer un utilisateur ?"
            # On demande quel utilisateur supprimer
            $choix4 = Read-Host -Prompt "Quel utilisateur voulez vous supprimer ?"
            # On lance la commande
            Invoke-Command -ComputerName $client -ScriptBlock { Remove-LocalUser -Name $Using:choix4 }
            # On log l'action effectuée
            log_events "ActionSupprimerUtilisateur$client"
        }
        
        4{
            # On demande sur quel client lancer la commande
            $client = Read-Host -Prompt "Client où supprimer un utilisateur ?"
            # On demande quel utilisateur verrouiller
            $choix5 = Read-Host -Prompt "Quel utilisateur voulez vous bloquer ?"
            # On lance la commande
            Invoke-Command -ComputerName $client -ScriptBlock { Disable-LocalUser -Name $Using:choix5 }
            # On log l'action effectuée
            log_events "ActionDesactiverUtilisateur$client"
        }
        
        default 
        { 
            # Cas par défaut si l'entrée de l'utilisateur est erronnée
            Write-Host "Entrée erronnée" 
        }
    }
}



#Fonction 2 : 
# - Ajout à un groupe local 
# - Sortie d'un groupe local 
function groupe_local
{

$groupe_local = @"
Tapez 1 pour vous ajouter a un groupe local
Taper 2 pour sortir d'un groupe local
"@

Write-Host $groupe_local

$choix_groupe_local = Read-Host -Prompt "Que voulez vous faire ?"

    switch ($choix_groupe_local)
    {
        1 
        { 
        $choix_groupe_local1 = Read-Host -Prompt "Quel groupe voulez vous intégrer ?"
        #donner la liste des groupes ? get-localgroup
        $choix_groupe_local2 = Read-Host -Prompt "Quel utilisateur voulez vous intégrer au groupe $choix_groupe_local1 ?"
        #donner liste utilisateur ? get-localuser
        add-localgroupmember -group $choix_groupe_local1 -Member $choix_groupe_local2
        }

        2 
        { 
        $choix_groupe_local3 = Read-Host -Prompt "Quel groupe voulez vous quitter ?"
        $choix_groupe_local4 = Read-Host -Prompt "Quel utilisateur voulez vous faire quitter le groupe $choix_groupe_local3 ?"
        remove-localgroupmember -group $choix_groupe_local3 -Member $choix_groupe_local4
        }
    }

}



#Fonction 3 : 
# - Arret 
# - Redémarrage 
# - Vérouillage 

function shut 
{

$shut = @"
Tapez 1 pour éteindre le système 
Tapez 2 pour redémarrer le système
Tapez 3 pour vérrouiller le système
"@

Write-Host $shut

$choix_shut = Read-Host -Prompt "Que voulez vous faire ?"

    switch ($choix_shut)
    {
        1 
        { 
        stop-computer 
        }

        2 
        {
        restart-computer 
        }

        3 
        { 
        rundll32.exe user32.dll,LockWorkStation 
        }

    }
}



#Fonction 5 :
# - Création de répertoire 
# - Modification de repertoire 
# - -Suppression de répertoire 
function repertoire
{

$repertoire = @"
Taper 1 pour créer un dossier
Taper 2 pour modifier un dossier 
Taper 3 pour supprimer un dossier
"@

Write-Host $repertoire

$choix_repertoire = Read-Host -Prompt "Que voulez vous faire ?"

switch ($choix_repertoire)
    {

    1 
        { 
        $choix_repertoire1 = Read-Host -Prompt "Comment voulez vous appeler le dossier ?"
        new-item -itemType Directory -name $choix_repertoire1 
        #laisser a l'utilisateur le choix de la localisation du dossier ?
        }

    2 
        { 
        $choix_repertoire2 = Read-Host -Prompt "Quel dossier voulez vous modifier ? Veuillez mettre le chemin avec le nom"
        $choix_repertoire3 = Read-Host -Prompt "Par quel nom voulez vous le remplacer ?"
        rename-item -path $choix_repertoire2 -newname $choix_repertoire3
        }

    3 
        { 
        $choix_repertoire4 = Read-Host -Prompt "Quel dossier voulez vous supprimer ? Veuillez mettre le chemin avec le nom"
        remove-item $choix_repertoire4
        }

    }

}



# Fonction 7 : 
# - Définition de règle de pare-feu 
# - Activation du pare-feu
# - Désactivation du pare feu 
function pare_feu
{

$pare_feu = @"
1) Définition de règle de pare feu
2) Activation de pare feu
3) Désactivation de pare feu
"@

Write-Host $pare_feu

$choix_pare_feu = Read-Host -Prompt "Que voulez vous faire ?"

    switch ($choix_pare_feu)
    {
        1
        {
        $choix_pare_feu1 = Read-Host -Prompt "Quel règle voulez vous définir ? Veuiller enseigner :
        -Name 
        -DisplayName 
        -Profile 
        -Enabled 
        -Protocol 
        -LocalPort 
        -Action 
        -LocalAddress 
        Exemple : -Name ""SSH"" -DisplayName ""Autoriser SSH (Port 22)"" -Profile Domain -Enabled True -Protocol TCP -LocalPort 22 -Action Allow -LocalAddress 192.168.100.13"
        New-NetFirewallRule $choix_pare_feu1
        }

        2
        {
        Set-NetFirewallProfile -Profile * -Enabled True
        }

        3
        {
        Set-NetFirewallProfile -Profile * -Enabled False
        }

    }    
}


#Fonction 8 :
# - Installation de logiciel
# - Désinstallation de logiciel 
# - Execution de script sur la machine distante 
function logiciel
{
$logiciel = @"
1) Installation de logiciel
2) Désinstallation de logiciel 
3) Executer du script sur une machine distante
"@

Write-Host $logiciel

$choix_logiciel = Read-Host -Prompt "Que voulez vous faire ?"

    switch ($choix_logiciel)
    {
        1
        {
        Register-PackageSource -Name chocolatey -ProviderName Chocolatey -Location http://chocolatey.org/api/v2/
        Register-PackageSource -Name MyNuGet -Location https://www.nuget.org/api/v2 -ProviderName NuGet
        Write-host "Nous allons vérifier si le logiciel voulu existe"
        $choix_logiciel1 = Read-Host -Prompt "Quel logiciel voulez vous installer ?"
        #Find-Package -Name *Adobe* -Source Chocolatey => pour savoir si le logiciel existe et son nom exacte ici AdobReader
        Find-Package -Name $choix_logiciel1 -Source MyNuget
        $choix_vrai_logiciel = Read-host -Prompt "Quel est le vrai nom du logiciel que vous voulez installer ?"
        $choix_version = Read-host -Prompt "Quel est la version du logiciel que vous voulez installer ?"
        #Find-Package -Name $choix_vrai_logiciel -RequiredVersion $choix_version | Install-Package
        Install-Package -Name $choix_vrai_logiciel -Source MyNuget -RequiredVersion $choix_version
        }

        2
        {
        $choix_logiciel2 = Read-Host -Prompt "Quel logiciel voulez vous désinstaller ?"
        uninstall-package $choix_logiciel2
        }

        3
        {
        $choix_logiciel3 = Read-Host -Prompt "Sur quelle machine voulez vous le faire ?"
        $choix_logiciel4 = Read-Host -Prompt "Quel script voulez vous utiliser ? Merci d'écrire le nom du fichier avec son chemin absolu"
        Invoke-Command -ComputerName $choix_logiciel3 -FilePath $choix_logiciel4
        }
    }
}


# Fonctions infos droits utilisateur
function info_droits
{
    # On demande à l'utilisateur ce qu'il souhaite faire
    $droits = @"
    1) Consulter droits/permissions de l’utilisateur sur un dossier
    2) Consulter droits/permissions de l’utilisateur sur un fichier
"@
    Write-Host $droits

    # On lit le choix de l'utilisateur
    $choix_droits = Read-Host -Prompt "Que voulez vous faire ?"

    # On applique son choix
    switch ($choix_droits)
        {
            1{
                # On demande sur quel client récupérer l'information
                $client = Read-Host -Prompt "Sur quel client récupérer l'info ?"
                # On demande sur quel dossier récupérer l'information
                $choix_droits1 = Read-host -Prompt "Quel dossier ? Syntaxte chemin absolu .\<nom dossier>\"
                # On lance la commande
                $Info = Invoke-Command -ComputerName $client -ScriptBlock { Get-Acl -Path $Using:choix_droits1 }
                # On affiche l'information
                Write-Output $Info
                # On log l'info obtenue
                log_infos -LogCible $client -LogInfo $Info
                # On log l'action effectuée
                log_events "InfoDroitDossier$client"
            }
            
            2{
                # On demande sur quel client récupérer l'information
                $client = Read-Host -Prompt "Sur quel client récupérer l'info ?" 
                # On demande sur quel dossier récupérer l'information
                $choix_droits2 = Read-host -Prompt "Quel fichier ? Syntaxte chemin absolu .\<nom dossier>\ avec le .txt par exemple" 
                # On lance la commande
                $Info = Invoke-Command -ComputerName $client -ScriptBlock { Get-Acl -Path $Using:choix_droits1 }
                # On affiche l'information
                Write-Output $Info
                # On log l'info obtenue
                log_infos -LogCible $client -LogInfo $Info
                # On log l'action effectuée
                log_events "InfoDroitFichier$client"
            }
        }
}


# Fonction info OS
function info_OS
{   
    # On demande sur quel client récupérer l'information
    $client = Read-Host -Prompt "Sur quel client récupérer l'info ?"
    # On lance la c ommande
    $Info = Invoke-Command -ComputerName $client -ScriptBlock { Get-WmiObject Win32_OperatingSystem | Select-Object Caption, Version }
    # On affiche l'information
    Write-Output $Info
    # On log l'info obtenue
    log_infos -LogCible $client -LogInfo $Info
    # On log l'action effectée
    log_events "InfoOS$client"
}



# Fonction infos Disque
function info_partition 
{
    # On demande à l'utilisateur ce qu'il souhaite faire
    $partition = @"
    1) Nombre de disque 
    2) Partition (nombre, nom, FS, taille) par disque
"@
    Write-Host $partition

    # On lit le choix de l'utilisateur 
    $choix_partition = Read-Host -Prompt "Que voulez vous faire ?"

    # On applique son choix
    switch ($choix_partition)
    {    
        1{
            # On demande sur quel client récupérer l'information
            $client = Read-Host -Prompt "Sur quel client récupérer l'info ?"
            # On lance la commande    
            $Info = Invoke-Command -ComputerName $client -ScriptBlock { Get-Disk }
            # On affiche l'information
            Write-Output $Info
            # On log l'info obtenue
            log_infos -LogCible $client -LogInfo $Info
            # On log l'action effectuée
            log_events "InfoDisques$client"
        }
    
        2{
            # On demande sur quel client récupérer l'information
            $client = Read-Host -Prompt "Sur quel client récupérer l'info ?"
            # On lance la commande  
            $Info = Invoke-Command -ComputerName $client -ScriptBlock { Get-Partition }
            # On affiche l'information
            Write-Output $Info
            # On log l'info obtenue
            log_infos -LogCible $client -LogInfo $Info
            # On log l'action effectuée
            log_events "InfoPartitions$client"
        }
    }
}


# Fonction infos applications installées
function info_paquets
{
    # On demande à l'utilisateur ce qu'il souhaite faire
    $paquets = @"
    1) Liste des applications/paquets installées
    2) Liste des services en cours d'execution
    3) Liste des utilisateurs locaux
"@
    Write-Host $paquets

    # On lit le choix de l'utilisateur
    $choix_paquets = Read-Host -Prompt "Que voulez vous faire ?"
    # On applique le choix de l'utilisateur
    switch ($choix_paquets)
    {
        1{
            # On demande sur quel client récupérer l'information
            $client = Read-Host -Prompt "Sur quel client récupérer l'info ?"
            # On lance la commande              
            $Info = Invoke-Command -ComputerName $client -ScriptBlock { Get-AppxPackage }
            # On affiche l'information
            Write-Output $Info
            # On log l'info obtenue
            log_infos -LogCible $client -LogInfo $Info
            # On log l'action effectuée
            log_events "InfoApps$client"
        }
        
        2{
            # On demande sur quel client récupérer l'information
            $client = Read-Host -Prompt "Sur quel client récupérer l'info ?"
            # On lance la commande              
            $Info = Invoke-Command -ComputerName $client -ScriptBlock { Get-Service }
            # On affiche l'information
            Write-Output $Info
            # On log l'info obtenue
            log_infos -LogCible $client -LogInfo $Info
            # On log l'action effectuée
            log_events "InfoServices$client"
        }
        
        3{
            # On demande sur quel client récupérer l'information
            $client = Read-Host -Prompt "Sur quel client récupérer l'info ?"
            # On lance la commande              
            $Info = Invoke-Command -ComputerName $client -ScriptBlock { Get-LocalUser }
            # On affiche l'information
            Write-Output $Info
            # On log l'info obtenue
            log_infos -LogCible $client -LogInfo $Info
            # On log l'action effectuée
            log_events "InfoUtilisateurs$client"
        }
    }
}
# Fonction infos matériel
function info_CPU
{
    # On demande à l'utilisateur ce qu'il souhaite faire
    $CPU = @"
    1) Type de CPU, nombre de coeurs, etc.
    2) Mémoire RAM totale
    3) Utilisation de la RAM
    4) Utilisation du disque
    5) Utilisation du processeur
"@
    Write-Host $CPU

    # On lit le choix de l'utilisateur
    $choix_paquets = Read-Host -Prompt "Que voulez vous faire ?"
    # On applique le choix de l'utilisateur
    switch ($choix_paquets){
        1{
            # On demande sur quel client récupérer l'information
            $client = Read-Host -Prompt "Sur quel client récupérer l'info ?"
            # On lance la commande
            $Info = Invoke-Command -ComputerName $client -ScriptBlock { systeminfo.exe }
            # On affiche l'information
            Write-Output $Info
            # On log l'info obtenue
            log_infos -LogCible $client -LogInfo $Info
            # On log l'action effectuée
            log_events "InfoCPU$client"
        }
        
        2{
            # On demande sur quel client récupérer l'information
            $client = Read-Host -Prompt "Sur quel client récupérer l'info ?"
            # On lance la commande
            $Info = Invoke-Command -ComputerName $client -ScriptBlock { systeminfo.exe }
            # On affiche l'information
            Write-Output $Info
            # On log l'info obtenue
            log_infos -LogCible $client -LogInfo $Info
            # On log l'action effectuée
            log_events "InfoRAM$client"
        }
        
        3{
            # On demande sur quel client récupérer l'information
            $client = Read-Host -Prompt "Sur quel client récupérer l'info ?"
            # On lance la commande
            $Info = Invoke-Command -ComputerName $client -ScriptBlock { systeminfo.exe }
            # On affiche l'information
            Write-Output $Info
            # On log l'info obtenue
            log_infos -LogCible $client -LogInfo $Info
            # On log l'action effectuée
            log_events "InfoRAM$client"
        }
        
        4{
            # On demande sur quel client récupérer l'information
            $client = Read-Host -Prompt "Sur quel client récupérer l'info ?"
            # On lance la commande
            $Info = Invoke-Command -ComputerName $client -ScriptBlock { Get-CimInstance -ClassName Win32_LogicalDisk }
            # On affiche l'information
            Write-Output $Info
            # On log l'info obtenue
            log_infos -LogCible $client -LogInfo $Info
            # On log l'action effectuée
            log_events "InfoUtilDisque$client"
        }
        
        5{
            # On demande sur quel client récupérer l'information
            $client = Read-Host -Prompt "Sur quel client récupérer l'info ?"
            # On lance la commande
            $Info = Invoke-Command -ComputerName $client -ScriptBlock { Get-Counter }
            # On affiche l'information
            Write-Output $Info
            # On log l'info obtenue
            log_infos -LogCible $client -LogInfo $Info
            # On log l'action effectuée
            log_events "InfoUtilCPU$client"
        }
    }
}


# Fonction recherche dans les logs
function search_log 
{
    # On demande à l'utilisateur ce qu'il veut faire
    $search_log = @"
    1) Recherche des evenements dans le fichier log_evt.log pour un utilisateur
    2) Recherche des evenements dans le fichier log_evt.log pour un ordinateur
"@
    # On lit la réponse de l'utilisateur
    $choix_search_log = Read-Host -Prompt "Que voulez vous faire ?"
    # On applique le choix de l'utilisateur
    switch ($choix_search_log)
    {    
        1{
            $choix_search_log1 = Read-Host -Prompt "Quel utilisateur ?"
            #$choix_search_log2 = Read-Host -Prompt "Quel évenement ? Action ou Information ?"
            Select-String -Path "C:\Windows\System32\LogFiles\log_evt.log" -Pattern $choix_search_log1 $choix_search_log2
        }

        2{
            $choix_search_log3 = Read-Host -Prompt "Sur quelle machine ?"
            #$choix_search_log4 = Read-Host -Prompt "Quel évenement ? Action ou Information ?"
            Select-String -Path "C:\Windows\System32\LogFiles\log_evt.log" -Pattern $choix_search_log3 $choix_search_log4
        }
    }
}

# ----------------------------------------------------------------------------------------------------------------------------- #
# ----------------------------------------------------------------------------------------------------------------------------- #
# ----------------------------------------------------------------------------------------------------------------------------- #
# ----------------------------------------------------------------------------------------------------------------------------- #
# ----------------------------------------------------------------------------------------------------------------------------- #
# ----------------------------------------------------------------------------------------------------------------------------- #
# ----------------------------------------------------------------------------------------------------------------------------- #

# Journalisation des actions
function log_events{
    # On passe l'action réalisée en premier argument positionnel de la fonction
    param (
        [string[]]$Event
    )
    # On récupère la date au format yyyymmjj
    $logDate = Get-Date -Format "yyyyMMdd"
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
    $logDate = Get-Date -Format "yyyyMMdd"
    # On crée le nom du fichier à construire
    $logFile = "info_$LogCible_$LogDate.txt"
    # On créé le fichier avec les informations
    Write-Output $LogInfo >> log\$logFile
}

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
                    Write-Host "1) Informations compte utilisateur / W.I.P \"
                    Write-Host "2) Informations groupes et commandes utilisateur / W.I.P \"
                    Write-Host "3) Droits et permissions utilisateur"
                    Write-Host "r) Retour"
                    Write-Host "q) Quitter"
                    $choix3 = Read-Host
                    # On applique le choix de l'utilisateur
                    Switch($choix3){
                        "1" {
                            Write-Host "/ W.I.P \"
                        }
                        "2" {
                            Write-Host "/ W.I.P \"
                        }
                        "3" {
                            info_droits
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
                    Switch($choix3){
                        "1" {
                            info_OS
                        }
                        "2" {
                            info_partition
                        }
                        "3" {
                            info_paquets
                        }
                        "4" {
                            info_CPU
                        }
                        "5" {
                            search_log
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