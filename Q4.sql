USE atividade_bdii;

DROP PROCEDURE IF EXISTS SP_VENDAS;
DELIMITER $$

CREATE PROCEDURE SP_VENDAS (
    IN data_inicio DATE,
    IN data_fim DATE,
    IN seller_id VARCHAR(50)
)
BEGIN
    IF data_inicio IS NULL OR data_fim IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'As datas de início e fim são obrigatórias.';
    END IF;

    SELECT 
        items.product_id AS id_produto,
        SUM(items.price) AS total_vendido,
        COUNT(items.product_id) AS qtd_vendas
    FROM olist_orders_dataset AS orders
    JOIN olist_order_items_dataset AS items 
        ON orders.order_id = items.order_id
    WHERE orders.order_purchase_timestamp BETWEEN data_inicio AND data_fim
      AND (seller_id IS NULL OR items.seller_id = seller_id)
    GROUP BY items.product_id
    ORDER BY total_vendido DESC;
END$$

DELIMITER ;

CALL SP_VENDAS('1950-01-01', '2025-10-10', 'd1b65fc7debc3361ea86b5f14c68d2e2');
