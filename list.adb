with text_io; use text_io;
with ada.integer_text_io; use ada.integer_text_io;

PACKAGE BODY list is

procedure inserer_tete (l : IN OUT liste ; i : IN integer) is
l2 : liste := new el; 
begin
	l2.val := i;
	l2.next := l;
 	l := l2;
end inserer_tete;

procedure afficher_liste (l : IN liste) is
begin
	if l /= null then
		put(l.all.val, 1); put(" ");
		afficher_liste (l.all.next);
	end if;	 
	new_line;
end afficher_liste;

function liste_vide return liste is 
begin
	return null;
end liste_vide;

function vide (l : liste) return boolean is
begin
	return l=null;
end vide;
 
function tete (l : liste) return integer is
begin 
	return l.all.val; 
end tete;

function queue (l : liste) return liste is
begin 
	if l=null then raise e_vide; end if;
	return l.all.next ; 
end queue;

function longueur (l : liste) return integer is
i : integer := 0;
temp : liste := l;
begin
	while temp /= null loop
		i := i+1;
		temp := temp.all.next;
	end loop;
	return i;
end longueur;

end list;
