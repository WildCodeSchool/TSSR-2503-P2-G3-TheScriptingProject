# 🖥️ GUIDE D'INSTALLATION

Sur les machines disponibles sur Proxmox, l'intégralité des dépendances et configurations présentées ci-après sont déjà faites.

Elles sont donc données à titre indicatif, ou pour vous permettre de configurer d'autres machines similairement.

La machine Debian est fonctionnelle par défaut, OpenSSH étant activé de base sur cette machine. Elle ne nécessite donc pas de configuration supplémentaire.

La machine Ubuntu nécessite l'installation de quelques dépendances ainsi que la configuration rapide de OpenSSH.

Les machines Windows nécessitent des dépendances **et** une configuration détaillée dans la section **Préparation <Client/Serveur> Windows**.

## ⚡ Prérequis techniques

### Dépendances

Les dépendances des scripts doivent être installés sur les machines **client**. 

#### Sur Linux

Les dépendances pour la bonne exécution du script sur Linux sont les suivantes :
* ufw
* hwinfo
* htop
* OpenSSH

Afin d'installer ces dépendances, vous pouvez lancer les lignes de commande suivantes :

```bash
# On met d'abord à jour la liste des paquets
sudo apt update
# Puis le système
sudo apt upgrade
# Et on installe les dépendances
sudo apt install ufw hwinfo htop
```

L'installation et la configuration de OpenSSH sur les clients Ubuntu suit la procédure suivante :

Installer openssh-server : 

```bash
sudo apt install openssh-server
```

Modifier fichier */etc/ssh/sshd_config* en y ajoutant *PermitRootLogin yes*

Activer le compte root :

```bash
sudo passwd root
sudo passwd -u root
```

#### Sur Windows

Dépendances
* Chocolatey
* NuGet
* OpenSSH

### Préparation Client Windows

#### WinRM
Exécutez la commande suivante pour démarrer le service WinRM :

```PowerShell
Set-Service -Name winrm -StartupType Automatic`
```

Pour démarrer le service immédiatement, utilise :

```PowerShell
Start-Service -Name WinRM
```

#### Configuration hôte distant

Exécutez la commande suivante pour configurer les paramètres de l'hôte distant :

```PowerShell
Set-Item WSMan:\localhost\Client\TrustedHosts -Value SRVWIN01 -Force
```

Une fois la configuration terminée, vous devriez pouvoir vous connecter au serveur Windows depuis le client Windows en utilisant PowerShell sans être invité à saisir un mot de passe.

Ouvrir une console PowerShell en administrateur.

Récupérer l'index de l'interface :

```PowerShell
$Index = (Get-NetConnectionProfile).InterfaceIndex
```

Modifier le profil en catégorie Privée :

```PowerShell
Set-NetConnectionProfile -InterfaceIndex $Index -NetworkCategory Private
```

Si le pare-feu est activé mettre l'exception WinRM :

```PowerShell
Enable-PSRemoting -Force
Set-NetFirewallRule -Name "WINRM-HTTP-In-TCP" -Enabled True
```

OU

```PowerShell
Enable-NetFirewallRule -DisplayName "Windows Remote Management (HTTP-In)"
```

Ouvrir un terminal cmd.exe en administrateur et exécuter les commandes :

Configuration du LocalAccountTokenFilterPolicy :

```
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f
```

Configuration du WinRM :

```
winrm quickconfig
```

### Préparation serveur Windows

Lorem Ipsum ...

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
# On met à jour la liste des paquets
sudo apt update
# On met à jour le système
sudo apt upgrade
```

Sur Windows, il est possible de mettre à jour le système et les dépendances à l'aide des commandes suivantes :

```PowerShell
# On récupère les données de mise à jour
Get-WindowsUpdate
# On met à jour le système
Install-WindowsUpdate 
```
