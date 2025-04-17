#!ps1

#function nom
#{
#   instructions
#    }
######################################################################################################
# Les applets de commande Windows PowerShell sont incluses dans les outils d'administration de serveur distant Windows (RSAT). 
#Pour installer RSAT sous Windows 10 version 1809 ou ultérieure, utilisez la commande suivante :
#
#Get-WindowsCapability -Name RSAT.ActiveDirectory* -Online | Add-WindowsCapability -Online
#
#Si vous utilisez une version antérieure de Windows, vous devrez télécharger et installer RSAT manuellement.
########################################################################################################

########################################################################################################
#
#    Cliquez  sur Démarrer  et recherchez « PowerShell » . Choisissez  « Windows PowerShell » dans les résultats.
#    Installez le module PowerShell AD en exécutant l'  applet de commande Install-WindowsFeature . Pour ajouter des fonctionnalités enfants, veillez à inclure les paramètres indiqués ici :
#
#Install-WindowsFeature -Name “RSAT-AD-PowerShell” -IncludeAllSubFeature
#
#Méthode 2 : Installation à l'aide de PowerShell
#Étape 2 : Importer le module PowerShell Active Directory
#
#Une fois le module installé, vous devez l'ajouter à votre session actuelle. Les étapes suivantes sont valables pour Windows 10 et toutes les versions de Windows Server :
#
#    Cliquez sur Démarrer  et recherchez  « PowerShell ».  Choisissez « WindowsPowerShell » dans les résultats.
#    Exécutez la commande suivante pour vérifier que le module est disponible sur votre système :
#
#Get-Module -Name ActiveDirectory -ListAvailable
#
#Étape 2 : Importer le module PowerShell Active Directory
#
#    Importez le module à l'aide de l'applet de commande Import-Module comme suit :
#
#Import-Module -Name ActiveDirectory
#
#
############################################################################################


#Fonction 1 :
# - Création compte utilisateur local 
# - Changement de mot de passe 
# - Suppression compte utilisateur local
# - Désactivation compte utilisateur local 
function utilisateur_local
{
utilisateur_local = @"
    Taper 1 pour créer un compte utilisateur 
    Taper 2 pour changer le mot de passe 
    Taper 3 pour supprimer un compte utilisateur 
    Taper 4 pour désactiver un compte
"@

    $choix = Read-Host -Prompt "choix ?"

    switch ($choix)
    {
        1 
        {
            $choix1 = Read-Host -Prompt "Quel est le nom du nouvel utilisateur ?"
            New-LocalUser $choix1
        }
        
        2 
        {
        $choix2 = Read-Host -Prompt "De quel compte voulez vous modifier le mot de passe ?"
        #la commande marche pas alors que ca devrait. bizarre
        Set-ADAccountPassword -Identity $choix2 -Reset
        }
        
        3 
        {
        $choix3 = Read-Host -Prompt "Quel utilisateur voulez vous supprimer ?"
        Remove-LocalUser -Name $choix3
        }
        
        4 
        {
        $choix4 = Read-Host -Prompt "Quel utilisateur voulez vous bloquer ?"
        Disable-LocalUser -Name $choix4
        }
        
        default 
        { 
        Write-Host "Je ne comprends pas" 
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
$choix_groupe_local = Read-Host -Prompt "Que voulez vous faire ?"
switch ($choix_groupe_local)
{
    1 
    { 
    $choix_groupe_local1 = Read-Host -Prompt "Quel groupe voulez vous intégrer ?"
    add-localgroupmember -group $choix_groupe_local1
    }
    2 
    { $choix_groupe_local2 = Read-Host -Prompt "Quel groupe voulez vous quitter ?"
    remove-localgroupmember -group $choix_groupe_local2
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
$choix_shut = Read-Host -Prompt "Que voulez vous faire ?"
switch ($choix_shut)
{
    1 { stop-computer }
    2 { restart-computer }
    3 { rundll32.exe user32.dll,LockWorkStation }
}
}

#Fonction 4 : 
# - Mise-à-jour du système 
function update 
{
$update = PSWindowsUpdate
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
$repertoire
$choix_repertoire = Read-Host -Prompt "Que voulez vous faire ?"
switch ($choix_repertoire)
    {
    1 { $choix_repertoire1 = Read-Host -Prompt "Comment voulez vous appeler le dossier ?"
        new-item -itemType Directory -name $choix_repertoire1 }
    2 { $choix_repertoire2 = Read-Host -Prompt "Quel dossier voulez vous modifier ? Veuillez mettre le chemin avec le nom"
        $choix_repertoire3 = Read-Host -Prompt "Par quel nom voulez vous le remplacer ?"
        rename-item : -path $choix_repertoire2 -newname $choix_repertoire3
        }
    3 { $choix_repertoire4 = Read-Host -Prompt "Quel dossier voulez vous supprimer ? Veuillez mettre le chemin avec le nom"
        remove-item $choix_repertoire4
    }
    }
}


#Fonction 6 : 
# - Prise en main a distance (CLI)
## s'assurer que WinRM est bien configuré (SERVWIN01 c'est par defaut mais CLIWIN01 faut configurer => Enable-PSRemoting)
#https://www.it-connect.fr/powershell-executer-commandes-et-scripts-a-distance-avec-invoke-command/
function CLI
{
    Invoke-Command 
}


# Fonction 7 : 
# - Définition de règle de pare-feu 
# - Activation du pare-feu
# - Désactivation du pare feu 
function pare_feu
{
    pare_feu = @"
1) Définition de règle de pare feu
2) Activation de pare feu
3 Désactivation de pare feu
"@
$choix_pare_feu = Read-Host -Prompt "Que voulez vous faire ?"
    switch ($choix_pare_feu)
    {
        1)
        $choix_pare_feu1 = Read-Host -Prompt "Quel règle voulez vous définir ? Veuiller enseigner :
        -Name 
        -DisplayName 
        -Profile 
        -Enabled 
        -Protocol 
        -LocalPort 
        -Action 
        -LocalAddress "
        New-NetFirewallRule $choix_pare_feu1
        2)
        Set-NetFirewallProfile -Profile * -Enabled True
        3)
        Set-NetFirewallProfile -Profile * -Enabled False
    }    
}

