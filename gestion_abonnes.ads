with list; use list;
with distrib_stations; use distrib_stations;

PACKAGE gestion_abonnes is

type compteur is record
	h : integer ;
	m : integer ;
end record;
type abonnes is private;
abonne_inexistant, pb_temps, pb_montant : exception;


-- s�mantique : ajoute un compte abonn� correspondant au num�ro dans la liste des abonn�s
-- entr�e : un num�ro, un code postal, la liste des abonn�s
-- pr�condition : num�ro unique
-- postcondition : modification de la liste des abonn�s
procedure creer_abonne (num_ab,c_p : IN integer; ab : IN OUT abonnes) ;


-- s�mantique : supprime un compte abonn� correspondant au num�ro dans la liste des abonn�s
-- entr�e : un num�ro, la liste des abonn�s
-- postcondition : modification de la liste des abonn�s
-- exception : abonne_inexistant
procedure supprimer_abonne (num_ab : IN integer; ab : IN OUT abonnes) ;


-- s�mantique : affiche les informations de l'abonn� correspondant au num�ro dans la liste des abonn�s
-- entr�e : un num�ro, la liste des abonn�s
-- exception : abonne_inexistant
procedure infos_abonne (num_ab : IN integer; ab : IN OUT abonnes) ;


-- s�mantique : augmente le cr�dit d'un abonn� dans la liste des abonn�s
-- entr�e : un num�ro, la liste des abonn�s, un montant
-- postcondition : modification de la liste des abonn�s
-- exception : abonne_inexistant, pb_montant
procedure verser_argent (num_ab : IN integer; ab : IN OUT abonnes; montant : IN float) ; 


-- s�mantique : prend une caution d'un abonn� 
-- entr�e : un num�ro, la liste des abonn�s
-- postcondition : modification de la liste des abonn�s
-- exception : abonne_inexistant
procedure completer_caution (num_ab : IN integer; ab : IN OUT abonnes) ;


-- s�mantique : location de v�lo 
-- entr�e : un num�ro abonn�, un num�ro de station, la liste des abonn�s, la liste des stations
-- postcondition : modification de la liste des abonn�s et de la liste des stations
-- exception : abonne_inexistant, station_inexistante, station_vide
procedure louer_velo (num_ab, num_st : IN integer; ab : IN OUT abonnes; e : ensemble) ;


-- s�mantique : lors d'un vol ou perte, encaisse la caution d'un abonn�
-- entr�e : un num�ro, la liste des abonn�s
-- postcondition : modification de la liste des abonn�s
-- exception : abonne_inexistant
procedure probleme (num_ab : IN integer; ab : IN OUT abonnes) ;


-- s�mantique : restitution de v�lo apr�s location
-- entr�e : un num�ro abonn�, un num�ro de station, la liste des abonn�s,
--		    le temps �coul�, la liste des stations
-- postcondition : modification de la liste des abonn�s et de la liste des stations
-- exception : abonne_inexistant, station_inexistante, station_pleine
procedure rendre_velo (num_ab, num_st : IN integer; ab : IN OUT abonnes;
			 h_ecoulees : IN compteur; e : IN OUT ensemble) ;
			 

-- s�mantique : cr�� une liste vide d'abonn�s
function creer_liste_abonnes return abonnes;


-- s�mantique : renvoie la liste des abonn� dont le premier �l�ment est l'abonn� recherch�
-- entr�e : un num�ro, la liste des abonn�
-- exception : abonne_inexistant
function rechercher_abonne (num_ab : integer ; ab : abonnes) return abonnes;


-- s�mantique : conversion d'un temps sous forme heure et minutes en minutes
-- entr�e : temps
-- exception : pb_temps
function min_of_compteur (c : compteur) return integer ;


-- s�mantique : renvoie le montant de la location 
-- entr�e : le temps en minutes
-- pr�condition : le temps est positif
function a_payer (i : integer) return float ;


-- s�mantique : renvoie la liste des num�ros des v�los lou�s
-- entr�e : la liste des abonn�s
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
