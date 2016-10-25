class MEDIA
-- Represente une tour et les disques qu'elle contient
	
creation {ANY}
	full, empty

feature {}
	top: INTEGER -- 
	
			

feature {}
	full (n: INTEGER) is
			-- Creation d'une tour de taille n, avec n disques presents
		require
			n >= 1
		local
			i: INTEGER
		do
                        create t.make(1,n)
			from 
                          i := 1      
                        until(i>n)        
                
                        loop  
                          t.put((n-i+1),i)
                          i := i+1        
                        end
                        top := n
		end

        is_empty:BOOLEAN is 
                do
                Result:= t.item(top)=0 and top=1
                end

        is_full:BOOLEAN is 
                do
                Result:= top=height
                end
     

	empty (n: INTEGER) is
			-- Creation d'une tour vide de taille n
		require
			n >= 1
                local
                        i:INTEGER
		do
                        create t.make(1,n)
			from 
                          i := 1      
                        until(i>n)        
                
                        loop  
                          t.put(0,i)
                          i := i+1        
                        end
                        
                          top := 1
        
		ensure
			height = n
			top = 1
		end

feature {HANOI}
	height: INTEGER is
			-- La taille de la tour
		do
			Result := t.upper
		end

	afficher_etage (d: INTEGER) is
			-- Affiche l'etage d de la tour
		require
			1 <= d
			d <= height
		local
			taille_disque, taille_disque_max, i: INTEGER
		do
			taille_disque := t.item(d)
			taille_disque_max := height
			from
				i := taille_disque_max - taille_disque
			until
				i = 0
			loop
				io.put_character(' ')
				i := i - 1
			end
			from
				i := taille_disque
			until
				i = 0
			loop
				io.put_character('=')
				i := i - 1
			end
			io.put_character('|')
			from
				i := taille_disque
			until
				i = 0
			loop
				io.put_character('=')
				i := i - 1
			end
			from
				i := taille_disque_max - taille_disque
			until
				i = 0
			loop
				io.put_character(' ')
				i := i - 1
			end
		end

	retirer_disque: INTEGER is
			-- Retire le dernier disque de la tour courante
		do
                    if(is_empty) then    
			io.put_string("Impossible de retirer un disque: la tour est vide.%N")
                    else
                      Result := t.item(top) 
                      t.put(0,top)  
                      if(top>1) then   
                      top := top-1  
                      end  
                    end        
		ensure
			top >= 1
		end

	ajouter_disque (d: INTEGER) is
			-- Ajoute un disque de taille d sur la tour.
			-- Renvoie une erreur (Explicite) si le disque ne peut pas etre ajoute
		do
                        if(is_full) then  
                           io.put_string("Impossible d'ajouter un disque: la tour est pleine.%N")           
                        elseif(t.item(top)>=d or t.item(top)=0) then  
                            if(t.item(top)/=0) then 
                                top := top+1
                            end
                                 t.put(d,top)                    
                        else 
                           io.put_string("Impossible d'ajouter un disque: disque trop petit .%N")            
                        end
		ensure
			top <= height
		end

end -- class TOWER
