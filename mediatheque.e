class MEDIATHEQUE
-- Rappel GIT
-- git clone link
-- git pull
-- git add * 
-- git commit
-- git push
	
creation {ANY}
  make

feature {}
  nb_media: INTEGER
  nb_client:INTEGER
  list_medias : ARRAY[MEDIA]

  parsing_line(line : STRING; type : STRING) is
    local
      i : INTEGER
      dictionnaire : ARRAY[STRING]
    do

      ------------ TRAITEMENT ----------------

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

      ------------ AFFICHAGE ----------------

      if (type.is_equal("medias")) then
        i := 2
        dictionnaire.item(1).right_adjust	
        io.put_string("Type -- ")
        io.put_string(dictionnaire.item(1))	
        io.put_string("%N");
      else
        i := 1
      end 	
      from
      until i > dictionnaire.count
      loop
        io.put_string(dictionnaire.item(i))
        io.put_string(" -- ")
        io.put_string(dictionnaire.item(i+1))
        io.put_string("%N")	
        i := i+2
      end	
    end

  parsing_file(file : STRING; type : STRING) is
    local
      text_reader : TEXT_FILE_READ
      readable : BOOLEAN
    do
      create text_reader.connect_to(file)
      if (text_reader.is_connected) then
        from
          readable := not text_reader.end_of_input
        until
          not readable
        loop
          text_reader.read_line
          if (text_reader.last_string.count > 0) then -- Si différent de la fin de ligne
            parsing_line(text_reader.last_string, type)
            io.put_string("%N")
          end
          readable := not text_reader.end_of_input
        end
      else
        io.put_string("Echec du parsing : Accès au fichier '")
        io.put_string(file)
        io.put_string("' : KO %N")
      end
      text_reader.disconnect  	  
    end


feature {ANY}
  make is

    do 
      nb_media := 0 
      nb_client := 0 
      io.put_string("Bienvenue dans la mediatheque du futur :%N")
      io.put_string("----- PARSING UTILISATEUR ------%N%N")	
      parsing_file("utilisateurs.txt", "utilisateurs")
      io.put_string("-------- PARSING MEDIA ---------%N%N")	
      parsing_file("medias.txt", "medias")
      io.put_string("Fin du programme !%N")
    end

	
end -- class MEDIATHEQUE
