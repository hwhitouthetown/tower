class ADMINISTRATEUR inherit
	UTILISATEUR
	redefine
			afficher
	end		
	
creation {ANY}
	make_admin,
	make_admin_from_user
 
feature {}
	auteur : STRING

feature {ANY}

	make_admin(nomp: STRING; prenomp: STRING; identifiantp: STRING) is
		do
			make_utilisateur(nomp, prenomp, identifiantp)
			motdepasse := "admin"
		end

	make_admin_from_user(u:UTILISATEUR) is 
		do
			make_admin(u.get_nom,u.get_prenom,u.get_identifiant)
			motdepasse := "admin"
		end


	afficher is
		do
			io.put_string("----------- ADMINISTRATEUR -----------%N")
			io.put_string("Nom : " + nom + "%N")
			io.put_string("Prenom :" + prenom + "%N")
			io.put_string("Identifiant : " + identifiant + "%N") 
        end

end -- class LIVRE
