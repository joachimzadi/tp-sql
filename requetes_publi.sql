/*************************************************************************
Exercice 1 :
				Afficher le nom, la ville et la région de tous les éditeurs
**************************************************************************/
SELECT NomEditeur NOM,
       Ville,
       Region
FROM editeur;

-- (8 ligne(s) affectée(s))

/******************************************************************************
Exercice 2 :	LIKE, BETWEEN, AND
				Afficher le nom, le prénom, et la date d’embauche des employés
				embauchés en 1990, dont le nom commence par ‘L’, et la position
				est comprise entre 10 et 100 ( LIKE sur le champ date).
******************************************************************************/

-- VERSION 1
SELECT PnEmploye       Prenom,
       NomEmploye      Nom,
       DateEmbauche AS 'Date Embauche'
FROM employe
WHERE YEAR(DateEmbauche) = 1990
  AND NomEmploye LIKE 'L%'
  AND PositionEmploye BETWEEN 10 AND 100;


-- VERSION 2
SELECT PnEmploye    Prenom,
       NomEmploye   Nom,
       DateEmbauche 'Date Embauche'
FROM employe
WHERE DateEmbauche BETWEEN '1990-01-01' AND '1990-12-31'
  AND NomEmploye LIKE 'L%'
  AND PositionEmploye BETWEEN 10 AND 100;

-- (1 ligne(s) affectée(s))

/*******************************************************************************
Exercice 3 :	ORDER BY
				Afficher le nom et la date d’embauche des employés, classés
				par leur identificateur d’éditeur, puis par leur nom de famille
				(sous-critère)
********************************************************************************/
SELECT NomEmploye,
       DATE(DateEmbauche) 'Date Embauche'
FROM employe
ORDER BY IdEditeur DESC;

--  (43 ligne(s) affectée(s))

/*****************************************************************************
Exercice 4 :	IN, ORDER BY
				Afficher le nom, le pays et l’adresse des auteurs Français,
				Suisse ou Belge, classés par pays.
*****************************************************************************/
SELECT NomAuteur,
       Adresse,
       Pays
FROM auteur
WHERE Pays IN ('FR', 'BE', 'CH');

--  (20 ligne(s) affectée(s))

/*************************************************************************************
Exercice 5 :	GROUP BY, COUNT, MIN, MAX
				Pour chaque niveau d’emploi (table employés, colonne position_employé)
				afficher le nombre d’employés de ce niveau, la date d’embauche du
				salarié le plus ancien et du plus récent dans le niveau
*************************************************************************************/
SELECT PositionEmploye,
       COUNT(PositionEmploye)  AS 'NbEmploye',
       MIN(DATE(DateEmbauche)) AS 'Ancien',
       MAX(DATE(DateEmbauche)) AS 'Recent'
FROM employe
GROUP BY PositionEmploye
ORDER BY Ancien;

-- (14 ligne(s) affectée(s))

/******************************************************************************
Exercice 6 :	GROUP BY, MAX
				Pour chaque Identificateur de titre, calculer les droits prévus
				maximum (table droits_prévus,--colonne droits)
*******************************************************************************/
SELECT IdTitre, SUM(Droit) Droit
FROM droitprevu
GROUP BY IdTitre;

--  (12 ligne(s) affectée(s))


/******************************************************************************
Exercice 7 :	GROUP BY, clause sur un sous-ensemble HAVING
				Afficher le nombre des éditeurs regroupés par pays, en se
				limitant aux pays dont le nom contient un 'S' ou un 'R'
******************************************************************************/
SELECT Pays, COUNT(IdEditeur) 'Nombre Editeur'
FROM editeur
GROUP BY Pays
HAVING Pays LIKE '%S%'
    OR pays LIKE '%R%';

-- (3 ligne(s) affectée(s))

/*****************************************************************************
Exercice 9 :	Jointure entre trois tables
				Afficher les noms des auteurs parisiens, les titres et les
				prix de leurs livres
*****************************************************************************/
-- VERSION 1
SELECT NomAuteur, Titre, Prix
FROM auteur,
     titreauteur,
     titre
WHERE auteur.IdAuteur = titreauteur.IdAuteur
  AND titreauteur.IdTitre = titre.IdTitre
  AND auteur.Ville = 'Paris';

-- VERSION 2
SELECT NomAuteur, Titre, Prix
FROM auteur a,
     titreauteur ta,
     titre t
WHERE a.IdAuteur = ta.IdAuteur
  AND ta.IdTitre = t.IdTitre
  AND a.Ville = 'Paris';

-- VERSION 3
SELECT NomAuteur,
       titre,
       prix
FROM auteur a
         JOIN
     titreauteur ta ON a.IdAuteur = ta.IdAuteur
         JOIN
     titre t ON ta.IdTitre = t.IdTitre
         AND a.Ville = 'Paris';

