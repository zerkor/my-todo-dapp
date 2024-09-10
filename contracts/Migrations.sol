pragma solidity >=0.4.21 <0.6.0;

contract Migrations {
  // L'adresse du propriétaire du contrat (celui qui a déployé le contrat)
  address public owner;

  // Dernière migration effectuée, représentée par un entier
  uint public last_completed_migration;

  // Événement pour notifier lorsqu'une propriété a été transférée
  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  // Événement pour signaler la complétion d'une migration
  event MigrationCompleted(uint completed);

  // Le constructeur est exécuté lors du déploiement et définit le propriétaire initial
  constructor() public {
    owner = msg.sender; // Définit l'adresse du propriétaire comme celui qui déploie le contrat
    emit OwnershipTransferred(address(0), owner); // Émet un événement pour le transfert de propriété initial
  }

  // Modificateur qui restreint l'accès de certaines fonctions au seul propriétaire
  modifier restricted() {
    require(msg.sender == owner, "Not authorized"); // Vérifie que l'appelant est le propriétaire
    _;
  }

  // Fonction qui met à jour la dernière migration effectuée
  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed; // Met à jour la variable `last_completed_migration`
    emit MigrationCompleted(completed); // Émet un événement indiquant qu'une migration a été complétée
  }

  // Fonction pour mettre à jour l'adresse du contrat de migration si nécessaire
  function upgrade(address new_address) public restricted {
    Migrations upgraded = Migrations(new_address); // Crée une nouvelle instance du contrat à la nouvelle adresse
    upgraded.setCompleted(last_completed_migration); // Met à jour la migration dans le nouveau contrat
  }

  // Fonction pour transférer la propriété à une nouvelle adresse
  function transferOwnership(address newOwner) public restricted {
    require(newOwner != address(0), "New owner is the zero address"); // Vérifie que la nouvelle adresse n'est pas nulle
    emit OwnershipTransferred(owner, newOwner); // Émet un événement pour notifier le transfert de propriété
    owner = newOwner; // Définit la nouvelle adresse comme propriétaire
  }
}
