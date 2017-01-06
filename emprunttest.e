class EMPRUNTTEST
	
creation {ANY}
    make

feature {}
    emprunt : EMPRUNT

feature {ANY}

    make is
        do
            io.put_string("Début des tests de la classe EMPRUNT%N")
            test_creation
            test_set_utilisateur 
            test_set_media 
            test_date_debut
            test_date_limite
            test_date_rendu
            test_a_retard
            test_est_rendu
            test_rendre
            io.put_string("Fin des tests de la classe EMPRUNT%N")
        end
        
    test_creation is
        local
            m : LIVRE
            u : UTILISATEUR
            time :TIME
        do
            time.update
            create m.make_livre("titre", 5, "auteur")
            create u.make_empty_utilisateur
            create emprunt.make_emprunt(u, m, time)
            if (emprunt.get_utilisateur = u and emprunt.get_media = m and emprunt.get_date_limite = time) then
                io.put_string("Test de création : Succès%N")
            else
                io.put_string("Test de création : Echec%N")
            end
        end
        
    test_set_utilisateur is
        local
            u : UTILISATEUR
        do
            create u.make_empty_utilisateur
            u.set_nom("test")
            emprunt.set_utilisateur(u)
            if (emprunt.get_utilisateur = u) then 
                io.put_string("Test de set utilisateur : Succès%N")
            else
                io.put_string("Test de set utilisateur : Echec%N")
            end
        end
        
    test_set_media is
        local
            m : LIVRE
        do
            create m.make_livre("titre autre", 10, "autre auteur")
            emprunt.set_media(m)
            if (emprunt.get_media = m) then 
                io.put_string("Test de set media : Succès%N")
            else
                io.put_string("Test de set media : Echec%N")
            end
        end
        
    test_date_debut is
        local
            time : TIME 
        do
            time.update
            emprunt.set_date_debut(time)
            if (emprunt.get_date_debut = time) then
                io.put_string("Test de set date debut : Succès%N")
            else
                io.put_string("Test de set date debut : Echec%N")
            end
        end
        
    test_date_limite is
        local
            time : TIME 
        do
            time.update
            time.add_day(3000) 
            emprunt.set_date_limite(time)
            if (emprunt.get_date_limite = time) then
                io.put_string("Test de set date limite : Succès%N")
            else
                io.put_string("Test de set date limite : Echec%N")
            end
        end
        
    test_date_rendu is
        local
            time : TIME 
        do
            time.update
            emprunt.set_date_rendu(time)
            if (emprunt.get_date_rendu = time) then
                io.put_string("Test de set date rendu : Succès%N")
            else
                io.put_string("Test de set date rendu : Echec%N")
            end
        end
    
    test_a_retard is 
        do   
            if (not emprunt.a_retard) then
                io.put_string("Test de set a retard : Succès%N")
            else
                io.put_string("Test de set a retard : Echec%N")
            end
        end
        
    test_est_rendu is 
        do   
            if (not emprunt.est_rendu) then
                io.put_string("Test de set est rendu : Succès%N")
            else
                io.put_string("Test de set est rendu : Echec%N")
            end
        end
    
    test_rendre is 
        local
            i : INTEGER
        do   
            i := emprunt.get_media.get_nombre
            emprunt.rendre
            if emprunt.get_media.get_nombre = i+1 then
                io.put_string("Test de set rendre : Succès%N")
            else
                io.put_string("Test de set rendre : Echec%N")
            end
        end

end -- class EMPRUNTTEST
