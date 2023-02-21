with list; use list;
with stations; use stations;
with distrib_stations; use distrib_stations;
with text_io; use text_io;
with ada.integer_text_io; use ada.integer_text_io;
with ada.float_text_io; use ada.float_text_io;

PACKAGE BODY gestion_abonnes is

procedure creer_abonne (num_ab,c_p : IN integer; ab : IN OUT abonnes) is
a : abonnes := new el_ab'(num_ab, c_p, 3.0, false, 0, true, ab) ;
begin
	ab := a;
end creer_abonne;

procedure supprimer_abonne (num_ab : IN integer; ab : IN OUT abonnes) is
temp : abonnes := ab ;
tempsuiv : abonnes ;
begin
	if temp = null then raise abonne_inexistant; end if;
	if temp.all.num = num_ab then ab:= ab.all.next ;
	else tempsuiv := temp.all.next ;
		while (tempsuiv /= null and then tempsuiv.all.num /= num_ab) loop
			temp := temp.all.next ;
			tempsuiv := tempsuiv.all.next ;
		end loop;
		if tempsuiv = null then raise abonne_inexistant;
		else temp.all.next := tempsuiv.all.next ;
		end if;
	end if;
end supprimer_abonne;

procedure infos_abonne (num_ab : IN integer; ab : IN OUT abonnes) is
a : abonnes := rechercher_abonne(num_ab,ab) ;
begin
	put("Informations sur l'abonné numéro ") ; put(num_ab,1) ; put_line(" :");
	put("Code postal : ") ; put(a.all.code_postal,1) ; new_line ; 
	put("Crédit : ") ; put(a.all.cr,1) ; new_line ;
	if a.all.caut = false then put_line("Attention, la caution de l'abonné n'existe plus.") ;
	end if;
	if a.all.b then 
		put("L'abonne est en ce moment en circulation avec le velo numero ") ;
		put(a.all.num_velo,1) ; new_line ;
	end if;
end infos_abonne;


procedure verser_argent (num_ab : IN integer; ab : IN OUT abonnes; montant : IN float) is 
a : abonnes := rechercher_abonne(num_ab,ab) ;
begin
	if montant <=0.0 then raise pb_montant ; end if;
	a.all.cr := a.all.cr+montant ;
end verser_argent;

procedure completer_caution (num_ab : IN integer; ab : IN OUT abonnes) is
a : abonnes := rechercher_abonne(num_ab,ab) ;
begin
	if a.all.caut then
		put("L'abonné numero ") ; put(num_ab,1) ; put("a déjà donné une caution") ;
	else 
		a.all.caut := true ;
		put("Nouvelle caution donnée") ;
	end if;
end completer_caution;

procedure louer_velo (num_ab, num_st : IN integer; ab : IN OUT abonnes; e : ensemble) is
a : abonnes := rechercher_abonne(num_ab,ab) ;
r : station := rechercher_station(num_st,e) ;
begin
	if a.all.b then 
		put("L'abonné numero ") ; put(num_ab,1) ; put("a déjà loué un vélo") ;
	else if a.all.caut=false then 
		put("L'abonné numero ") ; put(num_ab,1) ; put(" doit refaire une caution") ;
	else if a.all.cr<=0.0 then
		put("L'abonné numéro ") ; put(num_ab,1) ; put(" doit verser de l'argent sur son compte") ;
	else	
                a.all.num_velo := premier_velo(r) ;
		a.all.b := true ;
		put("L'abonné numero ") ; put(num_ab,1) ;
                put(" vient de louer le velib numéro ") ; put(a.all.num_velo,1) ;
		put(" a la station numéro ") ; put(num_st,1) ;
		supprimer_velo(r) ;
	end if;
	end if;
		new_line;
	end if;
end louer_velo;

procedure probleme (num_ab : IN integer; ab : IN OUT abonnes) is
a : abonnes := rechercher_abonne(num_ab,ab) ;
begin
	if a.all.b then 
		a.all.caut := false ;
		a.all.b := false ;
		put("L'abonné numero ") ; put(num_ab,1) ;
		put(" vient de perdre sa caution pour cause de détérioration, perte ou vol") ;		
	else put("L'abonné numero ") ; put(num_ab,1) ; put(" n'a pas loué") ;
	end if;
end probleme;

procedure rendre_velo (num_ab, num_st : IN integer; ab : IN OUT abonnes; h_ecoulees : IN compteur; e : IN OUT ensemble) is
p : float := a_payer(min_of_compteur(h_ecoulees)) ;
a : abonnes := rechercher_abonne(num_ab,ab) ;
s : station := rechercher_station(num_st,e) ;
begin
	if a.all.b then
		ajouter_velo(s,a.all.num_velo) ;
		if p<=a.all.cr then                        
			a.all.cr := a.all.cr-p ;
			put("L'abonné numéro ") ; put(num_ab,1) ;
			put(" vient d'être débité de ") ; put(p) ; put(" euros.") ;
		else if p-a.all.cr>150.0 then 
			a.all.caut := false ;
			put("L'abonné numéro ") ; put(num_ab,1) ;
			put(" vient de perdre sa caution,") ;
			put(" le montant des dettes de l'abonné est maintenant de ") ;
			put(p-a.all.cr-150.0) ;
		else	
			put("L'abonné numéro ") ; put(num_ab,1) ;
			put(" devra verser ") ; put(p-a.all.cr,1) ;
			put(" pour pouvoir louer une nouvelle fois") ;

		end if;
		end if;
			new_line;
	else 	put("L'abonné numéro ") ; put(num_ab,1) ; put(" n'a pas loué") ;
			
	end if;
end rendre_velo;

function creer_liste_abonnes return abonnes is
begin
	return null;
end creer_liste_abonnes;

function rechercher_abonne (num_ab : integer ; ab : abonnes) return abonnes is
temp : abonnes := ab;
begin
	while (temp /= null and then temp.all.num /= num_ab) loop
		temp := temp.all.next ;
	end loop;
	if temp=null then raise abonne_inexistant;
	else return temp ;
	end if;
end rechercher_abonne;

function min_of_compteur (c : compteur) return integer is
begin 
	if (c.h<0 or c.m<0 or c.m>60) then raise pb_temps ; end if;
	return (c.m+60*c.h) ;
end min_of_compteur;

function a_payer (i : integer) return float is
y : integer := i/30 ;
begin
	return float(y)*0.5 ; 
end a_payer;

function velos_circulation (ab : abonnes) return liste is
lecture : abonnes := ab ;
li : liste := liste_vide ;
begin
	while lecture/=null loop
		if lecture.all.b then
			 inserer_tete(li,lecture.all.num_velo) ;
		end if;
		lecture := lecture.all.next ;
	end loop;
	return li;
end velos_circulation;

end gestion_abonnes;

