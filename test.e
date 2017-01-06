class TEST
-- Represente une   
creation {ANY}
    make

feature {}
    
    testuser : TESTUTILISATEUR
    testadmin : TESTADMINISTRATEUR
    testdvd : TESTDVD
    testlivre : TESTLIVRE
    testemprunt : TESTEMPRUNT
    testmediatheque : TESTMEDIATHEQUE

feature {ANY}

    make is
        do
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

                io.put_string(" ------------- TESTS -------------%N")
                io.put_string("| 1 - TESTER UTILISATEUR          |%N")
                io.put_string("| 2 - TESTER ADMINISTRATEUR       |%N")
                io.put_string("| 3 - TESTER LIVRE                |%N")
                io.put_string("| 4 - TESTER DVD                  |%N")
                io.put_string("| 5 - TESTER EMPRUNT              |%N")
                io.put_string("| 6 - TESTER FONCTIONNALITES      |%N")
                io.put_string("| 7 - TOUT TESTER                 |%N")
                io.put_string("| 0 - QUITTER                     |%N")
                io.put_string(" ---------------------------------%N")

                io.put_string("%NEntrez votre choix %N")

                io.read_integer
                io.read_line -- FIX read_integer saute le prochain read_line
                choix := io.last_integer

                inspect choix
                    when 1 then
                        io.put_string("--- Test de la classe utilisateur ---%N")
                        create testuser.make
                        io.put_string("%N")

                    when 2 then
                        io.put_string("--- Test de la classe administrateur ---%N")
                        create testadmin.make 
                        io.put_string("%N")
                        
                    when 3 then
                        io.put_string("--- Test de la classe livre ---%N")
                        create testlivre.make   
                        io.put_string("%N")
                        
                    when 4 then
                        io.put_string("--- Test de la classe dvd ---%N")
                        create testdvd.make  
                        io.put_string("%N") 
                        
                    when 5 then
                        io.put_string("--- Test de la classe emprunt ---%N")
                        create testemprunt.make   
                        io.put_string("%N")
                    when 6 then
                        io.put_string("--- Test de la classe mediatheque ---%N")
                        create testmediatheque.make
                         io.put_string("%N")  
                    when 7 then

                        io.put_string("--- Tests globaux ---%N")
                           
                        io.put_string("--- Test de la classe utilisateur ---%N")
                        create testuser.make
                        io.put_string("%N")

                        io.put_string("--- Test de la classe administrateur ---%N")
                        create testadmin.make 
                        io.put_string("%N")
                        
                        io.put_string("--- Test de la classe livre ---%N")
                        create testlivre.make   
                        io.put_string("%N")
                        
                        io.put_string("--- Test de la classe dvd ---%N")
                        create testdvd.make  
                        io.put_string("%N") 
                        
                        io.put_string("--- Test de la classe emprunt ---%N")
                        create testemprunt.make   
                        io.put_string("%N")

                        io.put_string("--- Test de la classe mediatheque ---%N")
                        create testmediatheque.make
                        io.put_string("%N")            
                           
                    when 0 then
                        --quitter le programme
                        io.put_string("Vous quittez le programme %N")

                    else
                        io.put_string("Choix incorrect %N")
                end -- inspect
            end -- loop 
        end 
  
end -- class TEST
