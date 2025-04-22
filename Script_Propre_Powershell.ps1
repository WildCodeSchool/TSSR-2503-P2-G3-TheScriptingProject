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
            # On demande quel sera le nom du nouvel utilisateur
            $choix1 = Read-Host -Prompt "Quel est le nom du nouvel utilisateur ?"
            # On lance la commande
            ssh $client powershell.exe New-LocalUser $choix1
        }
        
        2{
            # On demande sur quel client lancer la commande
            $client = Read-Host -Prompt "Client où modifier le mot de passe ?"
            # On demande sur quel compte modifier le mot de passe
            $choix2 = Read-Host -Prompt "De quel compte voulez vous modifier le mot de passe ?"
            # On demande le nouveau mot de passe
            $choix3 = Read-Host -Prompt "Quel est le nouveau mot de passe ?" -AsSecureString
            # On lance la commande
            ssh $client powershell.exe Get-LocalUser -Name $choix2 | Set-LocalUser -Password $choix3
        }
        
        3{
            # On demande sur quel client lancer la commande
            $client = Read-Host -Prompt "Client où supprimer un utilisateur ?"
            # On demande quel utilisateur supprimer
            $choix4 = Read-Host -Prompt "Quel utilisateur voulez vous supprimer ?"
            # On lance la commande
            ssh $client powershell.exe Remove-LocalUser -Name $choix4
        }
        
        4{
            # On demande sur quel client lancer la commande
            $client = Read-Host -Prompt "Client où supprimer un utilisateur ?"
            # On demande quel utilisateur verrouiller
            $choix5 = Read-Host -Prompt "Quel utilisateur voulez vous bloquer ?"
            # On lance la commande
            ssh $client powershell.exe Disable-LocalUser -Name $choix5
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


#Fonction 11 : 
# - Droits/permissions de l’utilisateur sur un dossier
# - Droits/permissions de l’utilisateur sur un fichier
function Droits
{
    $Droits = @"
1) Droits/permissions de l’utilisateur sur un dossier
2) Droits/permissions de l’utilisateur sur un fichier
"@

Write-Host $Droits

$choix_droits = Read-Host -Prompt "Que voulez vous faire ?"
    switch ($choix_droits)
    {
        1
        {
        $choix_droits1 = Read-host -Prompt "Quel dossier ? Syntaxte chemin absolu .\<nom dossier>\"
        Get-Acl -Path $choix_droits1
        }
        
        2
        { 
        $choix_droits2 = Read-host -Prompt "Quel fichier ? Syntaxte chemin absolu .\<nom dossier>\ avec le .txt par exemple" 
        Get-Acl -Path $choix_droits1
        }
    }
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

$partition = @"
1) Nombre de disque 
2) Partition (nombre, nom, FS, taille) par disque
"@

Write-Host $partition

$choix_partition = Read-Host -Prompt "Que voulez vous faire ?"
    switch ($choix_partition)
    {    
        1
        {
        Get-disk
        }
    
        2
        {
        Get-Partition
        }
    }
}


#Fonction 14 : 
# - Liste des applications/paquets installées
# - Liste des services en cours d'execution
# - Liste des utilisateurs locaux
function paquets
{
$paquets = @"
1) Liste des applications/paquets installées
2) Liste des services en cours d'execution
3) Liste des utilisateurs locaux
"@

Write-Host $paquets

$choix_paquets = Read-Host -Prompt "Que voulez vous faire ?"
    switch ($choix_paquets)
    {
        1
        {
        Get-AppxPackage
        }
        
        2
        {
        Get-Service
        }
        
        3
        {
        Get-LocalUser
        }
    }
}


#Fonction 15 : 
# - Type de CPU, nombre de coeurs, etc.
# - Mémoire RAM totale
# - Utilisation de la RAM
# - Utilisation du disque
# - Utilisation du processeur
function CPU
{
$CPU = @"
1) Type de CPU, nombre de coeurs, etc.
2) Mémoire RAM totale
3) Utilisation de la RAM
4) Utilisation du disque
5) Utilisation du processeur
"@

Write-Host $CPU

$choix_paquets = Read-Host -Prompt "Que voulez vous faire ?"
switch ($choix_paquets)
    {
        1
        {
        systeminfo.exe
        }
        
        2
        {
        systeminfo.exe
        }
        
        3
        {
        systeminfo.exe
        }
        
        4
        {
        Get-CimInstance -ClassName Win32_LogicalDisk 
        }
        
        5
        {
        Get-Counter
        }
    }
}


#Fonction 16 : 
# - Recherche des evenements dans le fichier log_evt.log pour un utilisateur
# - Recherche des evenements dans le fichier log_evt.log pour un ordinateur
#https://learn.microsoft.com/fr-fr/powershell/module/microsoft.powershell.management/get-eventlog?view=powershell-5.1
function search_log 
{
    $search_log = @"
    1) Recherche des evenements dans le fichier log_evt.log pour un utilisateur
    2) Recherche des evenements dans le fichier log_evt.log pour un ordinateur
"@
    $choix_search_log = Read-Host -Prompt "Que voulez vous faire ?"
    switch ($choix_search_log)
    {    
        1
        {
        
        $choix_search_log1 = Read-Host -Prompt "Quel utilisateur ?"
        $choix_search_log2 = Read-Host -Prompt "Quel évenement ? Action ou Information ?"
        Select-String -Path "C:\Windows\System32\LogFiles\log_evt.log" -Pattern $choix_search_log1 $choix_search_log2
        }
        
        2
        {
        $choix_search_log3 = Read-Host -Prompt "Sur quel machine ?"
        $choix_search_log4 = Read-Host -Prompt "Quel évenement ? Action ou Information ?"
        Select-String -Path "C:\Windows\System32\LogFiles\log_evt.log" -Pattern $choix_search_log3 $choix_search_log4
        }
    }
}
