SELECT
    INITCAP(h.appat_huesped) || ' ' || h.apmat_huesped || ' ' || h.nom_huesped huesped,
    p.nom_procedencia procedencia,
    r.nom_region region,
    a.nom_agencia agencia,
    COUNT(re.id_reserva) "NUMERO DE RESERVAS",
    COUNT(c.id_consumo) "NUMERO DE CONSUMOS"
FROM region r JOIN procedencia p
ON r.id_region = p.id_region
JOIN huesped h
ON p.id_procedencia = h.id_procedencia
JOIN agencia a
ON h.id_agencia = a.id_agencia
JOIN reserva re
ON re.id_huesped = h.id_huesped
JOIN consumo c
ON c.id_huesped = h.id_huesped
WHERE re.id_reserva > (SELECT COUNT(r.id_reserva)
        FROM reserva r
        JOIN huesped h
        ON r.id_huesped = r.id_huesped
        GROUP BY r.id_reserva)
GROUP BY h.appat_huesped, h.apmat_huesped, h.nom_huesped, p.nom_procedencia, r.nom_region, a.nom_agencia
