-- Ces requetes fonctionnent pour mysql et postgreSQL (Testées)
-- 1. Liste des albums
SELECT * FROM G05_Album;

-- 2. Liste des albums dont le titre contient « tre » ou « ho »
SELECT album_titre 
FROM G05_Album 
WHERE album_titre LIKE '%tre%' OR album_titre LIKE '%ho%';

-- 3. Liste des albums parus entre 1976 et 1983
SELECT album_titre,dateSortie 
FROM G05_Album 
WHERE dateSortie BETWEEN '1976%' AND '1983%';

-- 4. Nombre d’albums par série
SELECT serie_id,COUNT(*) AS nbr_albums 
FROM G05_Album 
GROUP BY serie_id;

-- 5. Liste des scénaristes des albums parus entre 1986 et 1998
SELECT DISTINCT auteur_nom,auteur_prenom 
FROM G05_Auteur NATURAL JOIN G05_contribuer 
WHERE auteur_fonction = 'Scénariste' AND album_id = ANY (SELECT album_id FROM G05_Album WHERE dateSortie BETWEEN '1986%' AND '1998%');

-- 6. Dessinateur de l’album portant le titre « Les archers »
SELECT auteur_nom,auteur_prenom,auteur_fonction 
FROM G05_Auteur NATURAL JOIN G05_contribuer WHERE auteur_fonction ='Dessinateur' AND album_id = (SELECT album_id FROM G05_Album WHERE album_titre= 'Les archers');

-- 7. Titres des albums scénarisés par Yann
SELECT album_titre 
FROM G05_Album 
WHERE album_id = ANY(SELECT album_id FROM G05_contribuer WHERE auteur_id = (SELECT auteur_id FROM G05_Auteur WHERE auteur_nom ='Yann'));

-- 8. Liste des auteurs ayant participé à un album dont le titre contient la lettre « k »
SELECT auteur_nom,auteur_prenom 
FROM G05_Auteur WHERE auteur_id= ANY(SELECT auteur_id FROM G05_contribuer WHERE album_id =ANY (SELECT album_id FROM G05_Album WHERE album_titre LIKE '%k%'));
 
-- 9. Nombre d’albums par auteur
SELECT auteur_nom,auteur_prenom,COUNT(*) AS nbr_album 
FROM G05_contribuer NATURAL JOIN G05_Auteur 
GROUP BY auteur_nom,auteur_prenom;

-- 10. Auteurs ayant participé à plus de 15 albums
SELECT auteur_nom,auteur_prenom,COUNT(*) AS nbr_album 
FROM G05_contribuer NATURAL JOIN G05_Auteur 
GROUP BY auteur_nom,auteur_prenom,auteur_id 
HAVING COUNT(*)>15;

