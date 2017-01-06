class TESTUTILISATEUR 

creation {ANY}
    make


feature {ANY}

	
    make is
        do
            cas_make
            cas_mdp
            cas_equal_ok
            cas_equal_ko
        end


cas_make is
local
    u : UTILISATEUR
    status : BOOLEAN
do
    status := False

    create u.make_utilisateur("nom", "prenom", "identifiant")
    status := u.get_identifiant.is_equal("identifiant") and u.get_prenom.is_equal("prenom") and u.get_nom.is_equal("nom") and u.get_nb_emprunt = 0 and u.get_motdepasse.is_equal("identifiant")
    
    if status = True then
        io.put_string("Cas make : OK%N")
    else
        io.put_string("Cas make : KO%N")
    end
end



cas_mdp is 
local 
    u : UTILISATEUR 
    mdp_before : STRING
do 
    create u.make_utilisateur("nom", "prenom", "identifiant")
    mdp_before := ""
    mdp_before.copy(u.get_motdepasse)
    u.init_motdepasse

    if u.get_motdepasse.is_equal(mdp_before) then
       io.put_string("Cas modifier motdepasse : KO%N")
    else 
       io.put_string("Cas modifier motdepasse : OK%N")
    end 
    
end



cas_equal_ok is 
local 
    u1 : UTILISATEUR
    u2 : UTILISATEUR  
    
do 
    create u1.make_utilisateur("nom", "prenom", "identifiant")
    create u2.make_utilisateur("nom1", "prenom2", "identifiant")

    if u1.is_equal(u2) then 
        io.put_string("Cas is_equal_ok : OK%N")
    else 
        io.put_string("Cas is_equal_ok : KO%N")
    end  
end


cas_equal_ko is 
local 
    u1 : UTILISATEUR
    u2 : UTILISATEUR  
    
do 
    create u1.make_utilisateur("nom", "prenom", "identifiant")
    create u2.make_utilisateur("nom1", "prenom2", "identifiant2")

    if u1.is_equal(u2) then 
        io.put_string("Cas is_equal_ko : KO%N")
    else 
        io.put_string("Cas is_equal_ko : OK%N")
    end  
end


end -- class TESTUTILISATEUR
