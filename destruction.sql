# Selectionne la BDD courante
use mocodo_db;

# Suppression de la table Commande
drop table if exists commande;

# Suppression de la table Client
drop table if exists Client;

# Suppression de la DDB
drop database if exists mocodo_db;