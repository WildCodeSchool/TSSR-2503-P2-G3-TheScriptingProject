# 🖥️ ADMINISTRATION DE CLIENTS A DISTANCE

## 🎯 Présentation générale du projet

### Présentation

Ce projet est le deuxième projet réalisé au sein de la Wild Code School, dans le cadre d'un bootcamp Technicien Systèmes et Réseaux.

Ce projet a pour objectif de travailler sur la configuration de machines en réseau, et sur l'implémentation de scripts.

### Objectifs finaux

Ce projet est divisé en deux objectifs, un objectif principal et un objectif secondaire.

L'objectif principal est de réaliser deux scripts. Le premier doit être en mesure d'administrer des machines client Ubuntu depuis une machine serveur Debian. Le second doit être en mesure d'administrer des machines client Windows depuis une machine serveur Windows Server.

L'objectif secondaire est lui aussi de réaliser deux scripts. Cette fois, il faut pouvoir administrer des clients Windows depuis une machine serveur Debian, et des machines client Ubuntu depuis une machine serveur Windows Server.

Les machines en question, client comme serveur, doivent également être configurées et mises en réseau par nos soins sur Proxmox.

## 📜 Introduction

Ce projet a été réalisé par Sheldon THURM, Brendan BORNE et Mamadou DRAME.

Il a pour but de mobiliser les compétences suivantes :
* Configuration de machines serveur et client en réseau
* Installation et configuration d'OpenSSH
* Prise en main de Proxmox
* Implémentation de script
* Réalisation de projet en équipe
* Documentation de projet
* Démonstration de la réalisation finale

Les guides d'installation et d'utilisation sont disponibles respectivement dans les fichiers **INSTALL.md** et **USER_GUIDE.md**. 

## 👥 Membres du groupe par sprint

Pour réaliser ce projet, nous avons implémenté la méthode de gestion de projet Scrum. Le projet a duré 4 semaines, et a donc été divisé en 4 sprints différents. Les rôles de Product Owner et Scrum Master ont tourné toutes les semaines.

A partir de la deuxième semaine, nous n'étions plus que deux à travailler sur ce projet, Mamadou ayant quitté l'équipe. Les rôles ont donc été plus fluides, puisque la communication était plus directe et constante.

Les tableaux suivants résument la répartition des rôles par sprint, ainsi que la répartition des tâches à effectuer.

### Sprint 1

| Membre         | Rôle          | Missions                                                                   |
| -------------- | ------------- | -------------------------------------------------------------------------- |
| Brendan BORNE  | Scrum Master  | Prise en main du sujet, fonctions bash                                     |
| Mamadou DRAME  | Technicien    | Prise en main du sujet, fonctions bash                                     |
| Sheldon THURM  | Product Owner | Prise en main du sujet, fonctions bash                                     |

### Sprint 2

| Membre         | Rôle          | Missions                                                                   |
| -------------- | ------------- | -------------------------------------------------------------------------- |
| Brendan BORNE  | Product Owner | Fonctions bash, gestion des logs bash, squelette principal bash            |
| Sheldon THURM  | Scrum Master  | Fonctions bash, fonctions PowerShell                                       |

### Sprint 3

| Membre         | Rôle          | Missions                                                                   |
| -------------- | ------------- | -------------------------------------------------------------------------- |
| Brendan BORNE  | Scrum Master  |  Test et débugage bash, déploiement bash, configuration machines proxmox   |
| Sheldon THURM  | Product Owner |  Fonctions PowerShell, gestion des logs PowerShell                         |

### Sprint 4

| Membre         | Rôle          | Missions                                                                   |
| -------------- | ------------- | -------------------------------------------------------------------------- |
| Brendan BORNE  | Product Owner | Gestion des logs PowerShell, test et débugage PowerShell, déploiement PowerShell, documentation |
| Sheldon THURM  | Scrum Master  | Fonctions PowerShell, test et débugage PowerShell, déploiement PowerShell, documentation |

## ⚙️ Choix techniques

### Configuration Réseau

L'adresse du réseau configuré est **172.16.30.0**. Le masque de sous-réseau est **255.255.255.0**. 

