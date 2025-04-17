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

Modifier fichier *sshd_config* dans *%programdata%\ssh\* en ajoutant `AllowUsers *`

Pour lancer une commande en ssh à distance il faut ajouter `powershell.exe` à la ligne de commande, par exemple : `ssh wilder@cliwin01 powershell.exe Get-ChildItem`

Dépendances script bash :

* ufw
* hwinfo
* htop
