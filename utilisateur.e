class UTILISATEUR inherit     
    COMPARABLE 
        redefine is_equal 
    end

creation {ANY}
    make_utilisateur,
    make_empty_utilisateur

feature {}
	nom: STRING
    prenom: STRING
    identifiant: STRING
    motdepasse : STRING
    nb_emprunt : INTEGER


feature {ANY}

	
    make_utilisateur(nomp: STRING; prenomp: STRING; identifiantp: STRING) is
        do
            nom := ""
			nom.copy(nomp)
			
			prenom := ""
			prenom.copy(prenomp)

			identifiant := ""
			identifiant.copy(identifiantp)

            motdepasse := ""
            motdepasse.copy(identifiantp)
            
            nb_emprunt := 0
        end

    make_empty_utilisateur is
        do
            nom := ""
            prenom := ""
            identifiant := ""
            motdepasse := ""
            nb_emprunt := 0
        end


    init_motdepasse is 
    local 
        motdepasse_saisie: STRING 
        motdepasse_resaisie: STRING
    do

        
        from
            motdepasse_saisie := "motdepasse_saisie"
            motdepasse_resaisie := "motdepasse_resaisie"
        until
            motdepasse_saisie.is_equal(motdepasse_resaisie)
        loop

            io.put_string("Merci de saisir votre nouveau mot de passe %N")
            io.read_line
            motdepasse_saisie.copy(io.last_string)

            io.put_string("Merci de confirmer votre nouveau mot de passe %N")
            io.read_line
            motdepasse_resaisie.copy(io.last_string)

            if motdepasse_saisie.is_equal(motdepasse_resaisie) then 
                io.put_string("Votre mot de passe à bien été modifié %N")
                motdepasse.copy(motdepasse_resaisie)
            else 
                io.put_string("Erreur les mots de passe saisie sont différents %N")
            end    
            
        end 



    end    




    modifier_motdepasse: INTEGER is
    local
        motdepasse_saisie : STRING  
        res : INTEGER
    do
       
        motdepasse_saisie := ""

        io.put_string("Merci de saisir votre mot de passe actuel %N")
        io.read_line
        motdepasse_saisie := io.last_string

        if motdepasse_saisie.is_equal(motdepasse) then 
            init_motdepasse
            res := 0
        else
            io.put_string("Mot de passe incorrect vous allez être déconnecté %N")
            res := -1
        end

        Result := res

    end 



    -- Getters

    get_nom : STRING is
        do
            Result := nom
        end

    get_prenom : STRING is
        do
            Result := prenom
        end

    get_identifiant : STRING is
        do
            Result := identifiant
        end
        
    get_nb_emprunt : INTEGER is
        do
            Result := nb_emprunt
        end

    get_motdepasse : STRING is 
        do 
            Result := motdepasse
        end    

    -- Setters

    set_nom(nomp: STRING) is
        do
            nom.copy(nomp)
        end

    set_prenom(prenomp: STRING) is
        do
            prenom.copy(prenomp)
        end

    set_identifiant(identifiantp: STRING) is
        do
            identifiant.copy(identifiantp)
        end
        
    set_nb_emprunt(nb_empruntp : INTEGER) is
        do
            nb_emprunt := nb_empruntp
        end


    set_motdepasse(modepassep: STRING) is
        do
            motdepasse.copy(modepassep)
        end
    

    afficher is
		do
			io.put_string("----------- UTILISATEUR -----------%N")
			io.put_string("Nom : " + nom + "%N")
			io.put_string("Prenom :" + prenom + "%N")
			io.put_string("Identifiant : " + identifiant + "%N") 
        end

	peut_emprunter : BOOLEAN is
		do
			-- A implémenter
		end


    is_equal(other : UTILISATEUR) : BOOLEAN is
        do
            Result := identifiant.is_equal(other.get_identifiant)
        end

    infix "<" (other: UTILISATEUR) : BOOLEAN is
        do  
            Result := identifiant < other.get_identifiant
        end    

end -- class UTILISATEUR
