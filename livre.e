class LIVRE inherit
    MEDIA	
        redefine
            afficher
        end 
	
creation {ANY}
    make_livre,
    make_empty_livre  
	
feature {}

    auteur : STRING 

feature {ANY}

    make_livre(titrei: STRING; nombrei : INTEGER; auteuri : STRING) is
        do
            titre := ""
            titre.copy(titrei)

            nombre := 0
            nombre.copy(nombrei)

            auteur := ""
            auteur.copy(auteuri)
        end

    make_empty_livre is 
            titre := ""
            nombre := 0
            auteur := ""
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
