deferred class MEDIA inherit
-- Represente un media abstrait (pas instanciable)  
 COMPARABLE 
    redefine is_equal 
    end
	
feature {}
    titre : STRING
    nombre : INTEGER

feature {ANY}
    afficher is
        do
            io.put_string("-----------MEDIA-----------%N")
            if est_empruntable then
              io.put_string("Empruntable : Oui%N")
            else
              io.put_string("Empruntable : Non%N")
            end
            io.put_string("Titre : " + titre + "%N")
            io.put_string("Nombre d'exemplaire : " + nombre.to_string + "%N") 
        end

    -- Getters

    get_titre : STRING is
        do
            Result := titre
        end

    get_nombre : INTEGER is
        do
            Result := nombre
        end

    -- Setters

    set_titre(titrep: STRING) is
        do
            titre.copy(titrep)
        end

    set_nombre(nombrep: INTEGER) is
        do
            nombre := nombrep
        end

    -- Méthode pour savoir si un media est empruntable
    est_empruntable : BOOLEAN is
        do
            if nombre > 0 then
                Result := True
            else
                Result := False
            end
        end
    
    is_equal(other : MEDIA) : BOOLEAN is
        do
            Result := titre.is_equal(other.get_titre)
        end

    infix "<" (other: MEDIA) : BOOLEAN is
        do  
            Result := titre < other.get_titre
        end     




end -- class MEDIA
