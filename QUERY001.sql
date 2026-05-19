--------------------------------------------------------------------------------------------
-- Distância entre vendedor e cliente impacta score?
-- Estados com maior prazo médio possuem pior avaliação?
-- Existe relação entre localização do vendedor e atraso na entrega?
-- Análise geográfica dos vendedores que mais vendem ?
-- Qual a localização geográfica com maior volume de vendas ?

WITH geo_unique AS (
    SELECT
        geolocation_zip_code_prefix,
        AVG(geolocation_lat) AS lat,
        AVG(geolocation_lng) AS lng
    FROM geolocation
    GROUP BY geolocation_zip_code_prefix
)

SELECT DISTINCT ON (o.order_id)
    o.order_id,
    s.seller_city AS "Cidade Vendedor",
    s.seller_state AS "Estado Vendedor",
    c.customer_city AS "Cidade Cliente",
    c.customer_state AS "Estado Cliente",
    ore.review_score AS "Score",
	o.order_estimated_delivery_date "Data Estimada",
	o.order_delivered_customer_date "Data de entrega",
	o.order_delivered_customer_date - o.order_estimated_delivery_date "Tempo de entrega",
	oi.price "Preço",
	oi.freight_value "Frete",

    ROUND(
        (
            6371 * ACOS(
                COS(RADIANS(gc.lat)) *
                COS(RADIANS(gs.lat)) *
                COS(RADIANS(gs.lng) - RADIANS(gc.lng)) +
                SIN(RADIANS(gc.lat)) *
                SIN(RADIANS(gs.lat))
            )
        )::NUMERIC,
        2
    ) AS distancia_km

FROM orders o

INNER JOIN customers c
    ON c.customer_id = o.customer_id

INNER JOIN order_reviews ore
    ON ore.order_id = o.order_id

INNER JOIN order_items oi
    ON oi.order_id = o.order_id

INNER JOIN seller s
    ON s.seller_id = oi.seller_id

INNER JOIN geo_unique gc
    ON gc.geolocation_zip_code_prefix = c.customer_zip_code_prefix

INNER JOIN geo_unique gs
    ON gs.geolocation_zip_code_prefix = s.seller_zip_code_prefix

WHERE o.order_status = 'delivered';


