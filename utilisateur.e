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
            --- DO TO suppr après test ----
            io.put_string("Mdp : " + motdepasse + "%N") 
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
