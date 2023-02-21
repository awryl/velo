PACKAGE list is

type liste is private ;
e_vide : exception;

procedure inserer_tete (l : IN OUT liste; i : IN integer) ;
procedure afficher_liste (l : IN liste) ;
function liste_vide return liste ;
function vide (l : liste) return boolean ;
function tete (l : liste) return integer ;
function queue (l : liste) return liste ;
function longueur (l : liste) return integer ;

PRIVATE

type el ;
type liste is access el ;
type el is record
	next : liste ;
	val : integer ;
end record;

end list;
