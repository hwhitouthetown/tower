class DVDTEST
	
creation {ANY}
    make

feature {ANY}

    make is
        do
            io.put_string("Début des tests de la classe DVD%N")
            test_creation
            test_creation_vide
            test_set_annee
            test_set_realisateur
            test_set_type
            test_set_liste_acteurs
            test_ajouter_acteur
            test_supprimer_acteur
            io.put_string("Fin des tests de la classe DVD%N")
        end 
        
    test_creation is
    
        local 
            dvd : DVD
            liste_acteurs : ARRAY[STRING]
        do
            create liste_acteurs.with_capacity(1,0)
            liste_acteurs.force("acteur1", liste_acteurs.count)
            liste_acteurs.force("acteur2", liste_acteurs.count)
            create dvd.make_dvd("titre", 5, 1990, liste_acteurs, "realisateur", "type")
            if dvd.get_titre.compare("titre") = 0 and dvd.get_nombre = 5 and dvd.get_realisateur.compare("realisateur") = 0
               and dvd.get_type.compare("type") = 0 and dvd.get_annee = 1990 and dvd.get_liste_acteur.count = 2 then
                io.put_string("Test de création : Succès%N")
            else
                io.put_string("Test de création : Echec%N")
            end     
        end
        
    test_creation_vide is
        local 
            dvd : DVD
        do
            create dvd.make_empty_dvd
            if dvd.get_titre.compare("") = 0 and dvd.get_nombre = 0 and dvd.get_realisateur.compare("") = 0
               and dvd.get_type.compare("") = 0 and dvd.get_annee = 0 and dvd.get_liste_acteur.count = 0 then
                io.put_string("Test de création vide : Succès%N")
            else
                io.put_string("Test de création vide : Echec%N")
            end
        end	
        
    test_set_annee is
        local 
            dvd : DVD
        do
            create dvd.make_empty_dvd
            dvd.set_annee(2000)
            if dvd.get_annee = 2000 then
                io.put_string("Test de set annee : Succès%N")
            else
                io.put_string("Test de set annee : Echec%N")
            end
        end
        
    test_set_realisateur is
        local 
            dvd : DVD
        do
            create dvd.make_empty_dvd
            dvd.set_realisateur("rea2")
            if dvd.get_realisateur.is_equal("rea2") then
                io.put_string("Test de set realisateur : Succès%N")
            else
                io.put_string("Test de set realisateur : Echec%N")
            end
        end
        
    test_set_type is
        local 
            dvd : DVD
        do
            create dvd.make_empty_dvd
            dvd.set_type("type2")
            if dvd.get_type.is_equal("type2") then
                io.put_string("Test de set type : Succès%N")
            else
                io.put_string("Test de set type : Echec%N")
            end
        end
    
    test_set_liste_acteurs is
        local 
            dvd : DVD
            liste_acteurs : ARRAY[STRING]
        do
            create dvd.make_empty_dvd
            create liste_acteurs.with_capacity(1,0)
            liste_acteurs.force("acteur1", liste_acteurs.count)
            liste_acteurs.force("acteur2", liste_acteurs.count)
            dvd.set_liste_acteurs(liste_acteurs)
            if dvd.get_liste_acteur.count = 2 then
                io.put_string("Test de set liste acteur : Succès%N")
            else
                io.put_string("Test de set liste acteur : Echec%N")
            end
        end  
    
    test_ajouter_acteur is
        local 
            dvd : DVD
            liste_acteurs : ARRAY[STRING]
        do
            create dvd.make_empty_dvd
            create liste_acteurs.with_capacity(1,0)
            liste_acteurs.force("acteur1", liste_acteurs.count)
            liste_acteurs.force("acteur2", liste_acteurs.count)
            dvd.set_liste_acteurs(liste_acteurs)
            dvd.ajouter_acteur("acteur3")
            if dvd.get_liste_acteur.count = 3 then
                io.put_string("Test de ajouter acteur : Succès%N")
            else
                io.put_string("Test de ajouter acteur : Echec%N")
            end
        end
        
    test_supprimer_acteur is
        local 
            dvd : DVD
            liste_acteurs : ARRAY[STRING]
        do
            create dvd.make_empty_dvd
            create liste_acteurs.with_capacity(1,0)
            liste_acteurs.force("acteur1", liste_acteurs.count)
            liste_acteurs.force("acteur2", liste_acteurs.count)
            dvd.set_liste_acteurs(liste_acteurs)
            dvd.supprimer_acteur("acteur3")
            if dvd.get_liste_acteur.count = 2 then
                dvd.supprimer_acteur("acteur2")
                if dvd.get_liste_acteur.count = 1 then
                    io.put_string("Test de supprimer acteur : Succès%N")
                else
                    io.put_string("Test de supprimer acteur : Echec%N")
                end
            else
                io.put_string("Test de supprimer acteur : Echec%N")
            end
        end

end -- class DVDTEST
