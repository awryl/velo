with stations; use stations;
with list; use list;

PACKAGE distrib_stations is

type ensemble is private;
station_inexistante : exception;

-- sémantique : affiche les stations dans un rayon de 1 km d'une station qui possède des
--				vélos disponibles et leur nombre
-- entrée : un numéro, l'ensemble des stations
-- exception : station_inexistante
procedure afficher_velos_dispo (num_st : IN integer; e : IN ensemble);


-- sémantique : affiche les stations dans un rayon de 1 km d'une station qui possède des
--				places disponibles et leur nombre
-- entrée : un numéro, l'ensemble des stations
-- exception : station_inexistante
procedure afficher_places_dispo (num_st : IN integer; e : IN ensemble);


-- sémantique : supprime la station d'un certain numéro dans la liste de stations
-- entrée : un numéro, l'ensemble des stations
-- postcondition : modifie la liste des stations
-- exception : station_inexistante
procedure supprimer_station (num_st : IN integer; e : IN OUT ensemble);


-- sémantique : met en tête de liste la stations dans la liste de stations
-- entrée : la station, la liste des stations
-- postcondition : modifie la liste des stations
procedure introduire_station (s : IN station; e : IN OUT ensemble);


-- sémantique : créé une liste vide de station
function creer_liste_stations return ensemble;


-- sémantique : renvoie la station correspondant au numéro dans la liste des stations
-- entrée : un numéro, la liste des stations
-- exception : station_inexistante
function rechercher_station (num_st : integer; e : ensemble) return station;


-- sémantique : renvoie la liste des stations qui sont à moins de 1km d'une station
-- entrée : un numéro, la liste des stations
-- exception : station_inexistante
function distance (num_st : integer; e : ensemble) return ensemble;


-- sémantique : renvoie la liste des numéros des stations à moins de R mètres d'une station
-- entrée : un numéro, la liste des stations, une longueur
-- exception : station_inexistante
function distrib_distance (num_st : integer; e : ensemble; R : float) return liste;

PRIVATE

type el_e;
type ensemble is access el_e;
type el_e is record
	s : station ;
	next : ensemble ;
end record ;

end distrib_stations;
