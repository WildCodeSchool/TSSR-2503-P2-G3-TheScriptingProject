#!ps1

#Fonction 1 :
# - Création compte utilisateur local 
# - Changement de mot de passe 
# - Suppression compte utilisateur local
# - Désactivation compte utilisateur local 

$utilisateur_local = @"
Taper 1 pour créer un compte utilisateur 
Taper 2 pour changer le mot de passe 
Taper 3 pour supprimer un compte utilisateur 
Taper 4 pour désactiver un compte
"@

$utilisateur_local
$choix = Read-Host -Prompt "choix ?"

switch ($choix)
{
#1 fonctionne
    1 {New-LocalUser}
#2 en travaux superutilisateur ?
    2 {
        $Password = Read-Host -AsSecureString
        $UserAccount = Get-LocalUser 
        $UserAccount | Set-LocalUser -Password $Password
    }
    3 {Remove-LocalUser}
    4 {Disable-LocalUser}
    Default {Write-Host "Je ne comprends pas votre commande"}
}



#Fonction 2 : 
# - Ajout à un groupe local 
# - Sortie d'un groupe local 

$groupe_local = @"
Tapez 1 pour vous ajouter a un groupe local
Taper 2 pour sortir d'un groupe local
"@
$groupe_local
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

#Fonction 3 : 
# - Arret 
# - Redémarrage 
# - Vérouillage 

$shut = @"
Tapez 1 pour éteindre le système 
Tapez 2 pour redémarrer le système
Tapez 3 pour vérrouiller le système
"@
$shut 
$choix_shut = Read-Host -Prompt "Que voulez vous faire ?"
switch ($choix_shut)
{
    1 { stop-computer }
    2 { restart-computer }
    3 { rundll32.exe user32.dll,LockWorkStation }
}


#Fonction 4 : 
# - Mise-à-jour du système 

$update = PSWindowsUpdate


#Fonction 5 :
# - Création de répertoire 
# - Modification de repertoire 
# - -Suppression de répertoire 

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
