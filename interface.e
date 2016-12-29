class INTERFACE
-- Represente une 	
creation {ANY}
    make

feature {}
    connect: INTEGER -- entier 0 non connecté -- 1 connecte user -- 2 connect admin
    prenom : STRING
    mediatheque : MEDIATHEQUE
    utilisateur_connecte : UTILISATEUR


feature {ANY}

	make is
        do
            create mediatheque.make_mediatheque
            connect := 0
            prenom := ""
            menu_general
        end 

    menu_general is 
        local 
        choix : INTEGER	
        do
            choix:=1        	
            from
            until choix = 0 
            loop

                io.put_string(" ------------- BIENVENUE -------------%N")
                io.put_string("| 1 - Consulter les médias            |%N")

                inspect connect
                    when 0 then 
                        io.put_string("| 2 - Utilisateur ? Connectez-vous!   |%N")
                        io.put_string("| 3 - Administrateur ? Connectez-vous!|%N")

                    when 1 then 
                        io.put_string("| 2 - Se déconnecter                  |%N")
                        io.put_string("| 3 - Faire un emprunt                |%N")
                        io.put_string("| 4 - Rendre un média                 |%N")

                    when 2 then 
                        io.put_string("| 2 - Se déconnecter                  |%N")
                        io.put_string("| 3 - Faire un emprunt                |%N")
                        io.put_string("| 4 - Rendre un média                 |%N")
                        io.put_string("| 5 - Gérer les utilisateurs          |%N")
                        io.put_string("| 6 - Gérer les emprunts              |%N")
                        io.put_string("| 7 - Gérer les médias                |%N")
                        
                end -- inspect          

                io.put_string("| 0 - Quitter                         |%N")
                io.put_string(" -------------------------------------%N")

                io.put_string("%NEntrez votre choix %N")

                io.read_integer
                io.read_line -- FIX read_integer saute le prochain read_line
                choix := io.last_integer

                inspect choix
                    when 1 then
                        io.put_string("--- MEDIAS ---%N")
                        mediatheque.afficher_medias

                    when 2 then
                        if(connect = 0) then
                            connect:= se_connecter_user
                        else 
                            connect:= 0
                        end -- endif

                    when 3 then
                        if(get_connect = 0) then
                            connect := se_connecter_admin
                        else 
                            menu_faire_emprunt
                        end -- endif    

                    when 4 then 
                        menu_rendre_emprunt

                    when 5 then 
                        menu_usr
                        
                    when 6 then
                        menu_empr
                        
                    when 7 then
                        menu_medias
           
                    when 0 then
                        --quitter le programme
                        io.put_string("Vous quittez le programme %N")

                    else
                        io.put_string("Choix incorrect %N")
                end -- inspect
            end -- loop 
        end	
        
    --------------------- MENUS MEDIAS ------------------------------
        
    menu_medias is
        local
            choix_menu, choix_media, choix_modif, choix_ajout, nb, annee, i : INTEGER
            media : MEDIA
            titre, auteur, realisateur, type, acteur : STRING
            livre : LIVRE
            dvd : DVD
            sup: BOOLEAN
        do
            choix_menu := 1
            from
            until choix_menu = 0 
            loop

                io.put_string(" ---------------- GESTION DES MEDIAS ----------------%N")
                io.put_string("| 1 - Modifier un média                              |%N")
                io.put_string("| 2 - Supprimer un média                             |%N")
                io.put_string("| 3 - Ajouter un média                               |%N")
                io.put_string("| 0 - Retour                                         |%N")         
                io.put_string(" ----------------------------------------------------%N") 

                io.put_string("%NEntrez votre choix %N")
                io.read_integer
                io.read_line -- FIX read_integer saute le prochain read_line
                choix_menu := io.last_integer

                inspect choix_menu 
                    when 1 then
                        io.put_string("--- MEDIAS ---%N")
                        mediatheque.afficher_medias
                        io.put_string("Quel média voulez-vous modifier ?%N")
                        io.read_integer
                        io.read_line -- FIX read_integer saute le prochain read_line
                        choix_media := io.last_integer
                        if choix_media < 0 or choix_media >= mediatheque.get_medias.count then
                            io.put_string("N° de média invalide%N")
                        else
                            media := mediatheque.get_medias.item(choix_media)
                            choix_modif := 1
                            from
                            until
                                choix_modif = 0
                            loop
                                media.afficher
                                io.put_string(" ------------ Que voulez vous modifier ? ------------%N")
                                io.put_string("| 1 - Le titre                                       |%N")
                                io.put_string("| 2 - Le nombre d'exemplaire                         |%N")
                                if media.generator.compare("DVD") = 0 then
                                    io.put_string("| 3 - L'année                                        |%N")
                                    io.put_string("| 4 - Le type                                        |%N")
                                    io.put_string("| 5 - Le réalisateur                                 |%N")
                                    io.put_string("| 6 - Ajoute un acteur                               |%N")
                                else
                                    io.put_string("| 3 - L'auteur                                       |%N")
                                end
                                io.put_string("| 0 - Retour                                         |%N")  
                                io.put_string(" ----------------------------------------------------%N") 
                                io.read_integer
                                io.read_line
                                choix_modif := io.last_integer
                                inspect choix_modif 
                                    when 1 then
                                        io.put_string("Entrez le nouveau titre%N")
                                        io.read_line
                                        titre := io.last_string
                                        if not (titre.compare("") = 0) then
                                            media.set_titre(titre)
                                            io.put_string("Le titre a bien été modifié%N")
                                        else
                                            io.put_string("Le titre ne peut pas être vide%N")
                                        end 
                                        
                                    when 2 then
                                        io.put_string("Entrez le nouveau nombre d'exemplaire%N")
                                        io.read_integer
                                        io.read_line
                                        nb := io.last_integer
                                        if nb < 0 then
                                            io.put_string("Le nombre d'exemplaire doit être supérieur à 0%N")
                                        else
                                            media.set_nombre(nb)
                                            io.put_string("Nombre d'exemplaire modifié%N")
                                        end
                                        
                                    when 3 then
                                        if media.generator.compare("DVD") = 0 then
                                            io.put_string("Entrez la nouvelle année%N")
                                            io.read_integer
                                            io.read_line
                                            annee := io.last_integer
                                            if annee < 1800 or annee > 2100 then
                                                io.put_string("Année invalide")
                                            else
                                                media.set_annee(annee)
                                                io.put_string("L'annee du DVD a bien été modifiée%N")
                                            end
                                        else
                                            io.put_string("Entrez le nouvel auteur%N")
                                            io.read_line
                                            auteur := io.last_string
                                            if not (auteur.compare("") = 0) then
                                                media.set_auteur(auteur)
                                                io.put_string("L'auteur du livre a bien été modifié%N")
                                            else
                                                io.put_string("L'auteur ne peut pas être vide%N")
                                            end 
                                        end
                                    
                                    when 4 then
                                        io.put_string("Entrez le nouveau type du DVD%N")
                                        io.read_line
                                        type := io.last_string
                                        if not (type.compare("") = 0) then
                                            media.set_type(type)
                                            io.put_string("Le type du DVD a bien été modifié%N")
                                        else
                                            io.put_string("Le type ne peut pas être vide%N")
                                        end 
                                    
                                    when 5 then
                                        io.put_string("Entrez le nouveau réalisateur%N")
                                        io.read_line
                                        realisateur := io.last_string
                                        if not (realisateur.compare("") = 0) then
                                            media.set_realisateur(realisateur)
                                            io.put_string("Le réalisateur du DVD a bien été modifié%N")
                                        else
                                            io.put_string("Le réalisateur ne peut pas être vide%N")
                                        end 
                                    
                                    when 6 then
                                        io.put_string("Entrez le nom de l'acteur à ajouter%N")
                                        io.read_line
                                        acteur := io.last_string
                                        if not (acteur.compare("") = 0) then
                                            media.ajouter_acteur(acteur)
                                            io.put_string("L'acteur a bien été rajouté%N")
                                        else
                                            io.put_string("L'acteur ne peut pas être vide%N")
                                        end 
                                    
                                    when 0 then
                                        io.put_string("Retour au menu précédent%N")  
                                        
                                    else
                                        io.put_string("Choix incorrect%N") 
                                end -- inspect 
                            end -- loop
                        end   

                    when 2 then 
                        io.put_string("--- MEDIAS ---%N")
                        mediatheque.afficher_medias
                        io.put_string("Quel média voulez-vous supprimer ?%N")
                        io.read_integer
                        io.read_line -- FIX read_integer saute le prochain read_line
                        choix_media := io.last_integer
                        if choix_media < 0 or choix_media >= mediatheque.get_medias.count then
                            io.put_string("N° de média invalide%N")
                        else
                            mediatheque.supprimer_media(mediatheque.get_medias.item(choix_media))
                            io.put_string("Suppression du média validée%N") 
                        end 

                    when 3 then 
                        io.put_string("Que voulez vous créer ? DVD (1) ou Livre (2) ? %N")
                        io.read_integer
                        io.read_line
                        choix_ajout := io.last_integer
                        inspect choix_ajout
                            when 1 then
                                create dvd.make_empty_dvd
                                io.put_string("Quel titre ?%N")
                                io.read_line
                                titre := io.last_string
                                if not (titre.compare("") = 0) then
                                    dvd.set_titre(titre)
                                    io.put_string("Combien d'exemplaire ?%N")
                                    io.read_integer
                                    io.read_line
                                    nb := io.last_integer
                                    if nb < 0 then
                                        io.put_string("Le nombre d'exemplaire doit être supérieur à 0, retour au menu précédent%N")
                                    else
                                        dvd.set_nombre(nb)
                                        io.put_string("Quel réalisateur ?%N")
                                        io.read_line
                                        realisateur := io.last_string
                                        if not (realisateur.compare("") = 0) then
                                            dvd.set_realisateur(realisateur)
                                            io.put_string("Quelle année ?%N")
                                            io.read_integer
                                            io.read_line
                                            annee := io.last_integer
                                            if annee < 1800 or annee > 2100 then
                                                io.put_string("Année invalide, retour au menu précédent")
                                            else
                                                dvd.set_annee(annee)
                                                io.put_string("Quel type ?%N")
                                                io.read_line
                                                type := io.last_string
                                                if not (type.compare("") = 0) then
                                                    dvd.set_type(type)
                                                    from
                                                        acteur := "before"
                                                    until
                                                        acteur.compare("") = 0
                                                    loop
                                                        io.put_string("Ajouter un acteur (vide pour arrêter)%N")
                                                        io.read_line
                                                        acteur := io.last_string
                                                        if not (acteur.compare("") = 0) then
                                                            dvd.ajouter_acteur(acteur)
                                                        end
                                                    end                                                   
                                                    mediatheque.ajouter_media(dvd)
                                                    io.put_string("Le DVD a bien été ajouté aux médias%N")
                                                else
                                                    io.put_string("Le type ne peut pas etre vide, retour au menu précédent%N")
                                                end
                                            end
                                        else
                                            io.put_string("Le realisateur ne peut pas être vide, retour au menu précédent")
                                        end
                                    end 
                                else
                                    io.put_string("Le titre ne peut pas être vide, retour au menu précédent%N")
                                end
                                
                            when 2 then
                                create livre.make_empty_livre
                                io.put_string("Quel titre ?%N")
                                io.read_line
                                titre := io.last_string
                                if not (titre.compare("") = 0) then
                                    livre.set_titre(titre)
                                    io.put_string("Combien d'exemplaire ?%N")
                                    io.read_integer
                                    io.read_line
                                    nb := io.last_integer
                                    if nb < 0 then
                                        io.put_string("Le nombre d'exemplaire doit être supérieur à 0, retour au menu précédent%N")
                                    else
                                        livre.set_nombre(nb)
                                        io.put_string("Quel auteur ?%N")
                                        io.read_line
                                        auteur := io.last_string
                                        if not (auteur.compare("") = 0) then
                                            livre.set_auteur(auteur)
                                            mediatheque.ajouter_media(livre)
                                            io.put_string("Création du livre réussie%N")
                                        else
                                            io.put_string("L'auteur ne peut pas être vide, retour au menu précédent")
                                        end
                                    end 
                                else
                                    io.put_string("Le titre ne peut pas être vide, retour au menu précédent%N")
                                end
          
                            else
                                io.put_string("Choix incorrect, retour au menu précédent%N")
                        end -- inspect
    
                    when 4 then 

                    when 0 then
                        io.put_string("retour vers le menu principal%N")     

                    else
                        io.put_string("Choix incorrect%N")     
                end -- inspect                   
            end --  loop   
        end

    --------------------- MENUS UTILISATEURS ------------------------

    menu_usr is 
        local 
            choix : INTEGER	
            choix_menu : INTEGER
            identifiant : STRING
            user : UTILISATEUR
        do
            choix := 0

            if connect = 2 then 
                from
                until choix = 1 or choix = 2 
                loop
                    io.put_string("Utilisateur ou administrateur ? Merci d'entrer 1 pour utilisateur ou 2 administrateur %N")
                    io.read_integer
                    io.read_line -- FIX read_integer saute le prochain read_line
                    choix := io.last_integer
                end

                io.put_string("Merci de saisir l'identifiant de l'utilisateur à créer / mofifier %N")
                io.read_line
                identifiant := io.last_string


                create user.make_empty_utilisateur     

                if choix = 1 then
                    user.copy(mediatheque.get_user_object(identifiant))
                else 
                    user.copy(mediatheque.get_admin_object(identifiant))
                end 


                if user.get_identifiant.is_equal("notfound") then 

                    io.put_string("Utilisateur "+ identifiant + "n'existe pas %N")
                    io.put_string("Souhaitez vous le créer ?  0 - Non / Quitter | 1 - Oui %N")

                    io.read_integer
                    io.read_line -- FIX read_integer saute le prochain read_line
                    choix := io.last_integer

                    if choix = 1 then 
                        user.modifier_utilisateur_saisie(identifiant) 
                        mediatheque.ajouter_utilisateur(user)
                    else 
                        io.put_string("Utilisateur "+ identifiant + "n'existe pas %N")       
                    end 
                else
                    choix_menu :=1
                    from
                    until choix_menu = 0 
                    loop

                        io.put_string(" ------------- GESTION DES UTILISATEURS -------------%N")
                        io.put_string("| 1 - Mofifier nom                                   |%N")
                        io.put_string("| 2 - Modifier prenom                                |%N")
                        io.put_string("| 3 - Modifier mot de passe                          |%N")
                        io.put_string("| 4 - Supprimer utilisateur                          |%N")
                        io.put_string("| 0 - Retour                                         |%N")         
                        io.put_string(" ----------------------------------------------------%N") 

                        io.put_string("%NEntrez votre choix %N")
                        io.read_integer
                        io.read_line -- FIX read_integer saute le prochain read_line
                        choix_menu := io.last_integer

                        inspect choix_menu 
                            when 1 then
                                io.put_string("%NSaisir le nouveau nom %N")
                                io.read_line
                                user.set_nom(io.last_string)
                                user.afficher

                            when 2 then 
                                io.put_string("%NSaisir le nouveau nom %N") 
                                io.read_line
                                user.set_prenom(io.last_string)
                                user.afficher

                            when 3 then 
                                user.init_motdepasse

                            when 4 then 
                                mediatheque.supprimer_utilisateur(user)
                                choix_menu := 0

                            when 0 then
                                io.put_string("retour vers le menu principal %N")     
   
                            else
                                io.put_string("Choix incorrect %N")     
                        end -- inspect                   

                    end --  loop       
                end
            else 
                io.put_string("| Merci de vous connecter en tant qu'administrateur  |%N")
            end
        end	

    --------------------- MENUS FAIRE EMPRUNT -------------------

    menu_faire_emprunt is
        local
            choix_menu, choix_media, choix_type : INTEGER
            nb_media, i : INTEGER
            media : MEDIA
            recherche, media_lower, type : STRING
            medias : ARRAY[MEDIA]
        do
            io.put_string(" ------------------ FAIRE UN EMPRUNT ----------------%N")
            io.put_string("| 1 - Faire un emprunt par n° de média               |%N")
            io.put_string("| 2 - Faire un emprunt par recherche de titre        |%N")
            io.put_string("| 3 - Faire un emprunt par type                      |%N")
            io.put_string("| 0 - Retour                                         |%N")         
            io.put_string(" ----------------------------------------------------%N")

            io.put_string("%NEntrez votre choix %N")
            io.read_integer
            io.read_line -- FIX read_integer saute le prochain read_line
            choix_menu := io.last_integer

            inspect choix_menu
                when 0 then
                    io.put_string("Retour vers le menu principal%N")  

                when 1 then
                    mediatheque.afficher_medias
                    nb_media := mediatheque.get_nb_medias
                    io.put_string("%NEntrez le n° du média que vous souhaitez emprunter%N")
                    io.read_integer
                    io.read_line -- FIX read_integer saute le prochain read_line
                    choix_media := io.last_integer
                    if (choix_media <= 0 or choix_media > nb_media) then
                        io.put_string("Numéro non valide, retour au menu principal%N")
                    else
                        media := mediatheque.get_medias.item(choix_media-1)
                        if not media.est_empruntable then
                            io.put_string("Le média n'est pas empruntable, retour au menu principal%N")
                        else
                            mediatheque.emprunter_media(utilisateur_connecte, media)
                            io.put_string("Emprunt effectué%N")
                        end
                    end

                when 2 then
                    recherche := ""
                    io.put_string("Merci de saisir une partie du titre du média que vous recherchez %N")
                    io.read_line
                    recherche := io.last_string
                    recherche.to_lower
                    
                    create medias.with_capacity(1,0)
                    from
                        i := 0
                    until
                        i = mediatheque.get_medias.count
                    loop
                        media_lower := mediatheque.get_medias.item(i).get_titre
                        media_lower.to_lower
                        if media_lower.has_substring(recherche) then
                            medias.force(mediatheque.get_medias.item(i), medias.count)
                        end
                        i := i+1
                    end
                    
                    if medias.count = 0 then
                        io.put_string("%NAucun résultat trouvé%N")
                    else 
                        io.put_string("%NRésultat(s) trouvé(s) (" + medias.count.to_string + ") :%N")
                        from 
                            i := 0
                        until
                            i = medias.count
                        loop
                            io.put_string("Média n°" + i.to_string + " : %N")
                            medias.item(i).afficher
                            io.put_string("%N")
                            i := i+1
                        end
                        io.put_string("Quel média voulez vous emprunter ?")
                        io.put_string("%NEntrez le n° du média que vous souhaitez emprunter%N")
                        io.read_integer
                        io.read_line -- FIX read_integer saute le prochain read_line
                        choix_media := io.last_integer
                        
                        if choix_media < 0 or choix_media >= medias.count then
                            io.put_string("Numéro non valide, retour au menu principal%N")
                        else
                            media := medias.item(choix_media)
                            if not media.est_empruntable then
                                io.put_string("Le média n'est pas empruntable, retour au menu principal%N")
                            else
                                mediatheque.emprunter_media(utilisateur_connecte, media)
                                io.put_string("Emprunt effectué%N")
                            end
                        end
                    end 
                    
                when 3 then
                   
                    io.put_string("Que voulez-vous emprunter ? Un DVD (1) ou un Livre (2) ?%N")
                    io.read_integer
                    io.read_line
                    choix_type := io.last_integer
                    if choix_type = 1 or choix_type = 2 then
                        if choix_type = 1 then
                            type := "DVD"
                        else
                            type := "LIVRE"
                        end
                        create medias.with_capacity(1,0)
                        from
                            i := 1
                        until
                            i = mediatheque.get_medias.count
                        loop
                            if (mediatheque.get_medias.item(i).generator.compare(type) = 0) then
                                 medias.force(mediatheque.get_medias.item(i),medias.count)
                            end
                            i := i+1
                        end
                        
                        from 
                            i := 0
                        until
                            i = medias.count
                        loop
                            io.put_string("Média n° " + i.to_string + "%N")
                            medias.item(i).afficher
                            i := i+1
                        end
                        
                        io.put_string("Quel média voulez-vous emprunter ?%N")
                        io.read_integer
                        io.read_line
                        choix_media := io.last_integer
                        
                        if choix_media < 0 or choix_media >= medias.count then
                            io.put_string("Numéro non valide, retour au menu principal%N")
                        else
                            media := medias.item(choix_media)
                            if not media.est_empruntable then
                                io.put_string("Le média n'est pas empruntable, retour au menu principal%N")
                            else
                                mediatheque.emprunter_media(utilisateur_connecte, media)
                                io.put_string("Emprunt effectué%N")
                            end
                        end
                    else
                        io.put_string("Choix inccorect, retour au menu précédent%N")
                    end
                        
                else
                    io.put_string("Choix incorrect %N")  
            end -- inspect
        end

    --------------------- MENUS RENDRE EMPRUNTS -----------------

    menu_rendre_emprunt is
        local
            emprunts : ARRAY[EMPRUNT]
            i, choix_emp: INTEGER 
            emp : EMPRUNT
        do  
            emprunts := mediatheque.get_emprunt_user(utilisateur_connecte)
            if emprunts.count = 0 then
                io.put_string("Vous n'avez pas d'emprunt en cours, retour au menu principal")
            else
                from
                    i := 0
                until
                    i >= emprunts.count
                loop
                    emp := emprunts.item(i)
                    if not emp.est_rendu then
                        io.put_string("Emprunt n°" + i.to_string + "%N")
                        io.put_string("Média : " + emp.get_media.get_titre + "%N")
                        io.put_string("Date emprunt : " + mediatheque.date_string(emp.get_date_debut) + "%N")
                        io.put_string("Date limite rendu : " + mediatheque.date_string(emp.get_date_limite) + "%N")
                        if emp.a_retard then
                            io.put_string("En retard : Oui%N")
                        else
                            io.put_string("En retard : Non%N")
                        end
                        io.put_string("%N")
                    end
                    i := i+1
                end

                -- Rendre
                io.put_string("%NEntrez le numéro de l'emprunt à rendre%N")
                io.read_integer
                io.read_line -- FIX read_integer saute le prochain read_line
                choix_emp := io.last_integer
                if (choix_emp < 0 or choix_emp > emprunts.count) then
                    io.put_string("N° non valide, retour au menu principal%N")
                else
                    emp := emprunts.item(choix_emp)
                    emp.rendre
                    io.put_string("Le média a bien été rendu%N")
                end
            end  
        end

    --------------------- MENUS EMPRUNTS ------------------------

    menu_empr is
        local
            choix_menu, choix_user i : INTEGER 	
            emprunts : ARRAY[EMPRUNT]
            users : ARRAY[UTILISATEUR]
            user : UTILISATEUR
        do
            inspect connect
                when 0 then 
                    io.put_string("| Merci de vous connecter en tant qu'administrateur  |%N")

                when 1 then 
                    io.put_string("| Merci de vous connecter en tant qu'administrateur  |%N")

                when 2 then 
                    io.put_string(" ------------- GESTION DES EMPRUNTS -------------%N")
                    io.put_string("| 1 - Consulter les emprunts par utilisateur         |%N")
                    io.put_string("| 2 - Consulter tous les emprunts                   |%N")
                    io.put_string("| 3 - Consulter tous les emprunts en cours          |%N")
                    io.put_string("| 4 - Consulter tous les emprunts en retard         |%N")
                    io.put_string("| 0 - Retour                                         |%N")

            end -- inpect

            io.put_string(" ----------------------------------------------------%N")	
            io.put_string("%NEntrez votre choix %N")
            io.read_integer
            io.read_line -- FIX read_integer saute le prochain read_line
            choix_menu := io.last_integer
            inspect choix_menu
                when 0 then
                    io.put_string("Retour au menu principal%N")
                    
                when 1 then
                    users := mediatheque.get_users
                    from
                        i := 0
                    until
                        i = users.count
                    loop
                        io.put_string("Utilisateur n°" + i.to_string + "%N")
                        users.item(i).afficher
                        io.put_string("%N")
                        i := i+1
                    end
                    io.put_string("%NEntrez pour quel utilisateur vous voulez consulter les emprunts%N")
                    io.read_integer
                    io.read_line -- FIX read_integer saute le prochain read_line
                    choix_user := io.last_integer
                    if choix_user < 0 or choix_user >= users.count then
                        io.put_string("Numéro non valide, retour au menu principal")
                    else
                        user := users.item(choix_user)
                        emprunts := mediatheque.get_emprunts
                        io.put_string("Résultats pour " + user.get_identifiant + "%N")
                        from
                            i := 0
                        until 
                            i = emprunts.count
                        loop
                            if emprunts.item(i).get_utilisateur = user then
                                emprunts.item(i).afficher
                                io.put_string("%N")
                            end
                            i := i+1
                        end
                    end
                
                when 2 then
                    emprunts := mediatheque.get_emprunts
                    if emprunts.count = 0 then
                        io.put_string("Il n'y a pas d'emprunts%N")
                    else
                        from
                            i := 0
                        until 
                            i = emprunts.count
                        loop
                            emprunts.item(i).afficher
                            io.put_string("%N")
                            i := i+1
                        end
                    end
                
                when 3 then
                    emprunts := mediatheque.get_emprunts
                    io.put_string("Résultat(s) trouvé(s) :%N")
                    from
                        i := 0
                    until 
                        i = emprunts.count
                    loop
                        if not emprunts.item(i).est_rendu then
                            emprunts.item(i).afficher
                            io.put_string("%N")
                        end
                        i := i+1
                    end
                
                when 4 then
                    emprunts := mediatheque.get_emprunts
                    io.put_string("Résultat(s) trouvé(s) :%N")
                    from
                        i := 0
                    until 
                        i = emprunts.count
                    loop
                        if emprunts.item(i).a_retard then
                            emprunts.item(i).afficher
                            io.put_string("%N")
                        end
                        i := i+1
                    end
                
                else
                     io.put_string("Mauvaise saisie, retour au menu principal%N")
                
            end -- inspect
        end

	get_connect : INTEGER is 
	    do 
		    Result := connect
	    end 


	set_connect(co : INTEGER) is 
	    do 
		    connect := co
	    end 

	set_nom_utilisateur(nom : STRING) is 
	    do 
		    prenom.copy(nom) 
	    end 

    ------------------------------- GESTION DES CONNECTIONS --------------------------------

    se_connecter_user:INTEGER is
        local 
            user : UTILISATEUR
            res : INTEGER
            identifiant : STRING 
            motdepasse_saisie : STRING  
        do
            res :=0 
            identifiant := ""
            motdepasse_saisie := ""
            create user.make_empty_utilisateur

            io.put_string("Merci de saisir votre identifiant %N")
            io.read_line
            identifiant := io.last_string

            user.copy(mediatheque.get_user_object(identifiant))

            if user.get_identifiant.is_equal("notfound") then 
                io.put_string("Utilisateur inconnu %N")
            else 
                io.put_string("Merci de saisir votre mot de passe %N")
                io.read_line
                motdepasse_saisie := io.last_string

                if motdepasse_saisie.is_equal(user.get_motdepasse) then 
                    io.put_string("Vous êtes connecté, bienvenue "+ user.get_prenom +"%N")
        
                    res:=1
                    utilisateur_connecte := user

                    if motdepasse_saisie.is_equal(user.get_identifiant) then 
                        io.put_string("Première connection ? Pour des raisons de sécurité merci de changer votre mot de passe %N")
                        user.init_motdepasse

                    else 

                    end 

                else  
                    io.put_string("Erreur, mot de passe incorrect !")
                end
            end 

            Result := res
        end 

    se_connecter_admin:INTEGER is
        local 
            user : ADMINISTRATEUR
            res : INTEGER
            identifiant : STRING 
            motdepasse_saisie : STRING  
        do
            res :=0 
            identifiant := ""
            motdepasse_saisie := ""
            create user.make_empty_admin

            io.put_string("Merci de saisir votre identifiant %N")
            io.read_line
            identifiant := io.last_string

            user.copy(mediatheque.get_admin_object(identifiant))

            if user.get_identifiant.is_equal("notfound") then 
                io.put_string("Utilisateur inconnu %N")
            else 
                io.put_string("Merci de saisir votre mot de passe %N")
                io.read_line
                motdepasse_saisie := io.last_string

                if motdepasse_saisie.is_equal(user.get_motdepasse) then 
                    io.put_string("Vous êtes connecté, bienvenue "+ user.get_prenom +"%N")
                    res:=2
                    utilisateur_connecte := user

                    if motdepasse_saisie.is_equal(user.get_identifiant) then 
                        io.put_string("Première connection ? Pour des raisons de sécurité merci de changer votre mot de passe %N")
                        user.init_motdepasse
                    else 

                    end 

                else  
                    io.put_string("Erreur, mot de passe incorrect !")
                end
            end 

            Result := res
        end 

end -- class INTERFACE
