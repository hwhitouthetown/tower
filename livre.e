class LIVRE inherit
	MEDIA
		rename
			createur as auteur		
		redefine
			afficher
	end 
	
creation {ANY}
	make_livre  
 
feature {}
	auteur : STRING

feature {ANY}

	make_livre(titrei: STRING; createuri :STRING; nombrei : INTEGER; auteuri : STRING) is
		do
			make_media(titrei, createuri, nombrei)
			auteur := ""
			auteur.copy(auteuri)
		end

	-- Getters

	get_auteur : STRING is
        do
            Result := auteur
        end

	-- Setters

	set_auteur(auteurp: STRING) is
        do
            auteur.copy(auteurp)
        end

	afficher is
		do
			io.put_string("--------LIVRE--------%N")
			io.put_string("Titre : " + titre + " %N")
			io.put_string("Auteur : " + auteur + " %N")
			io.put_string("Nombre d'exemplaire : " + nombre.to_string + "%N") 
		end

end -- class LIVRE
