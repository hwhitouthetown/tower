class INTERFACE
-- Represente une interface
	
creation {ANY}
	make

feature {}
	connect: INTEGER -- entier 0 non connecté -- 1 connecte user -- 2 connect admin
	choix: INTEGER


feature {ANY}

	make is
	local
		do

		connect := 1
		choix := 5

         from
            until choix = 0 
            loop
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
			io.read_integer
			io.read_line -- FIX read_integer saute le prochain read_line
			choix := io.last_integer
		
			

			inspect choix
			when 1 then
				io.put_string("Médias %N")
			when 2 then
				if(connect = 0) then
				io.put_string("Se connecter %N")
				else 
				io.put_string("Se déconnecter %N")
				end
			when 0 then
				--quitter le programme
				io.put_string("Vous quittez le programme %N")
			else
				io.put_string("Choix incorrect %N")
			end -- inspect
        end -- loop
	end	
end -- class INTERFACE
