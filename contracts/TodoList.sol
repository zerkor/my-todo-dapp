pragma solidity ^0.5.0;

contract TodoList {
    uint public taskCount = 0;

    // Définition de la structure d'une tâche
    struct Task {
        uint id;
        string content;
        bool completed;
    }

    // Mapping pour stocker les tâches (chaque tâche a un id unique)
    mapping(uint => Task) public tasks;

    // Événements qui seront déclenchés lors de la création et de la mise à jour d'une tâche
    event TaskCreated(uint id, string content, bool completed);
    event TaskCompleted(uint id, bool completed);

    // Constructeur appelé lors du déploiement du contrat pour créer une tâche initiale
    constructor() public {
        createTask("Première tâche par défaut");
    }

    // Fonction pour créer une nouvelle tâche
    function createTask(string memory _content) public {
        taskCount++;  // Incrémenter le nombre de tâches
        tasks[taskCount] = Task(taskCount, _content, false);  // Ajouter la tâche au mapping
        emit TaskCreated(taskCount, _content, false);  // Émettre un événement indiquant la création d'une tâche
    }

    // Fonction pour basculer le statut d'une tâche (complétée/non complétée)
    function toggleCompleted(uint _id) public {
        Task memory task = tasks[_id];
        task.completed = !task.completed;
        tasks[_id] = task;  // Mettre à jour la tâche dans le mapping
        emit TaskCompleted(_id, task.completed);  // Émettre un événement indiquant le changement de statut
    }

    // Nouvelle fonction : permet de récupérer toutes les tâches en une seule fois.
    // Cette fonction retourne trois tableaux : ids, contenus et statuts des tâches
    function getAllTasks() public view returns (uint[] memory, string[] memory, bool[] memory) {
        uint[] memory ids = new uint[](taskCount);  // Tableau pour stocker les ids des tâches
        string[] memory contents = new string[](taskCount);  // Tableau pour stocker les contenus des tâches
        bool[] memory completed = new bool[](taskCount);  // Tableau pour stocker le statut complété/non complété

        // Boucle sur chaque tâche existante et remplir les tableaux avec les données
        for (uint i = 1; i <= taskCount; i++) {
            Task storage task = tasks[i];  // Récupérer la tâche dans le mapping
            ids[i - 1] = task.id;  // Ajouter l'id au tableau
            contents[i - 1] = task.content;  // Ajouter le contenu au tableau
            completed[i - 1] = task.completed;  // Ajouter le statut complété au tableau
        }

        // Retourner les trois tableaux
        return (ids, contents, completed);
    }
}
