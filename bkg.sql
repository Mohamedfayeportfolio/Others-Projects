-- Nombre total de commandes par client
SELECT c.client_id, c.nom, c.prenom, COUNT(co.commande_id) AS total_commandes
FROM `speed bkg`.`clients(in)` c
JOIN `speed bkg`.`commandes(in)` co ON c.client_id = co.client_id
GROUP BY c.client_id, c.nom, c.prenom
ORDER BY total_commandes DESC;

-- Chiffre d'affaires total par produit
SELECT p.produit_id, p.nom_produit, SUM(p.prix * co.quantite) AS chiffre_affaires
FROM `speed bkg`.`produits(in)` p
JOIN `speed bkg`.`commandes(in)` co ON p.produit_id = co.produit_id
GROUP BY p.produit_id, p.nom_produit
ORDER BY chiffre_affaires DESC;

-- Pourcentage de livraisons réussies
SELECT
    COUNT(CASE WHEN l.statut = 'Livré' THEN 1 END) * 100.0 / COUNT(*) AS taux_reussite
FROM `speed bkg`.`livraisons(in)` l;

-- Produits les plus commandés
SELECT p.nom_produit, SUM(co.quantite) AS total_quantite
FROM `speed bkg`.`produits(in)` p
JOIN `speed bkg`.`commandes(in)` co ON p.produit_id = co.produit_id
GROUP BY p.nom_produit
ORDER BY total_quantite DESC;

-- Clients ayant passé le plus de commandes
SELECT c.client_id, c.nom, c.prenom, COUNT(co.commande_id) AS total_commandes
FROM `speed bkg`.`clients(in)` c
JOIN `speed bkg`.`commandes(in)` co ON c.client_id = co.client_id
GROUP BY c.client_id, c.nom, c.prenom
ORDER BY total_commandes DESC
LIMIT 10;


-- Sélectionner la base de données
USE `speed bkg`;

-- Créer la vue
CREATE VIEW chiffre_affaires_mensuel AS
SELECT
    DATE_FORMAT(co.date_commande, '%Y-%m') AS mois,
    SUM(p.prix * co.quantite) AS chiffre_affaires
FROM `commandes(in)` co
JOIN `produits(in)` p ON co.produit_id = p.produit_id
GROUP BY mois;

-- Vérifier la vue
SELECT * FROM chiffre_affaires_mensuel;






