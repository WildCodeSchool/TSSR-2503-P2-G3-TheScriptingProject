#!ps1

#function nom
#{
#   instructions
#    }


#Fonction 1 :
# - Création compte utilisateur local 
# - Changement de mot de passe 
# - Suppression compte utilisateur local
# - Désactivation compte utilisateur local 
function utilisateur_local
{$utilisateur_local = @"
Taper 1 pour créer un compte utilisateur 
Taper 2 pour changer le mot de passe 
Taper 3 pour supprimer un compte utilisateur 
Taper 4 pour désactiver un compte
"@

$utilisateur_local
$choix = Read-Host -Prompt "choix ?"

switch ($utilisateur_local)
{
    1 {New-LocalUser}
    2 {Set-LocalUser}
    3 {Remove-LocalUser}
    4 {Disable-LocalUser}
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
    1 { $choix_groupe_local1 = Read-Host -Prompt "Quel groupe voulez vous intégrer ?"
    add-localgroupmember -group $choix_groupe_local1
    }
    2 { $choix_groupe_local2 = Read-Host -Prompt "Quel groupe voulez vous quitter ?"
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
#besoin d'une fonction dans cette fonction pour log le journal utilisateur ??


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
