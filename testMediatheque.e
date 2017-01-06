class TESTMEDIATHEQUE
	
creation {ANY}
    make 


feature {}

    mediatheque : MEDIATHEQUE


feature {ANY}

    make is
        do
            io.put_string("Début des tests de la classe Mediatheque%N")
            
            cas_make
            cas_ajouter_media
            cas_supprimer_media
            cas_ajouter_utilisateur
            cas_supprimer_utilisateur_ok
            cas_modifier_utilisateur_ok
            cas_emprunter_media_ok
            cas_emprunter_media_ko_media
            
            io.put_string("Fin des tests de la classe Mediatheque%N")
        end


    cas_make is 
        do

            create mediatheque.make_mediatheque

            if(mediatheque.get_nb_emprunts_max = 5 and mediatheque.get_duree_emprunt_media = 30) then 
                io.put_string("Test de création : Succès%N")
            else
                io.put_string("Test de création : Echec%N")
            end
        end

    cas_ajouter_media is 
        local 
            livre : LIVRE
            position : INTEGER
        do  
            create livre.make_livre("titre", 5, "auteur")

            mediatheque.ajouter_media(livre)

            position := mediatheque.get_medias.index_of(livre,0)

            if position = mediatheque.get_medias.upper + 1 then 
                io.put_string("Test ajout média : Echec%N")
            else
                io.put_string("Test ajout média  : Succès%N")
            end
        end 
        
    cas_supprimer_media is 
        local 
            livre : LIVRE
            position : INTEGER
        do  
            create livre.make_livre("titre12", 5, "auteur2")

            mediatheque.ajouter_media(livre)

            mediatheque.supprimer_media(livre)

            position := mediatheque.get_medias.index_of(livre,0)

            if position = mediatheque.get_medias.upper + 1 then 
                io.put_string("Test suppression média : Succès%N")
            else
                io.put_string("Test suppression média  : Echec%N")
            end
        end 

    cas_ajouter_utilisateur is 
        local 
            u : UTILISATEUR
            position : INTEGER
        do  
            create u.make_utilisateur("nom", "prenom", "identifiant")

            mediatheque.ajouter_utilisateur(u)

            position := mediatheque.get_users.index_of(u,0)

            if position = mediatheque.get_users.upper + 1 then 
                io.put_string("Test ajout utilisateur : Echec%N")
            else
                io.put_string("Test ajout utilisateur  : Succès%N")
            end
        end 





    cas_supprimer_utilisateur_ok is 
        local 
            user : UTILISATEUR
            position : INTEGER
        do  
            create user.make_utilisateur("nomsuppr", "nomsuppr", "nomsuppr")

            mediatheque.ajouter_utilisateur(user)
             mediatheque.supprimer_utilisateur(user)


            position := mediatheque.get_users.index_of(user,0)

            if position = mediatheque.get_users.upper + 1 then 
                io.put_string("Test suppression utilisateur : Succès%N")
            else
                io.put_string("Test suppression utilisateur  : Echec%N")
            end
        end 


    cas_modifier_utilisateur_ok is 
        local 
            user: UTILISATEUR
            user_update: UTILISATEUR
            user_in_mediatheque : UTILISATEUR
            position : INTEGER
        do 

            create user.make_utilisateur("nom1", "prenom1", "identifiant1")
            mediatheque.ajouter_utilisateur(user)
            create user_update.make_utilisateur("nom_new", "prenom_new", "identifiant1")
            mediatheque.modifier_utilisateur(user_update)

            position := mediatheque.get_users.index_of(user_update,0)

            create user_in_mediatheque.make_empty_utilisateur

            user_in_mediatheque.copy(mediatheque.get_users.item(position))

            if user_in_mediatheque.get_nom.is_equal("nom_new") and user_in_mediatheque.get_prenom.is_equal("prenom_new") and user_in_mediatheque.get_identifiant.is_equal("identifiant1") then 
                io.put_string("Test modification utilisateur : Succès%N")
            else 
                io.put_string("Test modification utilisateur : Echec%N")
            end    
        end

  
    cas_emprunter_media_ok is 
        local 
            user: UTILISATEUR
            livre : LIVRE
            emp : EMPRUNT
            date_limite : TIME
            position : INTEGER

        do
            create user.make_utilisateur("nom1", "prenom1", "identifiant1") 

            user.set_nb_emprunt(1)

            create livre.make_empty_livre

            livre.set_nombre(2)

            create emp.make_emprunt(user, livre, date_limite)

            mediatheque.emprunter_media(user,livre)

            position := mediatheque.get_emprunts.index_of(emp,0)

            if position = mediatheque.get_emprunts.upper + 1 then 
                io.put_string("Test utilisateur a emprunté: Echec %N")
            else
                io.put_string("Test utilisateur a emprunté : Succès%N")
            end

        end

    cas_emprunter_media_ko_usr is 
        local 
            user: UTILISATEUR
            livre : LIVRE
            emp : EMPRUNT
            date_limite : TIME
            position : INTEGER

        do
            create user.make_utilisateur("nom2", "prenom3", "identifiant1") 

            user.set_nb_emprunt(10)

            create livre.make_empty_livre

            livre.set_nombre(2)

            create emp.make_emprunt(user, livre, date_limite)

            mediatheque.emprunter_media(user,livre)

            position := mediatheque.get_emprunts.index_of(emp,0)

            if position = mediatheque.get_emprunts.upper + 1 then 
                io.put_string("Test utilisateur ne peut emprunter car trop d'emprunt en cours : Succès%N")
            else
                io.put_string("Test utilisateur ne peut emprunter car trop d'emprunt en cours : Echec %N")
            end
        end    

    cas_emprunter_media_ko_media is 
        local 
            user: UTILISATEUR
            livre : LIVRE
            emp : EMPRUNT
            date_limite : TIME
            position : INTEGER

        do
            create user.make_utilisateur("nom1", "prenom1", "identifiant4") 

            user.set_nb_emprunt(10)

            create livre.make_empty_livre

            livre.set_nombre(0)

            create emp.make_emprunt(user, livre, date_limite)

            mediatheque.emprunter_media(user,livre)

            position := mediatheque.get_emprunts.index_of(emp,0)

            if position = mediatheque.get_emprunts.upper + 1 then 
                io.put_string("Test utilisateur ne peut emprunter car media non disponible : Succès%N")
            else
                io.put_string("Test utilisateur ne peut emprunter car trop disponible : Echec %N")
            end
        end         




  
end -- class TESTMEDIATHEQUE
