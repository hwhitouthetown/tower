class MEDIATHEQUE
-- Rappel GIT
-- git clone link
-- git pull
-- git add * 
-- git commit
-- git push
	
creation {ANY}
    make

feature {}

    nb_media : INTEGER
    nb_client : INTEGER
    interface : INTERFACE
    liste_medias : ARRAY[MEDIA]
    liste_emprunts : ARRAY[EMPRUNT]
    liste_utilisateurs : ARRAY[UTILISATEUR]
    nb_emprunts_max : INTEGER 
    duree_emprunt_media : INTEGER 
    choix : INTEGER
    
    -- Méthode pour parser une ligne en fonction de son type (utilisateurs ou médias)
    parsing_line(line : STRING; type : STRING) is
        local
            i : INTEGER
            type_courant : STRING -- mémorise le type de l utilisateur ou celui du média courant -- 
            dictionnaire : ARRAY[STRING]
            m : MEDIA
            u : UTILISATEUR
           
        do

            type_courant :=""

            ------------ TRAITEMENT ----------------

            create dictionnaire.make(1,1)
            -- On sépare chaque donnée par des espace (et on remplace les espaces par 
            -- un autre charactère pour les sauvegarder, ici '*')
            line.replace_all(' ', '*')
            line.replace_all(';',' ')
            line.replace_all('<',' ')
            line.replace_all('>',' ')
          
            -- Tableau contient les clefs - valeurs de la ligne
            dictionnaire.copy(line.split)

            -- Boucle pour avoir le tableau final avec que le type + les couples clefs/valeur
            from 
                i := 1
            until
                i > dictionnaire.count
            loop
                 -- On remet les espaces dans les valeurs
                dictionnaire.item(i).replace_all('*',' ')
                dictionnaire.item(i).left_adjust
                dictionnaire.item(i).right_adjust
                if (dictionnaire.item(i).count = 0) then
              	    -- On supprime l élément vide du tableau
                    dictionnaire.remove(i)
                else
                    i := i+1
                end
            end


            ------------ CONVERSION EN OBJET ----------------


            inspect type 
                when "medias" then 

                    m := parsing_media(dictionnaire)
                    ajouter_media(m)

                when "utilisateurs" then 
                  
                    u:=parsing_user(dictionnaire)
                    ajouter_utilisateur(u)
              
                else 
                    io.put_string("Type de fichier inconnu conversion impossible")     

            end 
    

        end



    -- Fonction qui permet de transformer la chaine de caractère venant du parser line en objet de type "UTILISATEUR"    
    parsing_user(dictionnaire : ARRAY[STRING]): UTILISATEUR  is 
        local 

            i : INTEGER 
            cle : STRING
            flag_admin : BOOLEAN
            valeur : STRING
            user : UTILISATEUR 
            admin : ADMINISTRATEUR

        do 
                flag_admin := False
                dictionnaire.item(1).right_adjust  
                        
                create user.make_empty_utilisateur
                from
                i := 1 
                until i > dictionnaire.count
                loop
                    cle := ""
                    valeur := ""
                    cle.copy(dictionnaire.item(i))
                    valeur.copy(dictionnaire.item(i+1))

                    -- On verifie la cle  
                    inspect cle 

                        when "Nom" then 
                            user.set_nom(valeur)
                        when "Prenom" then
                            user.set_prenom(valeur)
                        when "Identifiant" then
                            user.set_identifiant(valeur)
                        when "Admin" then 
                            create admin.make_admin_from_user(user)
                            flag_admin := True 
                        else 
                            io.put_string("Erreur la clé : " + cle +  "est inconnue, vérifier votre fichier d'entré %N");  
                        end    
                    i := i+2
                end 

            if(flag_admin) then 
                admin.set_motdepasse(admin.get_identifiant)
                Result := admin 
            else 
                user.set_motdepasse(user.get_identifiant)
                Result := user    
            end    


        end    


    -- Fonction qui permet de transformer la chaine de caractère venant du parser line en objet de type "MEDIA"    
    parsing_media(dictionnaire : ARRAY[STRING]):MEDIA  is 
        local 
            i : INTEGER 
            cle : STRING
            valeur : STRING
            livre : LIVRE 
            dvd : DVD
        do 
                
                dictionnaire.item(1).right_adjust   
    
                inspect dictionnaire.item(1)

                    when "Livre" then
                        i := 2                         
                        create livre.make_empty_livre
                        from
                        until i > dictionnaire.count
                        loop
                            cle := ""
                            valeur := ""
                            cle.copy(dictionnaire.item(i))
                            valeur.copy(dictionnaire.item(i+1))

                            -- On verifie la cle  
                            inspect cle 

                                when "Titre" then 
                                 livre.set_titre(valeur)
                                when "Auteur" then
                                 livre.set_auteur(valeur)
                                when "Nombre" then
                                 livre.set_nombre(valeur.to_integer)
                                else 
                                 io.put_string("Erreur la clé : " + cle +  "est inconnue, vérifier votre fichier d'entré%N");  
                            end    
                            i := i+2
                        end 

                        if(livre.get_nombre=0) then 
                            livre.set_nombre(1)
                        end

                        Result := livre

                    
                    when "DVD" then
                        i := 2                       
                        create dvd.make_empty_dvd
                        from
                        until i > dictionnaire.count
                        loop
                            cle := ""
                            valeur := ""
                            cle.copy(dictionnaire.item(i))
                            valeur.copy(dictionnaire.item(i+1))

                            -- On verifie la cle  
                            inspect cle 

                                when "Titre" then 
                                    dvd.set_titre(valeur)
                                when "Annee" then
                                    dvd.set_annee(valeur.to_integer)
                                when "Realisateur" then
                                    dvd.set_realisateur(valeur)
                                when "Acteur" then
                                    dvd.ajouter_acteur(valeur)
                                when "Type" then
                                    dvd.set_type(valeur) 
                                when "Nombre" then

                                else 
                                 io.put_string("Erreur la clé : " + cle +  "est inconnue, vérifier votre fichier d'entré %N");  
                            end    
                            i := i+2
                        end 

                        if(dvd.get_nombre=0) then 
                            dvd.set_nombre(1)
                        end

                        Result := dvd
            end                  
        end


    -- Méthode pour parser un fichier en fonction de son type (utilisateurs ou médias)
    parsing_file(file : STRING; type : STRING) is
        local
            text_reader : TEXT_FILE_READ
            readable : BOOLEAN
        do
            create text_reader.connect_to(file)
            if (text_reader.is_connected) then
                from
                    readable := not text_reader.end_of_input
                 until
                    not readable
                loop
                    text_reader.read_line
                    if (text_reader.last_string.count > 0) then -- Si différent de la fin de ligne
                        parsing_line(text_reader.last_string, type)
                        io.put_string("%N")
                    end
                    readable := not text_reader.end_of_input
                end
            else
                io.put_string("Echec du parsing : Accès au fichier '")
                io.put_string(file)
                io.put_string("' : KO %N")
        end
        text_reader.disconnect  	  
    end
		
	-- Méthode pour avoir une date en chaine de cararctères
	date_string(date: TIME) : STRING is
	    do
	        Result := date.day.to_string + "/" + date.month.to_string + "/" + date.year.to_string
	    end

