class MEDIATHEQUE
--
	
creation {ANY}
	make

feature {}
	nb_media: INTEGER
	nb_client:INTEGER
	list_medias : ARRAY[MEDIA]


feature {ANY}
	make is

		do 
			nb_media := 0 
			nb_client := 0 
			io.put_string("Bienvenue dans la mediatheque du futur :%N")
		end

	
end -- class MEDIATHEQUE
