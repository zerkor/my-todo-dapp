# My Todo DApp

## My Todo DApp est une application décentralisée (dApp) qui utilise un contrat intelligent Ethereum pour gérer une liste de tâches (Todo List). Cette application permet aux utilisateurs de créer, afficher et marquer des tâches comme complétées, tout en interagissant directement avec la blockchain Ethereum via MetaMask et Web3.js.

### Fonctionnalités

    Créer des tâches : Ajoutez de nouvelles tâches à la liste.
    Afficher toutes les tâches : Les tâches sont récupérées depuis la blockchain et affichées dans l'application.
    Marquer les tâches comme complétées : Cochez une tâche pour la marquer comme complétée.
    Optimisation des performances : Les tâches sont récupérées en un seul appel grâce à une optimisation du contrat intelligent.

Modifications apportées

    Optimisation des appels à la blockchain :
    Le contrat intelligent a été modifié pour inclure une fonction getAllTasks() permettant de récupérer toutes les tâches en une seule fois. Cela réduit les appels à la blockchain, améliorant ainsi la performance globale de l'application.

    Amélioration de l'interface utilisateur :
    Le front-end a été mis à jour pour utiliser la nouvelle méthode getAllTasks(), rendant l'affichage des tâches plus rapide et efficace grâce à un traitement groupé.

### Prérequis

Avant de commencer, assurez-vous d'avoir installé les outils suivants :

    Node.js (version LTS recommandée)
    NPM (installé avec Node.js)
    Truffle (framework pour dApps Ethereum)
    Ganache (bloc local pour le développement)
    MetaMask (extension de navigateur pour gérer votre compte Ethereum)
