class PARSER
-- git clone link
-- git pull
-- git add * 
-- git commit
-- git push
	
creation {ANY}
	make
	
feature {}
  parse_util(line : STRING) is
    local
      i : INTEGER
      dictionnaire : ARRAY[STRING]
    do
      create dictionnaire.make(1,1)
      -- On sépare chaque donnée par des espace (et on remplace les espaces par 
      -- un autre charactère pour les sauvegarder, ici '*')
      line.replace_all(' ', '*')
      line.replace_all(';',' ')
      line.replace_all('<',' ')
      line.replace_all('>',' ')
      
      -- Tableau contient les clefs - valeurs de la ligne
      dictionnaire.copy(line.split)

      -- Boucle pour avoir le tableau final avec que le type + les couples clefs/valeur
      from 
        i := 1
        until
        i > dictionnaire.count
        loop
         -- On remet les espaces dans les valeurs
        dictionnaire.item(i).replace_all('*',' ')
        dictionnaire.item(i).left_adjust
        dictionnaire.item(i).right_adjust
        if (dictionnaire.item(i).count = 0) then
	      	-- On supprime l'élément vide du tableau
          dictionnaire.remove(i)
        else
          i := i+1
        end
      end

      -- Boucle pour afficher les utilisateurs			
      from
        i := 1
      until i > dictionnaire.count
      loop
        io.put_string(dictionnaire.item(i))
        io.put_string(" -- ")
        io.put_string(dictionnaire.item(i+1))
        io.put_string("%N")	
        i := i+2
      end	
    end



	parse_media(line : STRING) is
    local
      i : INTEGER
      dictionnaire : ARRAY[STRING]
    do
      create dictionnaire.make(1,1)
      -- On sépare chaque donnée par des espace (et on remplace les espaces par 
      -- un autre charactère pour les sauvegarder, ici '*')
      line.replace_all(' ', '*')
      line.replace_all(';',' ')
      line.replace_all('<',' ')
      line.replace_all('>',' ')
      
      -- Tableau contient les clefs - valeurs de la ligne avec ces espaces entre les deux
      dictionnaire.copy(line.split)

      -- Boucle pour avoir le tableau final avec que le type + les couples clefs/valeur
      from 
        i := 1
      until
        i > dictionnaire.count
      loop
         -- On remet les espaces dans les valeurs
        dictionnaire.item(i).replace_all('*',' ')
        dictionnaire.item(i).left_adjust
        dictionnaire.item(i).right_adjust
        if (dictionnaire.item(i).count = 0) then
          -- On supprime l'élément vide du tableau
          dictionnaire.remove(i)
        else
          i := i+1
        end
      end

      -- Boucle pour afficher le tableau	
      dictionnaire.item(1).right_adjust	
      io.put_string("Type -- ")
      io.put_string(dictionnaire.item(1))	
      io.put_string("%N");
      from
	    i := 2
      until i > dictionnaire.count
      loop
	    io.put_string(dictionnaire.item(i))
	    io.put_string(" -- ")
	    io.put_string(dictionnaire.item(i+1))
	    io.put_string("%N")	
	    i := i+2
      end
    end

feature {ANY}

	make is
      local
      do 
        io.put_string("Début du programme !%N")
        io.put_string("----- PARSING UTILISATEUR ------%N%N")	
        parsing_utilisateurs
        io.put_string("-------- PARSING MEDIA ---------%N%N")	
        parsing_medias
        io.put_string("Fin du programme !%N")
      end

	-------------------------- PARSING UTILISATEURS ------------------------------

	parsing_utilisateurs is
	  local
	    source: STRING
	    text_reader : TEXT_FILE_READ
	    readable : BOOLEAN
		do
          source := "utilisateurs.txt"
          create text_reader.connect_to(source)
          if (text_reader.is_connected) then
            io.put_string("Accès au fichier 'utilisateurs.txt' : OK%N")
            from
              readable := not text_reader.end_of_input
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
            io.put_string("Echec du parsing : Accès au fichier 'utilisateurs.txt' : KO %N")
          end
          text_reader.disconnect  	  
        end	

			-------------------------- PARSING MEDIAS --------------------------------

		parsing_medias is
          local
            source: STRING
            text_reader : TEXT_FILE_READ
            readable : BOOLEAN
          do
            source := "medias.txt"
            create text_reader.connect_to(source)
            if (text_reader.is_connected) then
              io.put_string("Accès au fichier 'medias.txt' : OK%N")
              from
                readable := not text_reader.end_of_input
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
              io.put_string("Echec du parsing : Accès au fichier 'medias.txt' : KO %N")
          end
          text_reader.disconnect  	  
        end	

end -- class PARSER