-- (4 ligne(s) affectée(s))

/**********************************************************************************
Exercice 10 :	Jointure sur quatre tables, ORDER BY
				Pour chaque éditeur, afficher le nom de l’éditeur, les titres
				des livres qu’il publie, les noms des magasins où ils sont vendus,
				le nombre d’exemplaires vendus dans chaque magasin, et le nombre
				d’exemplaires vendus au total par chaque éditeur, faire le
				classement sur le titre
**********************************************************************************/
SELECT e.NomEditeur Nom, t.Titre Titre, m.NomMag Magasin, qt Quantite
FROM editeur e
         JOIN
     titre t ON e.IdEditeur = t.IdEditeur
         JOIN
     vente v ON t.IdTitre = v.IdTitre
         JOIN
     magasin m ON v.IdMag = m.IdMag
ORDER BY titre;

--  (18 ligne(s) affectée(s))

/****************************************************************************
Exercice 11 :	jointure sur 4 tables, GROUP BY, HAVING, SUM
				Afficher les noms des auteurs qui ont vendu au moins 20 livres,
				et le nombre de livres qu’ils ont vendus (tables auteurs,
				titreauteur, titres, ventes)
*****************************************************************************/
SELECT a.NomAuteur Nom, SUM(v.QT) 'Qte Vendue'
FROM auteur a
         JOIN
     titreauteur ta ON a.IdAuteur = ta.IdAuteur
         JOIN
     titre t ON ta.IdTitre = t.IdTitre
         JOIN
     vente v ON t.IdTitre = v.IdTitre
GROUP BY a.NomAuteur
HAVING SUM(v.QT) >= 20
ORDER BY a.NomAuteur;
# ORDER BY Nom;

--  (10 ligne(s) affectée(s))

/*************************************************************************************
Exercice 12 :	2 sous-requêtes, IN, ALL - FACULTATIF
				Afficher les noms et prénoms par ordre alphabétique des
				auteurs qui possèdent 100% de droits sur tous leurs livres !
				(titreauteur.droits_pourcent = 100 pour tous les livres)
				Attention : la deuxième sous requête ALL est une requête corrélative
*************************************************************************************/
SELECT a.NomAuteur Nom, a.PnAuteur Prenom
FROM auteur a
WHERE a.IdAuteur IN (SELECT IdAuteur
                     FROM titreauteur)
  AND 100 = ALL (SELECT ta.DroitPourCent
                 FROM titreauteur ta
                 WHERE a.IdAuteur = ta.IdAuteur)
ORDER BY a.NomAuteur, a.PnAuteur;

--  (5 ligne(s) affectée(s))

/****************************************************************
Exercice 13 :	1 sous-requête, MAX
				Afficher le titre du livre le plus cher
				(maximum de titre.prix)
*****************************************************************/
SELECT t.Titre 'Livre Le Plus Cher',
       t.Prix  Prix
FROM titre t
WHERE prix = (SELECT MAX(tt.Prix)
              FROM titre tt);

--  (1 ligne(s) affectée(s))

/*****************************************************************************
Exercice 14 :	1 sous-requête utilisée dans la clause SELECT, SUM
				Afficher la liste des titres et le cumul des quantités de leurs
				ventes, tous magasins confondus (tables titres et ventes)
*****************************************************************************/
SELECT t.Titre              AS Titre,
       (SELECT SUM(qt)
        FROM vente v
        WHERE v.IdTitre = t.IdTitre
        GROUP BY v.IdTitre) AS CumulVente
FROM titre t
ORDER BY CumulVente;

--  (15 ligne(s) affectée(s))
/*************************************************************************************
Exercice 15 :	1 sous-requête, MAX
				Afficher le titre du livre le plus vendu de tous les magasins, et le
				nom du magasin
**************************************************************************************/
SELECT titre                AS Titre,
       NomMag               AS Magasin,
       (SELECT MAX(qt)
        FROM vente v
        WHERE v.IdTitre = t.IdTitre
          AND v.IdMag = m.IdMag
        GROUP BY v.IdTitre) AS CumulVente
FROM titre t,
     magasin m
ORDER BY CumulVente DESC
LIMIT 1;

--  (1 ligne(s) affectée(s))

/**************************************************************************************************
Exercice 15 bis :
					Afficher le nom et l’identificateur des éditeurs qui éditent de la gestion et
					pas d’informatique
***************************************************************************************************/
SELECT NomEditeur, IdEditeur
FROM editeur e
WHERE IdEditeur IN (SELECT IdEditeur
                    FROM titre t
                    WHERE t.type = 'gestion')
  AND IdEditeur NOT IN (SELECT IdEditeur
                        FROM titre t
                        WHERE t.type = 'informatique');

--  (1 ligne(s) affectée(s))