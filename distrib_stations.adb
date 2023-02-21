with stations; use stations;
with list; use list;
with Ada.Numerics.Elementary_Functions; use  Ada.Numerics.Elementary_Functions;
with text_io; use text_io;
with ada.integer_text_io; use ada.integer_text_io;

PACKAGE BODY distrib_stations is 

function distance (num_st : integer; e : ensemble) return ensemble is
s : station := rechercher_station(num_st,e) ;
lecture : ensemble := e ;
ens : ensemble := null;
begin
	while lecture/=null loop
		if sqrt((coordy(s)-coordy(lecture.all.s))**2+(coordx(s)-coordx(lecture.all.s))**2)<=1.0 then 
			introduire_station(lecture.all.s,ens) ;
		end if; 
	        lecture:=lecture.all.next ;
	end loop;
	return ens;
end distance;

function distrib_distance (num_st : integer; e : ensemble; R : float) return liste is
s : station := rechercher_station(num_st,e) ;
x : float := coordx(s) ;
y : float := coordy(s) ;
li : liste := liste_vide ;
lecture : ensemble := e ;
begin
	while lecture/=null loop

		if sqrt((coordy(s)-coordy(lecture.all.s))**2+(coordx(s)-coordx(lecture.all.s))**2)<=R then
			 inserer_tete(li,numero(lecture.all.s)) ;
		end if;
		lecture:=lecture.all.next;
	end loop;
	return li;
end distrib_distance;

procedure afficher_velos_dispo (num_st : IN integer; e : IN ensemble) is 
t : ensemble := distance(num_st,e) ;
begin
	while t/=null loop 
		put("station numéro ");
		put(numero(t.all.s), 1);
		put(" : ");
		put(longueur(ensemble_velos(t.all.s)),1);
		put(" velib disponibles");
		new_line;
		t:=t.all.next;
	end loop;
end afficher_velos_dispo;

procedure afficher_places_dispo (num_st : IN integer; e : IN ensemble) is 
t : ensemble := distance(num_st,e) ;
begin
	while t/=null loop 
		put("station numéro ");
		put(numero(t.all.s), 1);
		put(" : ");
		put(max(t.all.s)-longueur(ensemble_velos(t.all.s)),1);
		put(" places disponibles");
		new_line;
		t:=t.all.next;
	end loop;
end afficher_places_dispo;

procedure supprimer_station (num_st : IN integer; e : IN OUT ensemble) is
temp : ensemble := e ;
tempsuiv : ensemble ;
begin
	if temp = null then raise station_inexistante; end if;
	if numero(temp.all.s) = num_st then e := e.all.next ;
	else tempsuiv := temp.all.next ;
		while (tempsuiv /= null and then numero(tempsuiv.all.s) /= num_st) loop
			temp := temp.all.next ;
			tempsuiv := tempsuiv.all.next ;
		end loop;
		if tempsuiv = null then raise station_inexistante;
		else temp.all.next := tempsuiv.all.next ;
		end if;
	end if;
end supprimer_station;
	
procedure introduire_station (s : IN station; e : IN OUT ensemble) is
e0 : ensemble := new el_e;
begin
	e0.all.s := s;
	e0.all.next := e;
	e:=e0;
end introduire_station;

function creer_liste_stations return ensemble is
begin
	return null;
end creer_liste_stations;

function rechercher_station (num_st : integer; e : ensemble) return station is
temp : ensemble := e;
begin
	while (temp /= null and then numero(temp.all.s) /= num_st) loop
		temp := temp.all.next ;
	end loop;
	if temp=null then raise station_inexistante;
	else return temp.all.s ;
	end if;
end rechercher_station;

end distrib_stations;	
