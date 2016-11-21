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
	annee : INTEGER
	realisateur : STRING
	type : STRING
	list_acteurs : ARRAY[STRING]

feature {ANY}

	make_livre(titrei: STRING; createuri :STRING; nombrei : INTEGER;
			   anneei : INTEGER; liste_acteursi : ARRAY[STRING]
               realisateuri : STRING; typei : STRING) is
		do
			liste_acteurs.make(0,0)
			liste_acteurs.copy(liste_acteursi)

			make_media(titrei, createuri, nombrei)

			annee := 0 
			annee.copy(anneei)

            realisateur := ""
            realisateur.copy(realisateuri)

            type := ""
            type.copy(typei)
		end

    -- Getters

	get_annee : INTEGER is
        do
            Result := annee
        end

	get_realisateur : STRING is
        do
            Result := realisateur
        end

	get_type : STRING is
        do
            Result := type
        end

	get_liste_acteur : ARRAY[STRING] is
        do
            Result := liste_acteur
        end

	-- Setters

	set_annee(anneep: INTEGER) is
        do
            annee := anneep
        end

	set_realisateur(realisateurp: STRING) is
        do
            realisateur.copy(realisateurp)
        end

    set_type(typep: STRING) is
        do
            type.copy(typep)
        end

    set_liste_acteurs(liste_acteursp: ARRAY[STRING]) is
        do
            liste_acteurs := liste_acteursp
        end

	afficher is
		do
			io.put_string("----------DVD----------%N")
			io.put_string("Titre : " + titre + " %N")
			io.put_string("Auteur : " + auteur + " %N")
			io.put_string("Annee : " + annee.to_string + "%N") 
			io.put_string("Nombre d'exemplaire : " + nombre.to_string + "%N") 
            io.put_string("Realisateur : " + realisateur + " %N")
            io.put_string("Type : " + type + " %N")
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

end -- class DVD
