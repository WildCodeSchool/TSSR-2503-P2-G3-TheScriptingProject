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
