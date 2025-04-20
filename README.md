# 🖥️ ADMINISTRATION DE CLIENTS A DISTANCE

## 🎯 Présentation générale du projet

### Présentation

### Objectifs finaux

## 📜 Introduction

Les guides d'installation et d'utilisation sont disponibles respectivement dans les fichiers **INSTALL.md** et **USER_GUIDE.md**. 

## 👥 Membres du groupe par sprint

Pour réaliser ce projet, nous avons implémenté la méthode de gestion de projet Scrum. Le projet a duré 4 semaines, et a donc été divisé en 4 sprints différents. Les rôles de Product Owner et Scrum Master ont tourné toutes les semaines. A partir de la deuxième semaine, nous n'étions plus que deux à travailler sur ce projet. Les rôles ont donc été plus fluides, puisque la communication était plus directe et constante.

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

### Configuration Proxmox

### Configuration Machines

Les caractéristiques de chaque machine sont résumées ci-dessous.

#### Configuration de la machine serveur Debian

* Nom : **SRVLX01**
* Langue : **US**
* Compte utilisateur :
    * **root/Azerty1***
    * **wilder/Azerty1*** (dans le groupe sudo)

#### Configuration de la machine client Ubuntu

* Nom : **CLILIN01**
* Langue : **Français**
* Compte utilisateur :
    * **wilder** (dans le groupe sudo)
    * Mot de passe : **Azerty1**

#### Configuration de la machine serveur Windows

* Nom : **SRVWIN01**
* Langue : **US**
* Compte utilisateur :
    * **Administrateur/Azerty1***
    * **Wilder/Azerty1***

#### Configuration de la machine client Windows

* Nom : **CLIWIN01**
* Langue : **Français**
* Compte utilisateur :
    * **Wilder** (dans le groupe admin local)
    * Mot de passe : **Azerty1**

### Dépendances

#### Dépendances Linux

Les dépendances pour l'exécution du script bash sont les suivantes : 
* ufw
* hwinfo
* htop

Le guide d'installation **INSTALL.md** traite de la manière d'installer ces dépendances.

#### Dépendances Windows

_Aucune dépendance Windows_

## 🧗 Difficultés rencontrées

### 1. Découverte du langage PowerShell

Avant la réalisation de ce projet, aucun membre de l'équipe n'avait de connaissances sur le langage PowerShell. Il a donc fallu attendre d'avoir les cours sur le langage avant de pouvoir attaquer sérieusement la réalisation du script. 

## 💡 Solutions trouvées

### 1. Se documenter en ligne

Afin de palier aux manques que nous avions en PowerShell, nous avons beaucoup eu recours à la documentation officielle de PowerShell, ainsi qu'à des questions qu'avaient posées des utilisateurs du forum StackOverflow.

## 🚀 Améliorations possibles

Nous avons de nombreuses pistes d'améliorations possibles pour nos deux scripts d'administration.

### 1. Contrôle du bon déroulement des actions

En l'état actuel, nos scripts réalisent les actions d'administration demandées sans vérifier si elles sont possibles ni si elles ont bien été réalisées. Le script repose sur la gestion des erreurs intégrée des commandes auxquelles il fait appel.

Nous pourrions programmer nos propres vérifications et messages d'erreur afin de rendre plus claire l'utilisation du script.

### 2. Formatage des informations recueillies

En l'état actuel, nos scripts récupèrent les informations demandées en faisant appel à des fonctions récupérant les informations, sans en changer la sortie ni le format. Parfois, ces résultats sont assez lourds visuellement, ou assez peu lisibles.

Nous pourrions faire un travail de formatage des informations demandées afin de les rendre plus agréables à lire.