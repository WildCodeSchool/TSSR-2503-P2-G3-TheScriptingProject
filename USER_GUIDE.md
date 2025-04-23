# 🖥️ GUIDE D'UTILISATION

## 🐧 Utilisation Linux  

* Connexion root

Script exécuté depuis le terminal.

Dans le même dossier que le script, lancer la commande suivante :

```bash
./administration.sh
```

> Script dans dossier :

## 🪟 Utilisation Windows

* Connexion Administrateur

Script exécuté depuis le terminal (PowerShell 7!)

Dans le même dossier que le script, lancer la commande suivante :
```PowerShell
.\administration.ps1
```

> Script dans dossier :

## ❓ FAQ

#### Comment installer les script ?

Les scripts sont déjà présents sur les machines serveur. Les machines sur lesquelles vous pouvez les utiliser sont déjà configurées. Pour en savoir plus, vous pouvez consulter **INSTALL.md**.

#### Faut-il configurer des droits ou des permissions spécifiques ?

Les scripts déjà présents sur les machines serveur ont le droit de s'exécuter, vous ne devriez rien avoir à faire de plus. Les cas échéant, vous pouvez utiliser les commandes [chmod](https://www.ionos.fr/digitalguide/serveur/know-how/attribution-de-droits-sur-un-repertoire-avec-chmod/) sur Linux et [Unblock-File](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/unblock-file?view=powershell-7.5) sur Windows.

#### Comment ajouter de nouveaux hôtes cibles ?

> Répondre à ça

#### Comment sont gérées les connexions SSH ?

En l'état, les machines Windows sont configurées pour se connecter automatiquement. Elles ne requierrent pas l'utilisation de mots de passe.
Sur Linux, il faut entrer le mot de passe du compte utilisateur (ou le cas échéant root) lorsque vous lancez des commandes.

#### Le script stocke-t-il des identifiants ? Si oui, où et comment sont-ils protégés ?

Le script ne stocke aucune données d'identifiants.
