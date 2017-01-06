class TESTLIVRE
	
creation {ANY}
    make 

feature {ANY}

    make is
        do
            io.put_string("Début des tests de la classe LIVRE%N")
            test_creation
            test_creation_vide
            test_set_auteur
            io.put_string("Fin des tests de la classe LIVRE%N")
        end
        
    test_creation is
        local 
            livre : LIVRE
        do
            create livre.make_livre("titre", 5, "auteur")
            if (livre.get_titre.compare("titre") = 0 and livre.get_nombre = 5 and livre.get_auteur.compare("auteur") = 0) then
                io.put_string("Test de création : Succès%N")
            else
                io.put_string("Test de création : Echec%N")
            end     
        end
        
    test_creation_vide is
        local 
            livre : LIVRE
        do
            create livre.make_empty_livre
            if livre.get_titre.compare("") = 0 and livre.get_nombre = 0 and livre.get_auteur.compare("") = 0 then
                io.put_string("Test de création vide : Succès%N")
            else
                io.put_string("Test de création vide : Echec%N")
            end
        end
        
        
    test_set_auteur is
        local 
            livre : LIVRE
        do
            create livre.make_livre("titre", 5, "auteur")
            livre.set_auteur("auteur nouveau")
            if livre.get_auteur.compare("auteur nouveau") = 0 then
                io.put_string("Test de set : Succès%N")
            else
                io.put_string("Test de set : Echec%N")
            end
        end
end -- class TESTLIVRE
