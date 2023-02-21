with list; use list;
with text_io; use text_io;
with ada.integer_text_io; use ada.integer_text_io;

PACKAGE BODY stations is

procedure ajouter_velo (l : IN OUT station; n : IN integer) is
begin
	if places_dispo(l) <= 0 then raise station_pleine; end if;
	inserer_tete(l.all.velo, n) ;
end ajouter_velo ;

procedure supprimer_velo (l : IN OUT station) is
begin
	if velos_dispo(l) = 0 then raise station_vide; end if;
	l.all.velo := queue(l.all.velo) ;
end supprimer_velo ;

function premier_velo (l : station) return integer is
begin
	if velos_dispo(l) = 0 then raise station_vide; end if;
	return tete(l.all.velo) ;
end premier_velo ;

function creer_station (i : integer; x,y : float; m : integer) return station is 
s : station := new el_s'(liste_vide, i, x, y, m) ;
begin
	if m<=0 then raise erreur_valeur ; end if;
	return s;	
end creer_station;

function est_vide (l : station) return boolean is
begin
	return vide(l.all.velo) ;
end est_vide;

function numero (l : station) return integer is 
begin
	return l.all.num;
end numero;

function max (l : station) return integer is
begin 
	return l.all.m;
end max;

function ensemble_velos (l : station) return liste is
begin
	return l.all.velo;
end ensemble_velos;

function velos_dispo (l : station) return integer is
begin
	return longueur(l.all.velo);
end velos_dispo;

function places_dispo (l : station) return integer is
begin
	return l.all.m-longueur(l.all.velo);
end places_dispo;

function coordx (l : station) return float is
begin
	return l.all.x;
end coordx;

function coordy (l : station) return float is
begin
	return l.all.y;
end coordy;

end stations;
