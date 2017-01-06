class ADMINISTRATEUR inherit
    UTILISATEUR  
        redefine afficher,is_equal,infix "<" 
        end		
	
creation {ANY}
    make_admin,
    make_admin_from_user,
    make_empty_admin
 
feature {}
	auteur : STRING

feature {ANY}

    make_admin(nomp: STRING; prenomp: STRING; identifiantp: STRING) is
        do
            make_utilisateur(nomp, prenomp, identifiantp)
            motdepasse := "admin"
        end

    make_empty_admin is
        do
            nom := ""
            prenom := ""
            identifiant := ""
            motdepasse := ""
            nb_emprunt := 0
        end


    make_admin_from_user(u:UTILISATEUR) is 
        do
            make_admin(u.get_nom,u.get_prenom,u.get_identifiant)
            motdepasse.copy(u.get_motdepasse)
        end


    afficher is
        do
            io.put_string("----------- ADMINISTRATEUR -----------%N")
            io.put_string("Nom : " + nom + "%N")
            io.put_string("Prenom :" + prenom + "%N")
            io.put_string("Identifiant : " + identifiant + "%N") 
        end

     is_equal(other : ADMINISTRATEUR) : BOOLEAN is
        do
            Result := identifiant.is_equal(other.get_identifiant)
        end

    infix "<" (other: ADMINISTRATEUR) : BOOLEAN is
        do  
            Result := identifiant < other.get_identifiant
        end     

end -- class ADMINISTRATEUR
