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
#2 en travaux
    2 {
    $passwd = Read-Host -Prompt "Quel nouveau mot de passe voulez vous utiliser ?" 
    Set-LocalUser -Password $passwd
    }
    3 {Remove-LocalUser}
    4 {Disable-LocalUser}
    Default {Write-Host "Je ne comprends pas votre commande"}
}
