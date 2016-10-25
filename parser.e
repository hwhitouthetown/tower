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
  parse_util(s : STRING) is -- Nom<donnee>
    local
      cle : STRING
      valeur : STRING
    do
      cle := ""
      valeur := ""
      if (s.occurrences('<') = 0) then
        io.put_string("    Type : ")
        io.put_string(s)
        io.put_string("%N")
      else
        io.put_string(s)
        cle.copy(s.substring(1, s.index_of('<', 1)-1))
        valeur.copy(s.substring(s.index_of('<', 1)+1, s.index_of('>', 1)-1))
        io.put_string("    ")
        io.put_string(s)
        io.put_string("%N")
        io.put_string("        Cle : ")
        io.put_string(cle)
        io.put_string("%N")
        io.put_string("        Valeur : ")
        io.put_string(valeur)
        io.put_string("%N")
      end
    end

feature {ANY}
	make is
		-- Main pour tester la lecture d'un fichier
	  local
	    source: STRING
	    text_reader : TEXT_FILE_READ
	    readable : BOOLEAN
	    debut : BOOLEAN
	    donnee : STRING
	    indice : INTEGER
		do
		  io.put_string("Début du programme !%N")
			source := "medias.txt"
			create text_reader.connect_to(source)
  	  if (text_reader.is_connected) then
  	    io.put_string("Accès au fichier 'medias.txt' : OK%N")
  	    
  	    from
				readable := not text_reader.end_of_input
				donnee := ""
				debut := True
			  until
				  not readable
			  loop
				  text_reader.read_word_using(" ; ") -- ";%R%N"
				  donnee.copy(text_reader.last_string)
				  if (debut) then
				    io.put_string("Nouvelle ligne --> %N")
				    debut := False
				  end
				  
				  if (donnee.has_substring("%N") and donnee.index_of('%N', 1) /= donnee.count) then
				    indice := donnee.index_of('%N', 1)
				    
				    parse_util(donnee.substring(1, indice-1))
				    io.put_string("%N")
				    
				    io.put_string("Nouvelle ligne --> %N")
				    
				    parse_util(donnee.substring(indice+1, donnee.count))
				  else
            io.put_string("-------->")
            io.put_string(donnee)
            io.put_string("%N")
				    parse_util(donnee)
				  end
				  readable := not text_reader.end_of_input
			  end
  	    
  	  else
  	    io.put_string("Accès au fichier 'medias.txt' : KO %N")
  	  end
  	  io.put_string("Fin du programme !%N")
		end	

end -- class PARSER
