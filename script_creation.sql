# DDL ==> Data Definition Language

# create database mocodo_db; ==> Leve une exception si la BDD existe
create database if not exists mocodo_db;

# Selectionne la BDD courante
use mocodo_db;

# Creation de la table Client
create table if not exists Client
(
    idClient int unsigned auto_increment,
    nom      varchar(20) not null,
    email    varchar(50) not null,
    mdp      varchar(15),
    sexe     char(1),
    constraint pk_client primary key (idClient),
    constraint uq_client_email unique (email)
);

create table if not exists Commande
(
    idCommande   int unsigned auto_increment,
    idClient     int unsigned,
    numero       smallint unsigned,
    dateCommande date,
    constraint pk_commande primary key (idCommande),
    constraint fk_commande_client foreign key (idClient) references Client (idClient)
);