#Fonction 8 : 
# - Installation de logiciel
# - Désinstallation de logiciel 
# - Execution de script sur la machine distante 
function logiciel
{
    logiciel = @"
1) Installation de logiciel
2) Désinstallation de logiciel 
3) Executer du script sur une machine distante
"@
$choix_logiciel = Read-Host -Prompt "Que voulez vous faire ?"
    switch $choix_logiciel
    1) 
    $choix_logiciel1 = Read-Host -Prompt "Quel logiciel voulez vous installer ?"
    #Find-Package -Name *Adobe* -Source Chocolatey => pour savoir si le logiciel existe et son nom exacte ici AdobReader
    Install-Package -Name $choix_logiciel1 -ProviderName Chocolatey
    2)
    $choix_logiciel2 = Read-Host -Prompt "Quel logiciel voulez vous désinstaller ?"
    winget uninstall $choix_logiciel2
    3)
    $choix_logiciel3 = Read-Host -Prompt "Sur quelle machine voulez vous le faire ?"
    $choix_logiciel4 = Read-Host -Prompt "Quel script voulez vous utiliser ? Merci d'écrire le nom du fichier avec son chemin absolu"
    Invoke-Command -ComputerName $choix_logiciel3 -FilePath $choix_logiciel4
}

#Fonction 9 :
# - Date de dernière connexion d’un utilisateur
# - Date de dernière modification du mot de passe
# - Liste des sessions ouvertes par l'utilisateur
#https://hichamkadiri.wordpress.com/2018/07/15/active-directory-tip-of-the-week-howto-connaitre-la-date-de-changement-du-mot-de-passe-de-votre-comptes-users-ad-via-powershell/
function user 
{
    user = @"
1) Date de dernière connexion d'un utilisateur 
2) Date de dernière modifiction du mot de passe 
3) Liste des sessions ouverte par l'utilisateur
"@
$choix_user = Read-Host -Prompt "Que voulez vous faire ?"
    switch $choix_user 
    1) 
    $choix_user1 = read-Host -Prompt "Quel utilisateur voulez vous voir la derniere connexion ?"
    #last-logon est un attribut.
    #L'attribut "lastLogon" contient la date et l'heure de la dernière ouverture de session d'un utilisateur, 
    #c'est-à-dire sa dernière connexion au domaine Active Directory. 
    Last-Logon -identity $choix_user1
    2)
    $choix_user2 Read-Host -Prompt "Quel utilisateur voulez voir voir la derniere modification du mot de passe ?"
    Get-ADUser -identity $choix_user2 -Properties Name, PasswordLastSet | Select Name, PasswordLastSet
    3)
    $choix_user3 = Read-Host -Prompt "Quel utilisateur voulez vous voir sa liste d'ouverture de sessions ?"
    Get-PSSession -identity $choix_user3
}



