class TEST
-- Represente une   
creation {ANY}
    make

feature {}
    
    testuser : TESTUTILISATEUR

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
                io.put_string("| 1 - TESTER MEDIA                |%N")
                io.put_string("| 2 - TESTER UTILISATEUR          |%N")
                io.put_string("| 3 - TESTER ADMINISTRATEUR       |%N")
                io.put_string("| 0 - Quitter                     |%N")
                io.put_string(" ---------------------------------%N")

                io.put_string("%NEntrez votre choix %N")

                io.read_integer
                io.read_line -- FIX read_integer saute le prochain read_line
                choix := io.last_integer

                inspect choix
                    when 1 then
                        io.put_string("--- Test de la classe media ---%N")
                    when 2 then
                        io.put_string("--- Test de la classe utilisateur ---%N")
                        create testuser.make

                    when 3 then
                        io.put_string("--- Test de la classe administrateur ---%N")        
                    when 0 then
                        --quitter le programme
                        io.put_string("Vous quittez le programme %N")

                    else
                        io.put_string("Choix incorrect %N")
                end -- inspect
            end -- loop 
        end 
  
end -- class TEST
