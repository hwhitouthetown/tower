class MEDIA
-- Represente un media
	
creation {ANY}
	make_media -- Creation with title 

feature {}
	titre: STRING -- 
	nombre : INTEGER -- nombre d'exemplaire
	createur : STRING 

feature {ANY}
	afficher is
		do
			io.put_string("-----------MEDIA-----------%N")
			io.put_string("Titre : " + titre + "%N")
			io.put_string("Createur :" + createur + "%N")
			io.put_string("Nombre d'exemplaire : " + nombre.to_string + "%N") 
		end

	make_media (titrei: STRING; createuri :STRING; nombrei : INTEGER) is
		do
			titre := " "
			titre.copy(titrei)
			
			nombre := 0
			nombre.copy(nombrei)

			createur := " "
			createur.copy(createuri)
		end	

end -- class MEDIA
