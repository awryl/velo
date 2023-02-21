with list; use list;


PACKAGE stations is

type station is private;
station_vide, station_pleine, erreur_valeur : exception ;


-- sémantique : ajoute un vélo en tête de la liste de vélos de la station
-- entrée : la station, le numéro du vélo
-- postcondition : modification de la station
-- exception : station_pleine
procedure ajouter_velo (l : IN OUT station; n : IN integer) ;


-- sémantique : supprime le vélo en tête de la liste de vélos de la station
-- entrée : la station
-- postcondition : modification de la station
-- exception : station_vide
procedure supprimer_velo (l : IN OUT station) ;


-- sémantique : retourne le numéro du premier vélo de la liste de vélos de la station
-- entrée : la station
-- exception : station_vide
function premier_velo (l : station) return integer ;


-- sémantique : Créé une station vide
-- entrée : un numéro, des coordonnées, un nombre de places maximal
-- précondition : numéro unique, coordonnées uniques
-- exception : erreur_valeur
function creer_station (i : integer; x,y : float; m : integer) return station ;  


-- sémantique : Vrai SSI la station est vide
-- entrée : la station
function est_vide (l : station) return boolean ;


-- sémantique : retourne le numéro
-- entrée : la station
function numero (l : station) return integer ;


-- sémantique : retourne le nombre maximal de places
-- entrée : la station
function max (l : station) return integer ;


-- sémantique : retourne la liste de vélos de la station
-- entrée : la station
function ensemble_velos (l : station) return liste;


-- sémantique : retourne le nombre de vélos disponibles
-- entrée : la station
function velos_dispo (l : station) return integer;


-- sémantique : retourne le nombre de places disponibles
-- entrée : la station
function places_dispo (l : station) return integer;


-- sémantique : retourne les coordonnées x et y 
-- entrée : la station
function coordx (l : station) return float ;
function coordy (l : station) return float ;

PRIVATE

type el_s;
type station is access el_s;
type el_s is record 
	velo : liste ; -- Ensemble de vélos
	num : integer ; -- Numéro de la station
	x : float ; -- Coordonnées
	y : float ; 
	m : integer ; -- MAX
end record;


end stations;
