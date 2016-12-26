deferred class MEDIA
-- Represente un media abstrait (pas instanciable)
	
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

end -- class MEDIA
