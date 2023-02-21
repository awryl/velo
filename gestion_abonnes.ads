with list; use list;
with distrib_stations; use distrib_stations;

PACKAGE gestion_abonnes is

type compteur is record
	h : integer ;
	m : integer ;
end record;
type abonnes is private;
abonne_inexistant, pb_temps, pb_montant : exception;


-- sémantique : ajoute un compte abonné correspondant au numéro dans la liste des abonnés
-- entrée : un numéro, un code postal, la liste des abonnés
-- précondition : numéro unique
-- postcondition : modification de la liste des abonnés
procedure creer_abonne (num_ab,c_p : IN integer; ab : IN OUT abonnes) ;


-- sémantique : supprime un compte abonné correspondant au numéro dans la liste des abonnés
-- entrée : un numéro, la liste des abonnés
-- postcondition : modification de la liste des abonnés
-- exception : abonne_inexistant
procedure supprimer_abonne (num_ab : IN integer; ab : IN OUT abonnes) ;


-- sémantique : affiche les informations de l'abonné correspondant au numéro dans la liste des abonnés
-- entrée : un numéro, la liste des abonnés
-- exception : abonne_inexistant
procedure infos_abonne (num_ab : IN integer; ab : IN OUT abonnes) ;


-- sémantique : augmente le crédit d'un abonné dans la liste des abonnés
-- entrée : un numéro, la liste des abonnés, un montant
-- postcondition : modification de la liste des abonnés
-- exception : abonne_inexistant, pb_montant
procedure verser_argent (num_ab : IN integer; ab : IN OUT abonnes; montant : IN float) ; 


-- sémantique : prend une caution d'un abonné 
-- entrée : un numéro, la liste des abonnés
-- postcondition : modification de la liste des abonnés
-- exception : abonne_inexistant
procedure completer_caution (num_ab : IN integer; ab : IN OUT abonnes) ;


-- sémantique : location de vélo 
-- entrée : un numéro abonné, un numéro de station, la liste des abonnés, la liste des stations
-- postcondition : modification de la liste des abonnés et de la liste des stations
-- exception : abonne_inexistant, station_inexistante, station_vide
procedure louer_velo (num_ab, num_st : IN integer; ab : IN OUT abonnes; e : ensemble) ;


-- sémantique : lors d'un vol ou perte, encaisse la caution d'un abonné
-- entrée : un numéro, la liste des abonnés
-- postcondition : modification de la liste des abonnés
-- exception : abonne_inexistant
procedure probleme (num_ab : IN integer; ab : IN OUT abonnes) ;


-- sémantique : restitution de vélo après location
-- entrée : un numéro abonné, un numéro de station, la liste des abonnés,
--		    le temps écoulé, la liste des stations
-- postcondition : modification de la liste des abonnés et de la liste des stations
-- exception : abonne_inexistant, station_inexistante, station_pleine
procedure rendre_velo (num_ab, num_st : IN integer; ab : IN OUT abonnes;
			 h_ecoulees : IN compteur; e : IN OUT ensemble) ;
			 

-- sémantique : créé une liste vide d'abonnés
function creer_liste_abonnes return abonnes;


-- sémantique : renvoie la liste des abonné dont le premier élément est l'abonné recherché
-- entrée : un numéro, la liste des abonné
-- exception : abonne_inexistant
function rechercher_abonne (num_ab : integer ; ab : abonnes) return abonnes;


-- sémantique : conversion d'un temps sous forme heure et minutes en minutes
-- entrée : temps
-- exception : pb_temps
function min_of_compteur (c : compteur) return integer ;


-- sémantique : renvoie le montant de la location 
-- entrée : le temps en minutes
-- précondition : le temps est positif
function a_payer (i : integer) return float ;


-- sémantique : renvoie la liste des numéros des vélos loués
-- entrée : la liste des abonnés
function velos_circulation (ab : abonnes) return liste ;

PRIVATE 

type el_ab;
type abonnes is access el_ab;
type el_ab is record
	num : integer ;
	code_postal : integer ;
	cr : float ;
	b : boolean ;
	num_velo : integer ;
	caut : boolean ;
	next : abonnes ;	
end record;

end gestion_abonnes;
