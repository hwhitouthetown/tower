class EMPRUNT
-- Represente un emprunt
	
creation {ANY}
    make_emprunt

feature {}
    utilisateur: UTILISATEUR 
    media : MEDIA
    date_debut : TIME -- Date de l'emprunts
    date_rendu : TIME -- Date à laquelle l'emprunt est rendu
    date_limite : TIME -- Date maximale de rendu, l'emprunt est en retard à partir de celle-ci

feature {ANY}

    make_emprunt (utilisateurp: UTILISATEUR; mediap: MEDIA; date_limitep: TIME) is
        local
            time : TIME		
        do
            time.update
            utilisateur := utilisateurp
            media := mediap
            date_debut := time
            date_limite := date_limitep
            date_rendu := date_debut -- Si égales, c'est que l'emprunt n'a pas été rendu
        end	

    -- Getters

    get_utilisateur : UTILISATEUR is
        do
            Result := utilisateur
        end

    get_media : MEDIA is
        do
            Result := media 
        end

    get_date_debut : TIME is
        do
            Result := date_debut
        end
        
    get_date_limite : TIME is
        do
            Result := date_limite
        end
        
    get_date_rendu : TIME is
        do
            Result := date_rendu
        end

    -- Setters

    set_utilisateur(utilisateurp: UTILISATEUR) is
        do
            utilisateur := utilisateurp
        end

    set_media(mediap: MEDIA) is
        do
            media := mediap
        end

    set_date_debut(date_debutp: TIME) is
        do
            date_debut := date_debutp
        end

    set_date_limite(date_limitep: TIME) is
        require
            date_posterieure : date_debut < date_limitep
        do 
            date_limite := date_limitep
        end
        
    set_date_rendu(date_rendup: TIME) is
        do
            date_rendu := date_rendup
        end
        
    -- Méthode pour savoir si un emprunt est en retard
    a_retard : BOOLEAN is
        local
            current_time : TIME	
        do
            current_time.update
            if current_time >= date_limite then
                Result := True
            else
                Result := False
            end
        end
        
    -- Méthode pour savoir si un emprunt a été retourné
    est_rendu : BOOLEAN is
        do
            if date_rendu = date_debut  then
                Result := False
            else
                Result := True
            end
        end

    rendre is
        local
            time : TIME
        do  
            time.update
            date_rendu := time
            media.set_nombre(media.get_nombre + 1)
            
            ensure
                media.get_nombre = old media.get_nombre + 1
                not (old date_rendu = date_rendu) 
            
        end
        
     -- Méthode pour avoir une date en chaine de cararctères
    date_string(date: TIME) : STRING is
        do
            Result := date.day.to_string + "/" + date.month.to_string + "/" + date.year.to_string
        end
        
    afficher is 
        do
            io.put_string("--- EMPRUNT ---%N")
            io.put_string("Media : " + media.get_titre + "%N")
            io.put_string("Utilisateur : " + utilisateur.get_identifiant + "%N")
            io.put_string("Date emprunt : " + date_string(date_debut) + "%N")
            io.put_string("Date limite rendu : " + date_string(date_limite) + "%N")
            if a_retard then
                io.put_string("En retard : Oui%N")
            else
                io.put_string("En retard : Non%N")
            end
        end

end -- class EMPRUNT
