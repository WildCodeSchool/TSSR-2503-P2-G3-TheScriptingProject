# TSSR-2503-P2-G3-TheScriptingProject

## Install

Installer openssh-server : `sudo apt install openssh-server`

Modifier fichier */etc/ssh/sshd_config* en y ajoutant *PermitRootLogin yes*

Activer le compte root `sudo passwd root` puis `sudo passwd -u root`

Dépendances script bash :

* ufw
* hwinfo
* htop
