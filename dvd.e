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
            titre := ""
            titre.copy(titrei)

            nombre := nombrei

            annee := anneei 

            realisateur := ""
            realisateur.copy(realisateuri)

            type := ""
            type.copy(typei)
        end

    make_empty_dvd is 
        do
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
        	if(type.compare(" ") = 0) then 
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
	    require
            annee_valide : anneep >= 1800 or annee <= 2100
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
        local
            a : STRING
        do
            a := ""
            a.copy(acteur)
            liste_acteurs.force(a,liste_acteurs.count)
        end

    supprimer_acteur(acteur : STRING) is
        local
            i: INTEGER
            sup: BOOLEAN
        do	
            sup := False
            if(liste_acteurs.is_empty) then 
                io.put_string("aucun acteurs%N")
            else
                from
                    i := 0
                until
                    i = liste_acteurs.count
                loop
                    if liste_acteurs.item(i).compare(acteur) = 0 then
                        liste_acteurs.remove(i)
                        io.put_string("Suppresion de l'acteur " + acteur + " réussie%N")
                        sup := True
                    else
                        i := i+1
                    end
                end
                if not sup then
                    io.put_string("L'acteur " + acteur + " n'est pas dans la liste d'acteurs du DVD%N")
                end
            end
        end 


    afficher is
        do
            io.put_string("----------DVD----------%N")
            if est_empruntable then
              io.put_string("Empruntable : Oui%N")
            else
              io.put_string("Empruntable : Non%N")
            end
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
