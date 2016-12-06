class DVD inherit
	MEDIA
        redefine
			afficher
        end 
	
creation {ANY}
	make_dvd, 
	make_empty_dvd

feature {}
	annee : INTEGER
	type : STRING
	liste_acteurs : ARRAY[STRING]
	realisateur : STRING

feature {ANY}

	make_dvd(titrei: STRING; nombrei : INTEGER;
			   anneei : INTEGER; liste_acteursi : ARRAY[STRING];
               realisateuri : STRING; typei : STRING) is
		do
			create liste_acteurs.with_capacity(1,0)
			liste_acteurs.copy(liste_acteursi)

			--make_media(titrei, nombrei)
			
			titre := ""
			titre.copy(titrei)
			
			nombre := 0
			nombre.copy(nombrei)

			annee := 0 
			annee.copy(anneei)

            realisateur := ""
            realisateur.copy(realisateuri)

            type := ""
            type.copy(typei)
		end

	make_empty_dvd is 
		do
			--make_empty_media 
			titre := ""
			nombre := 0
			realisateur := ""
			type := ""
			annee := 0
			create liste_acteurs.with_capacity(1,0)

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
        	if(type = " ") then 
        		Result := "Inconnu"
        	else 
            	Result := type
            end 
        end

	get_liste_acteur : ARRAY[STRING] is
        do
            Result := liste_acteurs
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

    -- Others
    
    ajouter_acteur(acteur : STRING) is 
    	do
    		liste_acteurs.force(acteur,liste_acteurs.count)
    	end



	afficher is
		do
			io.put_string("----------DVD----------%N")
			io.put_string("Titre : " + titre + " %N")
			io.put_string("Realisateur : " + realisateur + " %N")
			io.put_string("Annee : " + annee.to_string + "%N") 
			io.put_string("Nombre d'exemplaire : " + nombre.to_string + "%N") 
            io.put_string("Acteur(s) : ") 
            afficher_acteurs
            io.put_string("%NType : " + type + " %N")
		end

	afficher_acteurs is 
		local
			i: INTEGER
		do	
			if(liste_acteurs.is_empty) then 
				io.put_string("aucun acteurs%N")
			else
				

				from
			 	   i := 0
				until
			 	   i = liste_acteurs.count
		    	loop
			   		io.put_string(liste_acteurs.item(i) + " | ") 
			   		i := i+1
		    	end
		    end
		end 	

end -- class DVD
