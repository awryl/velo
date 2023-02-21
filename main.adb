with list; use list;
with stations; use stations;
with distrib_stations; use distrib_stations;
with gestion_abonnes; use gestion_abonnes;
with text_io; use text_io;
with ada.integer_text_io; use ada.integer_text_io;
with ada.float_text_io; use ada.float_text_io;

procedure main is 

liste_abonnes : abonnes := creer_liste_abonnes;
liste_stations : ensemble := creer_liste_stations;
c1,c2 : character;
q : boolean := false;
nb_st, nb_velo, nb_ab : integer := 1;
p1,p2 : float;
k1,k2,k3,k4 : integer;
s : station;
c : compteur;
begin

loop
begin
	new_line;
	put_line("Bienvenue sur la plateforme de gestion manuelle de Velib inter-ville" ) ;
	put_line("Quel type d'opérations voulez-vous effectuer ? (q : quitter)") ;
	new_line;
	put_line("_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-" ) ;
   	new_line;
	put_line("(1) Gestion de stations");
	put_line("(2) Gestion de location");
	put_line("(3) Gestion d'abonnés");
	new_line;
	put_line("_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-" ) ;
	new_line;
	loop
		get(c1);
	exit when (c1='1' or c1='2' or c1='3' or c1 = 'q');
	end loop;

	case c1 is
	when '1' =>
		new_line;
		put_line("Vous êtes dans le terminal de contrôle de l'ensemble des stations" ) ;
		put_line("Choisissez une opération à effectuer (q : quitter)") ;
		loop
		begin
		new_line;
		put_line("_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-" ) ;
   		new_line;
		put_line("(0) Revenir au menu principal");
		put_line("(1) Créer une station");
		put_line("(2) Supprimer une station");
		put_line("(3) Afficher les velib disponibles dans un rayon de 1 km d'une station");
		put_line("(4) Afficher les places disponibles dans un rayon de 1 km d'une station");
		put_line("(5) Afficher l'ensemble des stations proches d'une station");
		new_line;
		put_line("_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-" ) ;
		new_line;
		loop
			get(c2);
		exit when (c2='0' or c2='1' or c2='2' or c2='3' or c2='4' or c2='5' or c2 = 'q');
		end loop;
		case c2 is
		when '1' =>
			put("Donnez les coordonnées (réels) de la nouvelle station ('x y') : ");
			get(p1); get(p2); 
			put("Donnez le nombre maximum de velib : ") ; get(k1) ;
			s := creer_station(nb_st,p1,p2,k1) ;
			introduire_station(s,liste_stations) ;
			loop
				put("Donnez le nombre de velib initial : ") ; get(k2) ; 
			exit when (k2<=k1 and k2>=0) ;
			end loop;
			k3:=nb_velo ;
			while nb_velo<k2+k3 loop
				ajouter_velo(s,nb_velo) ;
				nb_velo:=nb_velo+1 ;
			end loop;
			put("Création de station reussie. Numéro affectée a la station : ") ; put(nb_st,1) ;
			new_line ;
			nb_st:=nb_st+1;
		when '2' =>
			put("Donnez le numéro de la station à détruire : ") ; get(k1) ; 
			supprimer_station(k1,liste_stations) ;
			put_line("Station détruite. Pas de degats collatéraux.") ;
		when '3' =>
			put("Donnez le numéro d'une station : ") ; get(k1) ; 
			afficher_velos_dispo(k1,liste_stations) ;
		when '4' =>
			put("Donnez le numéro d'une station : ") ; get(k1) ; 
			afficher_places_dispo(k1,liste_stations) ;
		when '5' =>
			put("Donnez le numéro d'une station : ") ; get(k1) ; 
			put("Donnez le rayon maximal de détection des stations (réel) : ") ; get(p1) ;
			put_line("Voici les numéros des stations proches :") ;
			afficher_liste(distrib_distance(k1,liste_stations,p1)) ;
		when others => null;
		end case;
		exception
			when station_inexistante => put_line("Cette station n'existe pas.") ;
		end;
		exit when (c2='0' or c2='q');
		end loop;

	when '2' =>
		new_line;
		put_line("Vous êtes dans le menu de gestion de location des utilisateurs" ) ;
		put_line("Choisissez une opération à effectuer (q : quitter)") ;
		loop
		begin
		new_line;
		put_line("_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-" ) ;
   		new_line;
		put_line("(0) Revenir au menu principal");
		put_line("(1) Signaler une location de velib");
		put_line("(2) Signaler une restitution de velib");
		put_line("(3) Constater un vol, une perte ou une détérioration d'un velib");
		put_line("(4) Afficher l'ensemble des velib en circulation");
		new_line;
		put_line("_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-" ) ;
		new_line;
		loop
			get(c2);
		exit when (c2='0' or c2='1' or c2='2' or c2='3' or c2='4' or c2 = 'q');
		end loop;
		case c2 is
		when '1' =>
			put("Donnez le numéro de la station : ") ; get(k1) ; 
			put("Donnez le numéro de l'abonné : ") ; get(k2) ; 
			louer_velo(k2,k1,liste_abonnes,liste_stations) ;
		when '2' =>
			put("Donnez le numéro de la station : ") ; get(k1) ; 
			put("Donnez le numéro de l'abonné : ") ; get(k2) ; 
			put("Donnez le nombre d'heures et de minutes écoulées durant la location ('h m') : ") ;
			get(k3) ; get(k4) ; 
			c.h := k3 ; c.m := k4 ;
			rendre_velo(k2,k1,liste_abonnes,c,liste_stations) ;
		when '3' =>
			put("Donnez le numéro de l'abonné : ") ; get(k1) ; 
			probleme(k1,liste_abonnes) ;
		when '4' =>
			put_line("Voici la liste des velib en circulation en ce moment :") ;
			afficher_liste(velos_circulation(liste_abonnes)) ;
		when others => null;
		end case;
		exception
			when station_vide => put_line("Cette station est vide ") ;
			when station_pleine => put_line("Cette station est pleine.") ;
			when station_inexistante => put_line("Cette station n'existe pas.") ;
			when abonne_inexistant => put("Cet abonné n'existe pas.") ;
		end;
		exit when (c2='0' or c2='q');
		end loop;

	when '3' =>
		new_line;
		put_line("Vous êtes dans le menu de gestion de la base de données des abonnés" ) ;
		put_line("Choisissez une opération à effectuer (q : quitter)") ;
		loop
		begin
		new_line;
		put_line("_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-" ) ;
   		new_line;
		put_line("(0) Revenir au menu principal");
		put_line("(1) Ajouter un compte abonné");
		put_line("(2) Supprimer un compte abonné");
		put_line("(3) Présenter les informations d'un abonné");
		put_line("(4) Signaler un versement d'argent dans un compte abonné");
		put_line("(5) Signaler une nouvelle caution de la part d'un abonné");
		new_line;
		put_line("_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-" ) ;
		new_line;
		loop
			get(c2) ;
		exit when (c2='0' or c2='1' or c2='2' or c2='3' or c2='4' or c2='5' or c2 = 'q');
		end loop;
		case c2 is
		when '1' =>
			put("Donnez le code postal de l'abonné : ") ; get(k1) ; 
			creer_abonne(nb_ab,k1,liste_abonnes) ;
			put("Compte abonné cree. Le numéro affectee à l'abonné est : ") ; put(nb_ab,1) ;
			new_line ;
			nb_ab := nb_ab + 1 ;
		when '2' =>
			put("Donnez le numéro de l'abonné : ") ; get(k1) ; 
			supprimer_abonne(k1,liste_abonnes) ;
			put_line("Compte abonné supprimé.") ;
		when '3' =>	
			put("Donnez le numéro de l'abonné : ") ; get(k1) ; 
			infos_abonne(k1,liste_abonnes) ;
		when '4' =>
			put("Donnez le numéro de l'abonné : ") ; get(k1) ; 
			put("Donnez le montant du versement (réel) : ") ; get(p1) ;
			verser_argent(k1,liste_abonnes,p1) ;
			put_line("Versement réussi") ;
		when '5' =>
			put("Donnez le numéro de l'abonné : ") ; get(k1) ; 
			completer_caution (k1,liste_abonnes) ;
		when others => null;
		end case;
		exception
			when abonne_inexistant => put_line("Cet abonné n'existe pas.") ;
			
		end;
		exit when (c2='0' or c2='q');
		end loop;
	when others => null;
	end case;
exception
	when others => new_line; new_line ; put_line("------------ ERREUR ------------") ; new_line ;
end;
exit when (c2='q' or c1='q');
end loop;

end main;

