class UTILISATEUR
-- Represente un utilisateur
	
creation {ANY}
    make_utilisateur

feature {}
	nom: STRING
    prenom: STRING
    identifiant: STRING 	
    max_emprunt: INTEGER

feature {}
	
    make_utilisateur(nomp: STRING; prenomp: STRING; identifiantp: STRING) is
        do
            nom := ""
			nom.copy(titrep)
			
			prenom := ""
			prenom.copy(prenomp)

			identifiant := ""
			identifiant.copy(identifiantp) 

            max_emprunt := 5
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

    afficher is
		do
			io.put_string("----------- UTILISATEUR -----------%N")
			io.put_string("Nom : " + nom + "%N")
			io.put_string("Prenom :" + prenom + "%N")
			io.put_string("Identifiant : " + identifiant + "%N") 
        end

end -- class UTILISATEUR
