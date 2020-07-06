# DDL ==> Data Definition Language

# create database mocodo_db; ==> Leve une exception si la BDD existe
create database if not exists mocodo_db;

# Selectionne la BDD courante
use mocodo_db;

# Creation de la table Client
create table if not exists Client
(
    idClient int unsigned,
    nom      varchar(20) not null,
    email    varchar(50) not null,
    mdp      varchar(15),
    sexe     char(1),
    constraint pk_client primary key (idClient),
    constraint uq_client_email unique (email)
);

# Alter pour modifier un Objet
alter table Client
    alter sexe set default 'F';


alter table Client
    add age int not null;

# alter table Client
#     modify ddn YEAR;

insert into client
values (1, 'Roxana', 'roxana@dawm.ge', '123456', 'F');

insert into client
values (2, 'Miri', 'miri@dawm.ge', '123456', 'F');

insert into client(idClient, nom, email)
values (3, 'Toulepi', 'toulepi@dawm.ge');

insert into client(nom, idClient, email)
values ('Souly', 4, 'souly@dawm.ge');

insert into client(nom, idClient, email)
values ('Sabrine', 5, 'sabrine@dawm.ge');

create table if not exists Commande
(
    idCommande   int unsigned auto_increment,
    idClient     int unsigned,
    numero       smallint unsigned,
    dateCommande date,
    constraint pk_commande primary key (idCommande),
    constraint fk_commande_client foreign key (idClient) references Client (idClient)
);

# =======================================================================
# BONNES PRATIQUES
# =======================================================================

create table if not exists Commande
(
    idCommande   int unsigned auto_increment,
    idClient     int unsigned,
    numero       smallint unsigned,
    dateCommande date,
    constraint pk_commande primary key (idCommande)
);

# Creation de la table Client
create table if not exists Client
(
    idClient int unsigned,
    nom      varchar(20) not null,
    email    varchar(50) not null,
    mdp      varchar(15),
    sexe     char(1),
    constraint pk_client primary key (idClient)
);

alter table Commande
    add constraint fk_commande_client foreign key (idClient)
        references Client(idClient);

alter table Client
    add constraint uq_client_email unique (email);

alter table Client
    alter sexe set default 'M';