class INTERFACE
-- Represente une interface
	
creation {ANY}
	make

feature {}
	connect: INTEGER -- entier 0 non connecté -- 1 connecte user -- 2 connect admin
	choix: INTEGER


feature {ANY}

	make is
		do

		connect := 0
		choix := 1

		end 

	afficher_menu is 	
	do
        	io.put_string(" ------------- BIENVENUE -------------%N")
        	io.put_string("| 1 - Consulter les médias            |%N")
        	
        	inspect(connect)
        		when 0 then 
        			io.put_string("| 2 - Se connecter                    |%N")
        		when 1 then 
        			io.put_string("| 2 - Se déconnecter                  |%N")
        		when 2 then 
        			io.put_string("| 2 - Se déconnecter                  |%N")
        	end -- isnpect		
  

			io.put_string("| 0 - Quitter                         |%N")
			io.put_string(" -------------------------------------%N")
		
			io.put_string("%NEntrez votre choix %N")
	end	


	get_connect : INTEGER is 
	do 
		Result := connect
	end 


	set_connect(co : INTEGER) is 
	do 
		connect := co
	end 



        
end -- class INTERFACE
