#My Todo DApp

My Todo DApp est une application décentralisée (dApp) qui utilise un contrat intelligent Ethereum pour gérer une liste de tâches (Todo List). Cette application permet aux utilisateurs de créer, afficher et marquer des tâches comme complétées, tout en interagissant directement avec la blockchain Ethereum via MetaMask et Web3.js.
Fonctionnalités

    Créer des tâches : Ajoutez de nouvelles tâches à la liste.
    Afficher toutes les tâches : Les tâches sont récupérées depuis la blockchain et affichées dans l'application.
    Marquer les tâches comme complétées : Cochez une tâche pour la marquer comme complétée.
    Optimisation des performances : Les tâches sont récupérées en un seul appel grâce à une optimisation du contrat intelligent.

#Modifications apportées

    Optimisation des appels à la blockchain :
    Le contrat intelligent a été modifié pour inclure une fonction getAllTasks() permettant de récupérer toutes les tâches en une seule fois. Cela réduit les appels à la blockchain, améliorant ainsi la performance globale de l'application.

    Amélioration de l'interface utilisateur :
    Le front-end a été mis à jour pour utiliser la nouvelle méthode getAllTasks(), rendant l'affichage des tâches plus rapide et efficace grâce à un traitement groupé.

Prérequis

Avant de commencer, assurez-vous d'avoir installé les outils suivants :

    Node.js (version LTS recommandée)
    NPM (installé avec Node.js)
    Truffle (framework pour dApps Ethereum)
    Ganache (bloc local pour le développement)
    MetaMask (extension de navigateur pour gérer votre compte Ethereum)

#Installation

    Clonez ce dépôt sur votre machine locale :

    bash

git clone https://github.com/zerkor/my-todo-dapp.git
cd my-todo-dapp

Installez les dépendances du projet :

bash

    npm install

Configuration
1. Installer Truffle

Si ce n’est pas déjà fait, installez Truffle globalement :

bash

npm install -g truffle

2. Installer Ganache
Option 1 : Ganache CLI

Installez Ganache CLI pour créer une blockchain locale :

bash

npm install -g ganache

Lancez Ganache dans une autre fenêtre de terminal :

bash

ganache

Option 2 : Ganache UI

#Téléchargez et installez Ganache UI. Lancez-le et créez une blockchain locale.
3. Configurer Truffle

Assurez-vous que votre fichier truffle-config.js est bien configuré pour pointer vers Ganache. Voici un exemple de configuration pour Ganache :

javascript

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545, // Port par défaut de Ganache
      network_id: "*", // Match any network id
    },
  },
  compilers: {
    solc: {
      version: "0.5.0", // Spécifiez la version de Solidity
    },
  },
};

#Déploiement du Contrat

    Compilez le contrat intelligent :

    bash

truffle compile

Déployez le contrat sur votre blockchain locale (Ganache) :

bash

truffle migrate --reset

(Optionnel) Si vous souhaitez exécuter les tests, utilisez la commande suivante :

bash

    truffle test

Lancer l'application

    Démarrez l'application en exécutant :

    bash

    npm run dev

    Ouvrez votre navigateur et connectez-vous à MetaMask.

    Accédez à l'adresse suivante : http://localhost:3000

Structure du Projet

    contracts/TodoList.sol : Le contrat intelligent Solidity qui gère les tâches.
    src/app.js : La logique front-end de l'application, qui permet d'interagir avec la blockchain via Web3.js.
    src/index.html : Le fichier HTML principal de l'application
