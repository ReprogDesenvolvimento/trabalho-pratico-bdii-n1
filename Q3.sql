CREATE DATABASE atividade_bdii;

USE atividade_bdii;

CREATE TABLE `log_violacoes_regras` (
  `id_log` INT AUTO_INCREMENT PRIMARY KEY,
  `timestamp_ocorrencia` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `usuario_db` VARCHAR(255),
  `tabela_afetada` VARCHAR(255),
  `tipo_operacao` VARCHAR(50),
  `descricao_violacao` TEXT,
  `dados_tentativa` TEXT
) 
ENGINE=MyISAM;

USE atividade_bdii;
DELIMITER $$

CREATE TRIGGER trg_validar_e_logar_nota_review
BEFORE INSERT ON olist_order_reviews_dataset
FOR EACH ROW
BEGIN
    DECLARE v_mensagem_erro TEXT;
    DECLARE v_dados_tentativa TEXT;

    IF NEW.review_score < 1 OR NEW.review_score > 5 THEN
    
        SET v_mensagem_erro = 'Erro: A pontuação do review (review_score) deve estar entre 1 e 5.';
        
        SET v_dados_tentativa = CONCAT(
            'order_id: ', IFNULL(NEW.order_id, 'NULL'), 
            ', review_id: ', IFNULL(NEW.review_id, 'NULL'),
            ', review_score: ', IFNULL(NEW.review_score, 'NULL')
        );

        INSERT INTO log_violacoes_regras 
        (
            usuario_db, tabela_afetada, tipo_operacao, 
            descricao_violacao, dados_tentativa
        )
        VALUES 
        (
            USER(), 'olist_order_reviews_dataset', 'INSERT', 
            v_mensagem_erro, v_dados_tentativa
        );

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = v_mensagem_erro;
        
    END IF;
END$$

DELIMITER ;

USE atividade_bdii;

INSERT INTO olist_order_reviews_dataset 
(review_id, order_id, review_score) 
VALUES 
('review_teste_99', 'order_teste_99', 9);

USE atividade_bdii;
SELECT * FROM log_violacoes_regras;

USE atividade_bdii;

INSERT INTO olist_order_reviews_dataset 
(review_id, order_id, review_score) 
VALUES 
('review_teste_100', 'order_teste_100', 4);