feature {ANY}

    test_emprunt is 
        do
            io.put_string("NB medias : " + liste_medias.count.to_string + "%N")
            io.put_string("NB utilisateurs : " + liste_utilisateurs.count.to_string + "%N")
            io.put_string("NB emprunts : " + liste_emprunts.count.to_string + "%N")
            emprunter_media(liste_utilisateurs@1, liste_medias@1)
            io.put_string("NB emprunts : " + liste_emprunts.count.to_string + "%N")
        end

    make is
        do  
            choix := 1
            nb_emprunts_max := 5 -- 5 emprunts max / utilisateur
            duree_emprunt_media := 30 -- 30 jours  
			create liste_medias.with_capacity(1,0)
			create liste_utilisateurs.with_capacity(1,0)
			create liste_emprunts.with_capacity(1,0)
            io.put_string("Bienvenue dans la mediatheque du futur !")
            parsing_file("utilisateurs.txt", "utilisateurs")
            parsing_file("medias.txt", "medias")

            
            io.put_string("-------- UTILISATEURS ENREGISTRE ---------%N%N")
            afficher_utilisateurs


            io.put_string("-------- MEDIAS ENREGISTRE ---------%N%N")
            afficher_medias  

            create interface.make

              from
            until choix = 0 
            loop

                interface.afficher_menu

                io.read_integer
                io.read_line -- FIX read_integer saute le prochain read_line
                choix := io.last_integer
        
                inspect choix
                when 1 then
                  io.put_string("Médias %N")
              when 2 then
                    if(interface.get_connect = 0) then
                       interface.set_connect(se_connecter)
                    else 
                        io.put_string("Se déconnecter %N")
                    end -- endif
                when 0 then
                    --quitter le programme
                    io.put_string("Vous quittez le programme %N")
                else
                    io.put_string("Choix incorrect %N")
                end -- inspect

            end -- loop 



            -- Test des emprunts
            io.put_string("-------- DEBUT DU TEST ---------%N%N")
            test_emprunt

            io.put_string("Fin du programme !%N")
        end


    ------ Emprunts --------
	emprunter_media(utilisateur: UTILISATEUR; media: MEDIA;) is
		local
            emp : EMPRUNT
            date_limite, test : TIME
		do
			if media.est_empruntable then
				if peut_emprunter(utilisateur) then
				    -- utilisateurp: UTILISATEUR; mediap: MEDIA; TIME: date_limitep
					date_limite.update
					date_limite.add_day(duree_emprunt_media)
					create emp.make_emprunt(utilisateur, media, date_limite)
					ajouter_emprunt(emp)
					io.put_string("Création de l'emprunt OK%N")
					-- Test date
					test.update
					io.put_string("Fait le " + date_string(test) + " --> rendu max le " + date_string(date_limite) + "%N")
				else
					io.put_string("Création de l'emprunt KO : l'utilisateur ne peut pas emprunter%N")
				end		
			else
				io.put_string("Création de l'emprunt KO : le média n'est pas empruntable%N")
			end
		end

    ------ Medias --------
    ajouter_media(media : MEDIA) is 
        do
            liste_medias.force(media,liste_medias.count)
        end

    afficher_medias is 
    local
            i: INTEGER
        do  
        

            if(liste_medias.is_empty) then 
                io.put_string("aucun media%N")
            else 
                from
                   i := 0
                until
                   i = liste_medias.count
                loop
                    io.put_string("%N")
                    liste_medias.item(i).afficher
                    io.put_string("%N")
                    i := i+1
                end
            end
        end           
	

    ------ UTILISATEUR -------

       utilisateur_exists(identifiant : STRING): BOOLEAN is 
    local
        user:UTILISATEUR
    do
        create user.make_empty_utilisateur
        user.set_identifiant(identifiant)

        Result := liste_utilisateurs.has(user)
    end 


    se_connecter:INTEGER is
    local 
        res : INTEGER
        exist : BOOLEAN
        identifiant : STRING 
        motdepasse : STRING  
    do
        res :=0 
        identifiant := ""
        motdepasse := ""

        io.put_string("Merci de saisir votre identifiant %N")
        io.read_line
        identifiant := io.last_string

        exist := utilisateur_exists(identifiant)

        if exist then 
            io.put_string("Merci de saisir votre mot de passe %N")
            io.read_line

            motdepasse := io.last_string

        else 
             io.put_string("Utilisateur inconnu %N")
        end 

        Result := res
    end 



    ajouter_utilisateur(user : UTILISATEUR) is 
        do
            liste_utilisateurs.force(user,liste_utilisateurs.count)
        end
        
    afficher_utilisateurs is 
    local
            i: INTEGER
        do  

            if(liste_utilisateurs.is_empty) then 
                io.put_string("aucun media%N")
            else 
                from
                   i := 0
                until
                   i = liste_utilisateurs.count
                loop
                    io.put_string("%N")
                    liste_utilisateurs.item(i).afficher
                    io.put_string("%N")
                    i := i+1
                end
            end
        end  
        
    --- FIN UTILISATEURS --        

    ajouter_emprunt(emprunt : EMPRUNT) is 
        do
            liste_emprunts.force(emprunt, liste_emprunts.count)
        end         
        	  	
    -- Méthode pour savoir si un utilisateur peut emprunter un media
    peut_emprunter(u : UTILISATEUR) : BOOLEAN is
        do
            if u.get_nb_emprunt >= nb_emprunts_max then
                Result := False
            else
                Result := True
            end
        end

end -- class MEDIATHEQUE