L'adresse de passerelle par défaut est **172.16.30.254**. Le DNS est **8.8.8.8**

Les adresses de chaque machine sont spécifiées dans la partie _Configuration Machines_.

La configuration d'OpenSSH pour toutes nos machines est détaillée dans le fichier **INSTALL.md**

### Configuration Proxmox

Nous travaillons sur le noeud **wcs-cyber-node06**. Nos machines sont les machines **641** à **644**.

### Configuration Machines

Les caractéristiques de chaque machine sont résumées ci-dessous.

#### Configuration de la machine serveur Debian

* Nom : **SRVLX01**
* Langue : **US**
* Adresse IP : **172.16.30.10**
* ID Proxmox : **644**
* Compte utilisateur :
    * **root/Azerty1***
    * **wilder/Azerty1*** (dans le groupe sudo)

#### Configuration de la machine client Ubuntu

* Nom : **CLILIN01**
* Langue : **Français**
* Adresse IP : **172.16.30.30**
* ID Proxmox : **642**
* Compte utilisateur :
    * **wilder** (dans le groupe sudo)
    * Mot de passe : **Azerty1***

#### Configuration de la machine serveur Windows

* Nom : **SRVWIN01**
* Langue : **US**
* Adresse IP : **172.16.30.5**
* ID Proxmox : **643**
* Compte utilisateur :
    * **Administrateur/Azerty1***
    * **Wilder/Azerty1***

#### Configuration de la machine client Windows

* Nom : **CLIWIN01**
* Langue : **Français**
* Adresse IP : **172.16.30.20**
* ID Proxmox : **641**
* Compte utilisateur :
    * **Wilder** (dans le groupe admin local)
    * Mot de passe : **Azerty1***

## 🧗 Difficultés rencontrées

### 1. Découverte du langage PowerShell

Avant la réalisation de ce projet, aucun membre de l'équipe n'avait de connaissances sur le langage PowerShell. Il a donc fallu attendre d'avoir les cours sur le langage avant de pouvoir attaquer sérieusement la réalisation du script. 

### 2. Configuration des machines Windows

Nous pensions dans un premier temps que les machines Windows pourraient utiliser OpenSSH similairement aux machines Linux. Malheureusement, certains cmdlets PowerShell ne fonctionnent pas comme on l'espère avec ssh. La configuration des machines Windows a donc nécessité plus de travail que nous le pensions dans un premier temps.

## 💡 Solutions trouvées

### 1. Se documenter en ligne

Afin de palier aux manques que nous avions en PowerShell, nous avons beaucoup eu recours à la documentation officielle de PowerShell, ainsi qu'à des questions qu'avaient posées des utilisateurs du forum StackOverflow.

### 2. Aide du formateur

Pour répondre à ce besoin de configurer les machines Windows, notre formateur nous a donné une documentation permettant d'installer et configurer de nombreux services Windows permettant d'utiliser plus efficacement les commandes à distance sur les machines Windows.

## 🚀 Améliorations possibles

Nous avons de nombreuses pistes d'améliorations possibles pour nos deux scripts d'administration.

### 1. Fonctionnalités script PowerShell

Faute de temps, l'intégralité des fonctionnalités attendues n'a pas été implémenté en PowerShell. Il manque actuellement 4  fonctions qui ne passent pas les tests de débugage. 

Nous pourrions les implémenter afin de boucler les attendus pour ce script.

### 2. Contrôle du bon déroulement des actions

En l'état actuel, nos scripts réalisent les actions d'administration demandées sans vérifier si elles sont possibles ni si elles ont bien été réalisées. Le script repose sur la gestion des erreurs intégrée des commandes auxquelles il fait appel.

Nous pourrions programmer nos propres vérifications et messages d'erreur afin de rendre plus claire l'utilisation du script.

### 3. Formatage des informations recueillies

En l'état actuel, nos scripts récupèrent les informations demandées en faisant appel à des fonctions récupérant les informations, sans en changer la sortie ni le format. Parfois, ces résultats sont assez lourds visuellement, ou assez peu lisibles.

Nous pourrions faire un travail de formatage des informations demandées afin de les rendre plus agréables à lire.
