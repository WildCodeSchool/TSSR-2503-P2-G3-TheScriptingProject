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

#### Sur le Client Windows

##### WinRM

Démarrer le service WinRM :
```PowerShell
Start-Service -Name WinRM
```

Executer les paramètres de l'hôte distant pour permettre la connexion a distance : 
```PowerShell
Set-Item WSMan:\localhost\Client\TrustedHosts -Value SRVWIN01 -Force
```

Une fois la configuration terminée, vous devriez pouvoir vous connecter au serveur Windows depuis le client Windows en utilisant PowerShell sans être invité à saisir un mot de passe.
Maintenant nous allons récupérer l'index de l'interface
```PowerShell
$Index = (Get-NetConnectionProfile).InterfaceIndex
```

Puis modifier le profil en catégorie Privée
```PowerShell
Set-NetConnectionProfile -InterfaceIndex $Index -NetworkCategory Private
```

Configuration du LocalAccountTokenFilterPolicy
```PowerShell
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f
```

Pour la configuration du WinRM
```PowerShell
winrm quickconfig
```

##### Registre distant 

Configuration sur les Clients du démarrage automatique du service Registre Distant via la commande PowerShell :

Définir le démarrage automatique du service "Registre Distant"
```PowerShell
Set-Service -Name RemoteRegistry -StartupType Automatic
```

Démarrer le service "Registre Distant"
```PowerShell
Start-Service -Name RemoteRegistry
```

##### Firewall 

Pour la bonne execution du script, nous devons désactiver le pare-feu :
```PowerShell
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
```

##### Compte administrateur

Création d'un nouveau compte utilisateur
```PowerShell
New-LocalUser -Name "Administrator" -Description "Compte local identique au compte du domaine" -Password (ConvertTo-SecureString "Azerty1*" -AsPlainText -Force) -FullName "Administrator" -PasswordNeverExpires -UserMayNotChangePassword
```
Ajout du compte au groupe des administrateurs locaux
```PowerShell
Add-LocalGroupMember -Group "Administrateurs" -Member "Administrator"
```

##### Modules additionnels

Il faut dans un premier temps installer sur chaque Client PSWindowsUpdate via la
commande :
```PowerShell
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module -Name PSWindowsUpdate -RequiredVersion 2.2.0.3 -Force -Confirm:$false
```
Puis vous devez retirer la restriction des scripts via la commande :
```PowerShell
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine -Force
```

##### OpenSSH

Ouvrez PowerShell en tant qu'administrateur et exécutez :
```PowerShell
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
```

Démarrez le service SSH :
```PowerShell
Start-Service -Name sshd
```

##### Chocolatey

Installer le logiciel Chocolatey :
```PowerShell
Set-ExecutionPolicy AllSigned -Scope Process -Force; iwr https://community.chocolatey.org/install.ps1 -UseBasicParsing | iex
```

#### Préparation serveur Windows

##### WinRM

Démarrer le service WinRM :
```PowerShell
Start-Service -Name WinRM
```

Configurer WinRM pour permettre l'accès a distance :
```PowerShell
Enable-PSRemoting -Force
```

##### Hôtes de confiance 

Ajouter le PC client à la liste des hôte de confiance avec la commande :

```PowerShell
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "172.16.30.20" -Force
```

##### PowerShell

Pour avoir la dernière version de PowerShell

```PowerShell
iex "& { $(irm https://aka.ms/install-powershell.ps1) } -UseMSI"
```

###### OpenSSH

Pour installer et aciver OpenSSH

```PowerShell
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
```

## 👨‍💻 Installation des scripts

Les scripts sont déjà présents sur les machines Proxmox.

Pour plus de détails sur leur exécution, vous pouvez lire **USER_GUIDE.md**.

## ❓ FAQ

### Faut-il avoir des droits d'administrateur pour utiliser ces scripts ?

Oui, ces scripts sont des scripts permettant d'administrer des machines et les comptes utilisateurs qui y sont présents. Ainsi, il est nécessaire de disposer des droits d'administrateur pour les exécuter.

### Puis-je exécuter un script sans l’installer ?

Oui, les scripts sont des petits programmes lancés directement depuis un terminal. Plus d'informations sont présentes dans le document **USER_GUIDE.md**.

### Dois-je avoir un bon niveau en informatique pour lancer le script ?

Non, il suffit d'executer le script dans une console et celui-ci vous guidera à travers ses ramifications.

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
