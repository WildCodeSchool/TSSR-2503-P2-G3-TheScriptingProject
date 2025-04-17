# TSSR-2503-P2-G3-TheScriptingProject

## Install SSH

### Sur Ubuntu

Installer openssh-server : `sudo apt install openssh-server`

Modifier fichier */etc/ssh/sshd_config* en y ajoutant *PermitRootLogin yes*

Activer le compte root `sudo passwd root` puis `sudo passwd -u root`

### Sur Windows

Installer openssh-server : `Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0`
Démarrer le service : `Start-Service -Name "sshd"`
Lancement automatique du service : `Set-Service -Name "sshd" -StartupType Automatic`

Dépendances script bash :

* ufw
* hwinfo
* htop
