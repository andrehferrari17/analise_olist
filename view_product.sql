CREATE OR REPLACE VIEW vw_product AS

SELECT DISTINCT ON (o.order_id)
    o.order_id AS "ID",
    p.product_category_name AS "CATEGORIA DO PRODUTO",
    o.order_purchase_timestamp AS "DATA DA VENDA",
    o.order_estimated_delivery_date AS "DATA ESTIMADA DE ENTREGA",
    o.order_delivered_customer_date AS "DATA DE ENTREGA",
    o.order_delivered_customer_date - o.order_estimated_delivery_date AS "TEMPO ENTREGA VS ESTIMADO",
    oi.price AS "VALOR DO PRODUTO",
    oi.freight_value AS "VALOR DO FRETE",
    oi.price + oi.freight_value AS "VALOR TOTAL VENDA",
    p.product_photos_qty AS "QUANTIDADE DE FOTOS ANUNCIO",
    p.product_description_lenght AS "TAMANHO DESCRIÇÃO ANUNCIO",
    p.product_weight_g AS "PESO DO PRODUTO",
    p.product_length_cm AS "COMPRIMENTO DO PRODUTO",
    p.product_height_cm AS "ALTURA DO PRODUTO",
    p.product_width_cm AS "LARGURA DO PRODUTO",

    CASE
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
        THEN 'ATRASADO'
        ELSE 'NO PRAZO'
    END AS "STATUS ENTREGA",

    ore.review_answer_timestamp - ore.review_creation_date AS "TEMPO DE RESPOSTA REVIEW",
    ore.review_score AS "SCORE AVALIAÇÃO"

FROM orders o

INNER JOIN order_items oi
    ON o.order_id = oi.order_id

INNER JOIN products p
    ON p.product_id = oi.product_id

INNER JOIN order_reviews ore
    ON o.order_id = ore.order_id

WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL

ORDER BY o.order_id, oi.order_item_id;