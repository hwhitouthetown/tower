class MEDIA
-- Represente un media
	
creation {ANY}
	make_media

feature {}
	titre: STRING
	nombre : INTEGER
	createur : STRING 

feature {ANY}
	afficher is
		do
			io.put_string("-----------MEDIA-----------%N")
			io.put_string("Titre : " + titre + "%N")
			io.put_string("Createur :" + createur + "%N")
			io.put_string("Nombre d'exemplaire : " + nombre.to_string + "%N") 
		end

	make_media (titrep: STRING; createurp: STRING; nombrep: INTEGER) is
		do
			titre := ""
			titre.copy(titrep)
			
			nombre := 0
			nombre.copy(nombrep)

			createur := ""
			createur.copy(createurp)
		end	

end -- class MEDIA
