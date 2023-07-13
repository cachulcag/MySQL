USE nba;
SELECT * FROM equipos;
SELECT * FROM estadisticas;
SELECT * FROM jugadores;
SELECT * FROM partidos;
# CANDADO A
# POSICION '2'
-- Teniendo el máximo de asistencias por partido, muestre cuantas veces se logró dicho máximo.
SELECT count(Asistencias_por_partido) AS Posicion_A FROM estadisticas WHERE Asistencias_por_partido = (SELECT max(Asistencias_por_partido) FROM estadisticas);

# CLAVE 14043
-- Muestre la suma total del peso de los jugadores, donde la conferencia sea Este y la posición sea
-- centro o esté comprendida en otras posiciones.
SELECT sum(Peso) AS Clave_A FROM jugadores 
	INNER JOIN equipos ON jugadores.Nombre_equipo = equipos.Nombre
	WHERE Conferencia LIKE 'East' AND jugadores.Posicion LIKE '%C%';
    
   # CANDADO B
   # POSICION B 3
-- Muestre la cantidad de jugadores que poseen más asistencias por partidos, que el numero de
-- jugadores que tiene el equipo Heat.
SELECT count(jugador) as Posicion_B FROM estadisticas 
    WHERE Asistencias_por_partido > (SELECT count(*) FROM jugadores WHERE Nombre_equipo LIKE 'Heat');
    
    # CLAVE B 3480
    -- La clave será igual al conteo de partidos jugados durante las temporadas del año 1999.
    SELECT DISTINCT count(*) FROM partidos WHERE temporada LIKE '%99%';
    
    #CANDADO C
    # POSICION C 1
    -- La posición del código será igual a la cantidad de jugadores que proceden de Michigan y forman parte de equipos de la conferencia oeste.
	-- Al resultado obtenido lo dividiremos por la cantidad de jugadores cuyo peso es mayor o igual a 195, y a eso le vamos a sumar 0.9945.

    SELECT floor(count(*)/(SELECT count(*) FROM jugadores WHERE PESO >= 195)+0.9945) as POSICION_C FROM jugadores 
		INNER JOIN equipos ON Nombre_equipo = Equipos.Nombre
		WHERE Procedencia LIKE 'Michigan' AND Conferencia LIKE 'West';
        
# CLAVE C 631
-- Para obtener el siguiente código deberás redondear hacia abajo el resultado que se devuelve de
-- sumar: el promedio de puntos por partido, el conteo de asistencias por partido, y la suma de
-- tapones por partido. Además, este resultado debe ser, donde la división sea central.
SELECT floor(AVG(Puntos_por_partido) + count(Asistencias_por_partido) + sum(Tapones_por_partido)) AS CLAVE_C FROM estadisticas
	INNER JOIN jugadores ON estadisticas.jugador = jugadores.codigo
    INNER JOIN equipos ON jugadores.Nombre_equipo = equipos.nombre
    WHERE division like 'Central';
    
    #CANDADO D
    # POSICION D 4
   -- Muestre los tapones por partido del jugador Corey Maggette durante la temporada 00/01. 
   -- Este resultado debe ser redondeado.
   SELECT floor(Tapones_por_partido) FROM estadisticas
	INNER JOIN jugadores ON estadisticas.jugador = jugadores.codigo
    WHERE jugadores.Nombre LIKE 'Corey Maggette'AND estadisticas.temporada LIKE '%00/01%';
    
    # CLAVE D 191
-- Para obtener el siguiente código deberás redondear hacia abajo, la suma de puntos por partido
-- de todos los jugadores de procedencia argentina.
    SELECT floor(sum(Puntos_por_partido)) FROM estadisticas
		INNER JOIN jugadores ON estadisticas.jugador = jugadores.codigo
        WHERE Procedencia LIKE 'Argentina';
   