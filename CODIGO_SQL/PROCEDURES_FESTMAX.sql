/*PROCEDURE QUE VERIFICAR SE CLIENTE JÁ POSSUI UM CARRINHO*/

DELIMITER $$

CREATE PROCEDURE get_or_create_cart(
    IN p_id_cliente INT,
    OUT p_id_carrinho INT
)
BEGIN
    DECLARE v_id_carrinho INT;

    -- Verifica se existe um carrinho não finalizado para o cliente
    SELECT ID_CARRINHO INTO v_id_carrinho
    FROM carrinho_compra
    WHERE ID_CLIENTE = p_id_cliente
    AND ID_CARRINHO NOT IN (SELECT ID_CARRINHO FROM compra);

    IF v_id_carrinho IS NULL THEN
        -- Se não existir, cria um novo carrinho
        INSERT INTO carrinho_compra (ID_CLIENTE) VALUES (p_id_cliente);1
        SET v_id_carrinho = LAST_INSERT_ID();
    END IF;

    SET p_id_carrinho = v_id_carrinho;
END$$

DELIMITER ;


/*Aumenta a quantidade de produtos no carrinho*/
DELIMITER $$

CREATE PROCEDURE add_to_cart(
    IN p_id_cliente INT,
    IN p_id_produto INT,
    IN p_preco_produto DECIMAL(10,2)
)
BEGIN
    DECLARE v_id_carrinho INT;
    DECLARE v_quantidade INT;

    -- Obter ou criar carrinho
    CALL get_or_create_cart(p_id_cliente, v_id_carrinho);

    -- Verifica se o produto já está no carrinho
    SELECT QUANTIDADE INTO v_quantidade
    FROM item_carrinho
    WHERE ID_CARRINHO = v_id_carrinho AND ID_PRODUTO = p_id_produto;

    IF v_quantidade IS NULL THEN
        -- Produto não está no carrinho, adiciona com quantidade 1
        INSERT INTO item_carrinho (ID_CARRINHO, ID_PRODUTO, QUANTIDADE, PRECO_PRODUTO)
        VALUES (v_id_carrinho, p_id_produto, 1, p_preco_produto);
    ELSE
        -- Produto já está no carrinho, incrementa a quantidade
        UPDATE item_carrinho
        SET QUANTIDADE = QUANTIDADE + 1
        WHERE ID_CARRINHO = v_id_carrinho AND ID_PRODUTO = p_id_produto;
    END IF;
END$$

/*Diminui a quantidade de produtos no carrinho*/

CREATE PROCEDURE remove_from_cart(
    IN p_id_cliente INT,
    IN p_id_produto INT
)
BEGIN
    DECLARE v_id_carrinho INT;
    DECLARE v_quantidade INT;

    -- Obter ou criar carrinho
    CALL get_or_create_cart(p_id_cliente, v_id_carrinho);

    -- Verifica a quantidade atual do produto no carrinho
    SELECT QUANTIDADE INTO v_quantidade
    FROM item_carrinho
    WHERE ID_CARRINHO = v_id_carrinho AND ID_PRODUTO = p_id_produto;

    IF v_quantidade IS NOT NULL THEN
        IF v_quantidade > 1 THEN
            -- Se a quantidade for maior que 1, decrementa a quantidade
            UPDATE item_carrinho
            SET QUANTIDADE = QUANTIDADE - 1
            WHERE ID_CARRINHO = v_id_carrinho AND ID_PRODUTO = p_id_produto;
        ELSE
            -- Se a quantidade for 1, remove o item do carrinho
            DELETE FROM item_carrinho
            WHERE ID_CARRINHO = v_id_carrinho AND ID_PRODUTO = p_id_produto;
        END IF;
    END IF;
END$$

DELIMITER ;



/*Finaliza a compra*/

DELIMITER $$

CREATE PROCEDURE finalize_purchase(
    IN p_id_cliente INT,
    IN p_forma_pagamento ENUM('CRÉDITO', 'DÉBITO', 'PIX')
)
BEGIN
    DECLARE v_id_carrinho INT;
    DECLARE v_total_pago DECIMAL(10,2);
    DECLARE v_id_filial INT;
    DECLARE v_id_compra INT;
    DECLARE v_id_produto INT;
    DECLARE v_quantidade INT;
    DECLARE v_preco_produto DECIMAL(10,2);
    DECLARE done INT DEFAULT 0;

    -- Handler for cursor
    DECLARE cur CURSOR FOR 
    SELECT ID_PRODUTO, QUANTIDADE, PRECO_PRODUTO 
    FROM item_carrinho
    WHERE ID_CARRINHO = v_id_carrinho;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Obter ou criar carrinho
    CALL get_or_create_cart(p_id_cliente, v_id_carrinho);

    -- Verifica se o carrinho está vazio
    SELECT COUNT(*) INTO v_total_pago
    FROM item_carrinho
    WHERE ID_CARRINHO = v_id_carrinho;

    IF v_total_pago = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Carrinho de compras está vazio';
    END IF;

    -- Calcular o total da compra
    SELECT SUM(QUANTIDADE * PRECO_PRODUTO) INTO v_total_pago
    FROM item_carrinho
    WHERE ID_CARRINHO = v_id_carrinho;

    -- Obter a filial do cliente
    SELECT ID_FILIAL INTO v_id_filial
    FROM cliente
    WHERE ID_CLIENTE = p_id_cliente;

    -- Inserir a compra na tabela compra
    INSERT INTO compra (DATA_COMPRA, TOTAL_PAGO, FORMA_PAGAMENTO, ID_FILIAL, ID_CARRINHO)
    VALUES (CURRENT_TIMESTAMP, v_total_pago, p_forma_pagamento, v_id_filial, v_id_carrinho);

    SET v_id_compra = LAST_INSERT_ID();

    -- Transferir os itens do carrinho para a tabela item_comprado
    OPEN cur;
    item_loop: LOOP
        FETCH cur INTO v_id_produto, v_quantidade, v_preco_produto;
        IF done THEN
            LEAVE item_loop;
        END IF;

        INSERT INTO item_comprado (QUANTIDADE, PRECO_PRODUTO, ID_COMPRA, ID_PRODUTO)
        VALUES (v_quantidade, v_preco_produto, v_id_compra, v_id_produto);
    END LOOP;
    CLOSE cur;

    -- Limpar o carrinho de compras
    DELETE FROM item_carrinho
    WHERE ID_CARRINHO = v_id_carrinho;
END$$

DELIMITER ;
