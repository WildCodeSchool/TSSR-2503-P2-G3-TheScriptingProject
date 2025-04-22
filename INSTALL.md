# 🖥️ GUIDE D'INSTALLATION

## ⚡ Prérequis techniques

### Dépendances

#### Sur Linux

Dépendances 
* ufw
* hwinfo
* htop

#### Sur Windows

Dépendances
* Chocolatey
* NuGet

### Configuration de OpenSSH

#### Sur Linux

Installer openssh-server : `sudo apt install openssh-server`

Modifier fichier */etc/ssh/sshd_config* en y ajoutant *PermitRootLogin yes*

Activer le compte root `sudo passwd root` puis `sudo passwd -u root`

#### Sur Windows

Installer openssh-server : `Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0`

Démarrer le service : `Start-Service -Name "sshd"`

Lancement automatique du service : `Set-Service -Name "sshd" -StartupType Automatic`

Modifier fichier *sshd_config* dans *%programdata%\ssh\* en ajoutant `AllowUsers *`

### Préparation Client Windows

Exécutez la commande suivante pour démarrer le service WinRM :
_Set-Service -Name winrm -StartupType Automatic_ 
Pour démarrer le service immédiatement, utilise :
_Start-Service -Name WinRM_ 

Configurez les paramètres de l'hôte distant pour permettre la connexion à distance :
Exécutez la commande suivante pour configurer les paramètres de l'hôte distant :
_Set-Item WSMan:\localhost\Client\TrustedHosts -Value SRVWIN01 -Force_

Une fois la configuration terminée, vous devriez pouvoir vous connecter au serveur
Windows depuis le client Windows en utilisant PowerShell sans être invité à saisir un
mot de passe.
Ouvrir une console PowerShell en administrateur

Récupérer l'index de l'interface
_$Index = (Get-NetConnectionProfile).InterfaceIndex_
Modifier le profil en catégorie Privée
_Set-NetConnectionProfile -InterfaceIndex $Index -NetworkCategory Private_
Si le pare-feu est activé mettre l'exception WinRM
_Enable-PSRemoting -Force_
_Set-NetFirewallRule -Name "WINRM-HTTP-In-TCP" -Enabled True_
OU
_Enable-NetFirewallRule -DisplayName "Windows Remote Management (HTTP-In)"_

Ouvrir un terminal cmd.exe en administrateur et exécuter les commandes :

Configuration du LocalAccountTokenFilterPolicy
_reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f_

Configuration du WinRM
_winrm quickconfig_

## 👨‍💻 Installation des scripts

Les scripts sont déjà présents sur les machines Proxmox.

> Donner localisation des scripts

## ❓ FAQ

### Faut-il avoir des droits d'administrateur pour utiliser ces scripts ?

Oui, ces scripts sont des scripts permettant d'administrer des machines et les comptes utilisateurs qui y sont présents. Ainsi, il est nécessaire de disposer des droits d'administrateur pour les exécuter.

### Puis-je exécuter un script sans l’installer ?

Oui, les scripts sont des petits programmes lancés directement depuis un terminal. Plus d'informations sont présentes dans le document **USER_GUIDE.md**.

### Comment mettre à jour les outils nécessaires à l’exécution d’un script ?

Sur une distribution Debian, vous pouvez mettre à jour les dépendances du script en exécutant les commandes :

```bash
sudo apt update
sudo apt upgrade
```

Sur Windows, il est possible de mettre à jour le système et les dépendances à l'aide des commandes suivantes :

```PowerShell
Get-WindowsUpdate
Install-WindowsUpdate 
```
