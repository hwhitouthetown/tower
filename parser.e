class PARSER
	--
	-- Le jeu des tours de Hanoi
	-- %n --> retour à la ligne
--

-- git clone link
-- git pull
-- git add * 
-- git commit
-- git push
	
creation {ANY}
	make
	
feature {}
  parse_util(line : STRING) is -- Nom<Delahaye> ; Prenom<Benoit> ; Identifiant<bdelahay>
    local
      i : INTEGER
      dictionnaire_temp, dictionnaire_final : ARRAY[STRING]
    do
    
      create dictionnaire_temp.make(1,1)
			create dictionnaire_final.make(1,1)
      -- On sépare chaque donnée par des espace (et on remplace les espaces par 
      -- un autre charactère pour les sauvegarder, ici '*')
      line.replace_all(' ', '*')
      line.replace_all(';',' ')
      line.replace_all('<',' ')
			line.replace_all('>',' ')
      
      -- Tableau temporaire contient les clefs - valeurs de la ligne
      dictionnaire_temp.copy(line.split)

      -- Boucle pour avoir le tableau final avec que le type + les couples clefs/valeur
      from 
				i := 1
			until
			  i > dictionnaire_temp.count -- > car on incrémente de 3 en 3 (paire + 1 espace)
			loop
         -- On remet les espaces dans les valeurs
        dictionnaire_temp.item(i).replace_all('*',' ')
				dictionnaire_temp.item(i).left_adjust
				dictionnaire_temp.item(i).right_adjust
        if (dictionnaire_temp.item(i).count > 0) then
	      	-- On ajoute au dico final
					dictionnaire_final.add(dictionnaire_temp.item(i), dictionnaire_final.upper)
				end
				i := i+1
      end

			-- Boucle pour afficher les utilisateurs			
			from
				i := 1
			until i = dictionnaire_final.count
			loop
				io.put_string(dictionnaire_final.item(i))
				io.put_string(" -- ")
				io.put_string(dictionnaire_final.item(i+1))
				io.put_string("%N")	
				i := i+2
			end
			
    end



	parse_media(line : STRING) is -- Nom<Delahaye> ; Prenom<Benoit> ; Identifiant<bdelahay>
    local
      i : INTEGER
      dictionnaire_temp, dictionnaire_final : ARRAY[STRING]
    do
    
      create dictionnaire_temp.make(1,1)
			create dictionnaire_final.make(1,1)
      -- On sépare chaque donnée par des espace (et on remplace les espaces par 
      -- un autre charactère pour les sauvegarder, ici '*')
      line.replace_all(' ', '*')
      line.replace_all(';',' ')
      line.replace_all('<',' ')
			line.replace_all('>',' ')
      
      -- Tableau temporaire contient les clefs - valeurs de la ligne
      dictionnaire_temp.copy(line.split)

      -- Boucle pour avoir le tableau final avec que le type + les couples clefs/valeur
      from 
				i := 1
			until
			  i > dictionnaire_temp.count -- > car on incrémente de 3 en 3 (paire + 1 espace)
			loop
         -- On remet les espaces dans les valeurs
        dictionnaire_temp.item(i).replace_all('*',' ')
				dictionnaire_temp.item(i).left_adjust
				dictionnaire_temp.item(i).right_adjust
        if (dictionnaire_temp.item(i).count > 0) then
	      	-- On ajoute au dico final
					dictionnaire_final.add(dictionnaire_temp.item(i), dictionnaire_final.upper)
				end
				i := i+1
      end

			-- Boucle pour afficher les medias
			-- Afficher le type
			dictionnaire_temp.item(1).right_adjust	
			io.put_string("Type -- ")
      io.put_string(dictionnaire_temp.item(1))	
			io.put_string("%N");		
			from
				i := 2
			until i = dictionnaire_final.count
			loop
				io.put_string(dictionnaire_final.item(i))
				io.put_string(" -- ")
				io.put_string(dictionnaire_final.item(i+1))
				io.put_string("%N")	
				i := i+2
			end
			
    end

feature {ANY}

	make is
		local
		do 
			io.put_string("----- PARSING UTILISATEUR ------%N")	
			parsing_utilisateurs
			io.put_string("-------- PARSING MEDIA ---------%N")	
			parsing_medias
		end

	-------------------------- PARSING UTILISATEURS ------------------------------

	parsing_utilisateurs is
		-- Main pour tester la lecture d'un fichier
	  local
	    source: STRING
	    text_reader : TEXT_FILE_READ
	    readable : BOOLEAN
	    debut : BOOLEAN
	    --indice : INTEGER
		do
		  io.put_string("Début du programme !%N")
			source := "utilisateurs.txt"
			create text_reader.connect_to(source)
  	  if (text_reader.is_connected) then
  	    io.put_string("Accès au fichier 'utilisateurs.txt' : OK%N")
  	    
  	    from
				readable := not text_reader.end_of_input
				debut := True
			  until
				  not readable
			  loop
          text_reader.read_line
          if (text_reader.last_string.count > 0) then -- Si différent de la fin de ligne
            parse_util(text_reader.last_string)
						io.put_string("%N%N")
          end
				  readable := not text_reader.end_of_input
			  end
  	    
  	  else
  	    io.put_string("Accès au fichier 'utilisateurs.txt' : KO %N")
  	  end
      text_reader.disconnect  	  
      io.put_string("Fin du programme !%N")
		end	

			-------------------------- PARSING MEDIAS --------------------------------

		parsing_medias is
			-- Main pour tester la lecture d'un fichier
			local
			  source: STRING
			  text_reader : TEXT_FILE_READ
			  readable : BOOLEAN
			  debut : BOOLEAN
			do
				io.put_string("Début du programme !%N")
				source := "medias.txt"
				create text_reader.connect_to(source)
			  if (text_reader.is_connected) then
			    io.put_string("Accès au fichier 'medias.txt' : OK%N")
			    
			    from
					readable := not text_reader.end_of_input
					debut := True
					until
						not readable
					loop
		        text_reader.read_line
		        if (text_reader.last_string.count > 0) then -- Si différent de la fin de ligne
		          parse_media(text_reader.last_string)
							io.put_string("%N%N")
		        end
						readable := not text_reader.end_of_input
					end
			    
			  else
			    io.put_string("Accès au fichier 'medias.txt' : KO %N")
			  end
		    text_reader.disconnect  	  
		    io.put_string("Fin du programme !%N")
			end	

end -- class PARSER
