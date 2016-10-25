class DVD inherit
	MEDIA
		rename
			createur as realisateur		
		redefine
			afficher
	end 
	
creation {ANY}
	make_livre  

feature {}
	annee : INTEGER -- 
	list_acteur : FAST_ARRAY [STRING]

feature {ANY}

	make_livre(titrei: STRING; createuri :STRING; nombrei : INTEGER; anneei : INTEGER ;liste_acteuri : ARRAY [STRING]) is
		do
			liste_acteur.make(0,0)
			liste_acteur.copy(liste_acteuri)
			make_media(titrei, createuri, nombrei)
			annee := 0 
			annee.copy(anneei)
		end

	afficher is
		do
			io.put_string("----------DVD----------%N")
			io.put_string("Titre : " + titre + " %N")
			io.put_string("Auteur : " + auteur + " %N")
			io.put_string("Annee : " + annee.to_string + "%N") 
			io.put_string("Nombre d'exemplaire : " + nombre.to_string + "%N") 
		end

	afficher_acteurs is 
		local
			i: INTEGER
			taille_tab : integer
		do	
			taille_tab = liste_acteur.count
			from
			i := 0
			until
			i = liste_acteur
		loop
			io.put_string(liste_acteur.item(i) + "%N") 
			i := i+1
		end

		end 	

end -- class LIVRE