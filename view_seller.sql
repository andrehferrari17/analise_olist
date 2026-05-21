CREATE OR REPLACE VIEW vw_analise_pagamentos_entregas_reviews AS

SELECT DISTINCT ON (o.order_id)
    o.order_id AS "ID",
    p.product_category_name AS "CATEGORIA DO PRODUTO",

    o.order_estimated_delivery_date AS "DATA ESTIMADA DE ENTREGA",
    o.order_delivered_customer_date AS "DATA DE ENTREGA",

    o.order_delivered_customer_date - o.order_estimated_delivery_date AS "TEMPO ENTREGA VS ESTIMADO",

    CASE
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
        THEN 'ATRASADO'
        ELSE 'NO PRAZO'
    END AS "STATUS ENTREGA",

    ore.review_answer_timestamp - ore.review_creation_date AS "TEMPO DE RESPOSTA REVIEW",
    ore.review_score AS "SCORE AVALIAÇÃO",

    op.payment_type AS "MÉTODO DE PAGAMENTO",
    op.payment_installments AS "NÚMERO DE PARCELAS",
    op.payment_value AS "VALOR PAGAMENTO"

FROM orders o

INNER JOIN order_items oi
    ON o.order_id = oi.order_id

INNER JOIN products p
    ON p.product_id = oi.product_id

INNER JOIN order_reviews ore
    ON o.order_id = ore.order_id

INNER JOIN order_payments op
    ON op.order_id = o.order_id

WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL

ORDER BY o.order_id, oi.order_item_id;