class INTERFACE
-- Represente une 	
creation {ANY}
	make

feature {}
	connect: INTEGER -- entier 0 non connecté -- 1 connecte user -- 2 connect admin
	prenom : STRING
        mediatheque : MEDIATHEQUE


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

                    when 2 then 
                        io.put_string("| 2 - Se déconnecter                  |%N")
                        io.put_string("| 4 - Gérer les utilisateurs          |%N")
                        io.put_string("| 5 - Gérer les emprunts              |%N")
                        io.put_string("| 6 - Gérer les médias                |%N")
                end -- isnpect          

                io.put_string("| 0 - Quitter                         |%N")
                io.put_string(" -------------------------------------%N")

                io.put_string("%NEntrez votre choix %N")

                io.read_integer
                io.read_line -- FIX read_integer saute le prochain read_line
                choix := io.last_integer

                inspect choix
                    when 1 then
                        io.put_string("Médias %N")

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
                            connect:= 0
                        end -- endif    

                    when 4 then 
                        menu_usr

                    when 5 then 
                        menu_medias
           
                    when 0 then
                        --quitter le programme
                        io.put_string("Vous quittez le programme %N")

                    else
                        io.put_string("Choix incorrect %N")
                end -- inspect
            end -- loop 
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

	--------------------- MENUS EMPRUNTS ------------------------

    menu_empr is 	
        do
            inspect connect
            when 0 then 
                io.put_string("| Merci de vous connecter en tant qu'administrateur  |%N")

            when 1 then 
                io.put_string("| Merci de vous connecter en tant qu'administrateur  |%N")

            when 2 then 
                io.put_string(" ------------- GESTION DES EMPRUNTS -------------%N")
                io.put_string("| 1 - Consulter les emprunts par utilisateur         |%N")
                io.put_string("| 2 - Consulter touts les emprunts                   |%N")
                io.put_string("| 3 - Consulter touts les emprunts en cours          |%N")
                io.put_string("| 4 - Consulter touts les emprunts en retard         |%N")
                io.put_string("| 0 - Retour                                         |%N")

            end -- inpect

            io.put_string(" ----------------------------------------------------%N")	
            io.put_string("%NEntrez votre choix %N")
        end	

	--------------------- MENUS MEDIAS ------------------------

    menu_medias is 	
        do
            inspect connect
                when 0 then 
                    io.put_string("| Merci de vous connecter en tant qu'administrateur  |%N")

                when 1 then 
                    io.put_string("| Merci de vous connecter en tant qu'administrateur  |%N")

                when 2 then 
                    io.put_string(" ------------- GESTION DES MEDIAS -------------%N")
                    io.put_string("| 1 - Consulter les médias					        |%N")
                    io.put_string("| 2 - Consulter les médias par type                  |%N")
                    io.put_string("| 3 - Rechercher un média par nom                    |%N")
            end -- inpect

            io.put_string("| 0 - Retour                                         |%N")
            io.put_string(" ----------------------------------------------------%N")	
            io.put_string("%NEntrez votre choix %N")
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
