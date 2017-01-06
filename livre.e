class LIVRE inherit
    MEDIA	
        redefine
            afficher,is_equal 
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

            nombre := nombrei

            auteur := ""
            auteur.copy(auteuri)
        end

    make_empty_livre is
        do 
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

    is_equal(other : LIVRE) : BOOLEAN is
        do
            Result := auteur.is_equal(other.get_auteur) and titre.is_equal(other.get_titre)
        end

       

end -- class LIVRE
