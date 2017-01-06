class MEDIATHEQUE
-- Rappel GIT
-- git clone link
-- git pull
-- git add * 
-- git commit
-- git push
-- Suppresion des fichiers temporaires : rm *\~*
-- Quitter et save VIM : Echap -> x! -> Entrée
	
creation {ANY}
    make_mediatheque

feature {}

    nb_media : INTEGER
    nb_client : INTEGER
    interface : INTERFACE
    liste_medias : ARRAY[MEDIA]
    liste_emprunts : ARRAY[EMPRUNT]
    liste_utilisateurs : ARRAY[UTILISATEUR]
    nb_emprunts_max : INTEGER 
    duree_emprunt_media : INTEGER 
    choix_general : INTEGER
    choix_user : INTEGER
    choix_media : INTEGER 
    choix_emprunt : INTEGER
    
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
                        user.set_motdepasse(valeur)

                    when "Admin" then 
                        create admin.make_admin_from_user(user)
                        flag_admin := True 

                    else 
                        io.put_string("Erreur la clé : " + cle +  "est inconnue, vérifier votre fichier d'entré %N");  
                    end    
                i := i+2
            end 

            if(flag_admin) then 
                Result := admin 
            else 
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
    

feature {ANY}

    -- Méthode pour avoir une date en chaine de cararctères
    date_string(date: TIME) : STRING is
        do
            Result := date.day.to_string + "/" + date.month.to_string + "/" + date.year.to_string
        end

    make_mediatheque is
        do  
            choix_general := 1
            choix_user := 1 
            choix_media := 1 
            choix_emprunt := 1
            nb_emprunts_max := 5 -- 5 emprunts max / utilisateur

            duree_emprunt_media := 30 -- 30 jours  
            create liste_medias.with_capacity(1,0)
            create liste_utilisateurs.with_capacity(1,0)
            create liste_emprunts.with_capacity(1,0)
            parsing_file("utilisateurs.txt", "utilisateurs")
            parsing_file("medias.txt", "medias")

            io.put_string("Importation des données réussie%N")
            io.put_string("NB medias : " + liste_medias.count.to_string + "%N")
            io.put_string("NB utilisateurs : " + liste_utilisateurs.count.to_string + "%N")
            io.put_string("NB emprunts : " + liste_emprunts.count.to_string + "%N")
           
        end

    get_nb_medias : INTEGER is
        do
            Result := liste_medias.count
        end

    get_medias : ARRAY[MEDIA] is
        do
            Result := liste_medias
        end
        
    get_users : ARRAY[UTILISATEUR] is
        do
            Result := liste_utilisateurs
        end
        
    get_emprunts : ARRAY[EMPRUNT] is
        do
            Result := liste_emprunts
        end

    get_emprunt_user(user : UTILISATEUR) : ARRAY[EMPRUNT] is
        local
            tab : ARRAY[EMPRUNT]
            i : INTEGER
            emp : EMPRUNT
        do
            create tab.with_capacity(1,0)
            from 
                i := 0
            until 
                i = liste_emprunts.count             
            loop
                emp := liste_emprunts@i
                if emp.get_utilisateur.is_equal(user) then
                    tab.force(emp,tab.count)
                end
                i := i + 1
            end
            Result := tab
        end

    ------ Emprunts --------
    emprunter_media(utilisateur: UTILISATEUR; media: MEDIA) is
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
            
            ensure 
                liste_medias.count = old liste_medias.count + 1
        end

    afficher_medias is 
        local
            i : INTEGER
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
                    io.put_string("Media n°" + i.to_string + "%N")
                    liste_medias.item(i).afficher
                    io.put_string("%N")
                    i := i+1
                end
            end
        end           
	

    --------- UTILISATEUR -----------

    -- Retourne l'objet utilisateur correspondant si pas utilisateur retourne nu utilisateur avec  l'id "notfound"
    get_user_object(identifiant : STRING): UTILISATEUR is 
        local
            user:UTILISATEUR
            position:INTEGER
        do
            create user.make_empty_utilisateur
            user.set_identifiant(identifiant)

            position := liste_utilisateurs.index_of(user,0)

            if position = liste_utilisateurs.upper + 1 then 
                user.set_identifiant("notfound")
            else 
                user.copy(liste_utilisateurs.item(position))
            end
            Result := user
        end 

    get_admin_object(identifiant : STRING): ADMINISTRATEUR is 
        local
            user : UTILISATEUR
            admin:ADMINISTRATEUR
            position:INTEGER
        do
            create user.make_empty_utilisateur
            create admin.make_empty_admin

            admin.set_identifiant(identifiant)

            position := liste_utilisateurs.index_of(admin,0)

            if position = liste_utilisateurs.upper + 1 then 
                admin.set_identifiant("notfound")
            else 
                user := (liste_utilisateurs.item(position))
                user.afficher
                admin.set_prenom(user.get_prenom)
                admin.set_nom(user.get_nom)    
                admin.set_motdepasse(user.get_motdepasse)
                admin.afficher
            end

            Result := admin
        end 

    ajouter_utilisateur(user : UTILISATEUR) is 
        do
            liste_utilisateurs.force(user,liste_utilisateurs.count)
        end

    modifier_utilisateur(user : UTILISATEUR) is 
        local 
            position : INTEGER
        do 
            position := liste_utilisateurs.index_of(user,0)
            if position = liste_utilisateurs.upper + 1 then 
                io.put_string("Modification impossible utilisateur non trouvé %N")
            else 
                liste_utilisateurs.remove(position)
            end

            liste_utilisateurs.force(user, liste_utilisateurs.count)

        end 

        
    afficher_utilisateurs is 
        local
            i: INTEGER
        do  
            if(liste_utilisateurs.is_empty) then 
                io.put_string("aucun utilisateur %N")
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
        
    supprimer_utilisateur(user : UTILISATEUR) is
        local
            position : INTEGER
        do
            position := liste_utilisateurs.index_of(user,0)
            if position = liste_utilisateurs.upper + 1 then 
                io.put_string("Utilisateur non trouvé %N")
            else 
                liste_utilisateurs.remove(position)
                io.put_string("Utilisateur supprimé %N")
            end
        end
              
    --- FIN UTILISATEURS --        

    ajouter_emprunt(emprunt : EMPRUNT) is 
        do
            liste_emprunts.force(emprunt, liste_emprunts.count)
            io.put_string("Utilisateur ajouté  %N")
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
        
    -- CRUD Media
    
    supprimer_media(media : MEDIA) is
        local
            i, j : INTEGER
        do
            from 
                i := 0
            until
                i = liste_medias.count
            loop
                if liste_medias@i = media then
                    liste_medias.remove(i)
                    -- Suppression des emprunts liés à ce média
                    from 
                        j := 0
                    until
                        j = liste_emprunts.count
                        
                    loop
                        if liste_emprunts.item(j).get_media = media then
                            liste_emprunts.remove(j)
                        else
                            j := j+1
                        end
                    end
                else     
                    i := i + 1 
                end
            end
        end

end -- class MEDIATHEQUE