#Fonction 10 : 
# - Groupe d’appartenance d’un utilisateur
# - Historique des commandes exécutées par l'utilisateur
function groupe_user
{
    groupe_user =@"
1) Groupe d’appartenance d’un utilisateur
2) Historique des commandes exécutées par l'utilisateur
"@
$choix_groupe_user = Read-Host -Prompt "Que voulez vous faire ?"
    switch $choix_groupe_user
    1)
    $choix_groupe_user1 = Read-host -Prompt "A quel utilisateur voulez vous voir le groupe ?"
    Get-ADUser -Identity $choix_groupe_user1 -Properties memberof | Select-Object memberof -ExpandProperty memberof
    2) 
    $choix_groupe_user2 = Read-host -Prompt "A quel utilisateur voulez vous voir l'historique ?"
    Get-content %$choix_groupe_user2%\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt
}

#Fonction 11 : 
# - Droits/permissions de l’utilisateur sur un dossier
# - Droits/permissions de l’utilisateur sur un fichier
function Droits
{
    Droits = @"
1) Droits/permissions de l’utilisateur sur un dossier
2) Droits/permissions de l’utilisateur sur un fichier
"@
$choix_droits = Read-Host -Prompt "Que voulez vous faire ?"
    switch $choix_droits
    1)
    $choix_droits1 = Read-host -Prompt "Quel dossier ? Syntaxte .\<nom dossier>\"
    Get-NTFSAccess $choix_droits1
    2) 
    $choix_droits2 = Read-host -Prompt "Quel fichier ? Syntaxte .\<nom dossier>\"
    Get-NTFSAccess $choix_droits2
}


#Fonction 12 : 
# - Version de l'OS
function OS
{
    Get-WmiObject Win32_OperatingSystem | Select-Object Caption, Version
}

#Fonction 13 : 
# - Nombre de disque
# - Partition (nombre, nom, FS, taille) par disque
function partition 
{
    partition = @"
1) Nombre de disque 
2) Partition (nombre, nom, FS, taille) par disque
"@
$choix_partition = Read-Host -Prompt "Que voulez vous faire ?"
switch $choix_partition
    1)
    Get-disk
    2)
    Get-Partition
}

#Fonction 14 : 
# - Liste des applications/paquets installées
# - Liste des services en cours d'execution
# - Liste des utilisateurs locaux
function paquets{
    paquets = @"
1) Liste des applications/paquets installées
2) Liste des services en cours d'execution
3) Liste des utilisateurs locaux
"@
$choix_paquets = Read-Host -Prompt "Que voulez vous faire ?"
switch $choix_paquets
    1)
    Get-AppxPackage
    2)
    Get-Service
    3)
    Get-LocalUser
}


#Fonction 15 : 
# - Type de CPU, nombre de coeurs, etc.
# - Mémoire RAM totale
# - Utilisation de la RAM
# - Utilisation du disque
# - Utilisation du processeur
function CPU
{
    CPU = @"
1) Type de CPU, nombre de coeurs, etc.
2) Mémoire RAM totale
3) Utilisation de la RAM
4) Utilisation du disque
5) Utilisation du processeur
"@
$choix_CPU = Read-Host -Prompt "Que voulez vous faire ?"
switch $choix_paquets
    1)
    systeminfo.exe
    2)
    systeminfo.exe
    3)
    systeminfo.exe
    4)
    Get-CimInstance -ClassName Win32_LogicalDisk 
    5)
    Get-Counter

}

#Fonction 16 : 
# - Recherche des evenements dans le fichier log_evt.log pour un utilisateur
# - Recherche des evenements dans le fichier log_evt.log pour un ordinateur
#https://learn.microsoft.com/fr-fr/powershell/module/microsoft.powershell.management/get-eventlog?view=powershell-5.1
function search_log 
{
    search_log = @"
1) Recherche des evenements dans le fichier log_evt.log pour un utilisateur
2) Recherche des evenements dans le fichier log_evt.log pour un ordinateur
"@
$choix_search_log = Read-Host -Prompt "Que voulez vous faire ?"
switch $choix_search_log
    1
    {
        #$choix_search_log1 = Read-Host -Prompt "Sur quel machine ?"
        $choix_search_log1 = Read-Host -Prompt "Quel utilisateur ?"
        #Get-EventLog -ComputerName $choix_search_log1 
        #A confirmer
        #Juste chercher dans fichier log_evt.log ?
        Select-String -Path "C:\" -Pattern $choix_search_log1
        #mettre chemin dossier log
    }
    2
    {
        $choix_search_log2 = Read-Host -Prompt "Sur quel machine ?"
        Select-String -Path "C:\" -Pattern $choix_search_log2
        #mettre chemin dossier log
    }

}

#get execution policy 
#set execution policy => bypass
