CREATE DATABASE festmax;

USE festmax;

/*CREATE TABLES*/

CREATE TABLE imagem (
    ID_IMAGEM INT AUTO_INCREMENT PRIMARY KEY,
    NOME_IMAGEM VARCHAR(255) NOT NULL,
    IMAGEM_BINARIA BLOB NOT NULL
);

CREATE TABLE endereco(
    ID_ENDERECO INT PRIMARY KEY AUTO_INCREMENT,
    RUA VARCHAR(255) NOT NULL,
    NUMERO INT NOT NULL,
    BAIRRO VARCHAR(255) NOT NULL,
    CIDADE VARCHAR(255) NOT NULL,
    ESTADO_UF CHAR(2) NOT NULL,
    CEP VARCHAR(9) NOT NULL
);

CREATE TABLE telefone(
    ID_TELEFONE INT PRIMARY KEY AUTO_INCREMENT,
    TIPO_TELEFONE VARCHAR(50) NOT NULL,
    DDD_TELEFONE CHAR(2) NOT NULL,
    NUMERO_TELEFONE CHAR(9) NOT NULL
);

CREATE TABLE setor_funcionario (
    ID_SETOR_FUNCIONARIO INT PRIMARY KEY AUTO_INCREMENT,
    NOME_SETOR_FUNCIONARIO VARCHAR(255)
);

CREATE TABLE setor_produto (
    ID_SETOR_PRODUTO INT PRIMARY KEY AUTO_INCREMENT,
    NOME_SETOR_PRODUTO VARCHAR(255),
    ID_IMAGEM INT
);

CREATE TABLE filial (
    ID_FILIAL INT PRIMARY KEY AUTO_INCREMENT,
    NOME_FILIAL VARCHAR(255) NOT NULL,
    CNPJ_FILIAL VARCHAR(18) NOT NULL,
    EMAIL_FILIAL VARCHAR(255) NOT NULL,
    ID_ENDERECO INT, 
    ID_TELEFONE INT
);

CREATE TABLE chefe (
    ID_CHEFE INT PRIMARY KEY AUTO_INCREMENT,
    NOME_CHEFE VARCHAR(255) NOT NULL,
    CPF_CHEFE CHAR(14) NOT NULL UNIQUE,
    DATA_ADMISSAO TIMESTAMP DEFAULT '2023-12-06',
    SALARIO_CHEFE DECIMAL(10,2) NOT NULL,
    ID_FILIAL INT,
    ID_SETOR_FUNCIONARIO INT,
    ID_ENDERECO INT,
    ID_TELEFONE INT,
    ID_IMAGEM INT
);

CREATE TABLE cliente (
    ID_CLIENTE INT PRIMARY KEY AUTO_INCREMENT,
    NOME_CLIENTE VARCHAR(255) NOT NULL,
    CPF_CLIENTE CHAR(14) NOT NULL UNIQUE,
    EMAIL VARCHAR(255) NOT NULL UNIQUE,
    DATA_NASCIMENTO DATE NOT NULL,
    SEXO ENUM("M", "F"),
    ID_FILIAL INT,
    ID_ENDERECO INT,
    ID_TELEFONE INT,
    ID_IMAGEM INT
);

CREATE TABLE funcionario (
    ID_FUNCIONARIO INT PRIMARY KEY AUTO_INCREMENT,
    NOME_FUNCIONARIO VARCHAR(255) NOT NULL,
    CPF_FUNCIONARIO CHAR(14) NOT NULL UNIQUE,
    DATA_ADMISSAO_FUNCIONARIO TIMESTAMP DEFAULT '2024-05-01',
    SALARIO_FUNCIONARIO DECIMAL(10,2) NOT NULL,
    HORARIO_ENTRADA TIME NOT NULL,
    CARGO VARCHAR(255),
    SEXO ENUM("M", "F"),
    HORARIO_SAIDA TIME NOT NULL,
    ID_SETOR_FUNCIONARIO INT,
    ID_CHEFE INT,
    ID_FILIAL INT,
    ID_ENDERECO INT,
    ID_TELEFONE INT
);


CREATE TABLE produto (
    ID_PRODUTO INT PRIMARY KEY AUTO_INCREMENT,
    NOME_PRODUTO VARCHAR(255) NOT NULL,
    DESCRICAO_PRODUTO TEXT,
    PRECO_PRODUTO DECIMAL(10,2) NOT NULL,
    MARCA VARCHAR(255) NOT NULL,
    UNIDADE_MEDIDA ENUM('KG', 'L', 'UN'),
    QUANTIDADE_ESTOQUE INT NOT NULL,
    ID_SETOR_PRODUTO INT,
    ID_IMAGEM INT
);

CREATE TABLE carrinho_compra(
    ID_CARRINHO INT PRIMARY KEY AUTO_INCREMENT,
    ID_CLIENTE INT
);

CREATE TABLE item_carrinho(
    ID_ITEM_CARRINHO INT PRIMARY KEY AUTO_INCREMENT,
    ID_CARRINHO INT,
    ID_PRODUTO INT,
    QUANTIDADE INT,
    PRECO_PRODUTO DECIMAL(10,2) NOT NULL
);  

CREATE TABLE compra (
    ID_COMPRA INT PRIMARY KEY AUTO_INCREMENT,
    DATA_COMPRA TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    TOTAL_PAGO DECIMAL(10,2) NOT NULL,
    FORMA_PAGAMENTO ENUM("CRÉDITO", "DÉBITO", "PIX"),   
    ID_FILIAL INT,
    ID_CARRINHO INT
);

CREATE TABLE item_comprado (
    ID_ITEM_COMPRADO INT AUTO_INCREMENT PRIMARY KEY,
    QUANTIDADE INT,
    PRECO_PRODUTO DECIMAL(10,2) NOT NULL,
    ID_COMPRA INT,
    ID_PRODUTO INT
);

/*CONSTRAINTS*/

ALTER TABLE setor_produto
ADD CONSTRAINT fk_setor_produto_imagem
FOREIGN KEY (ID_IMAGEM) REFERENCES imagem(ID_IMAGEM);

ALTER TABLE filial 
ADD CONSTRAINT fk_filial_endereco
FOREIGN KEY(ID_ENDERECO) REFERENCES endereco(ID_ENDERECO),
ADD CONSTRAINT fk_filial_telefone
FOREIGN KEY(ID_TELEFONE) REFERENCES telefone(ID_TELEFONE);

ALTER TABLE chefe
ADD CONSTRAINT fk_chefe_filial
FOREIGN KEY (ID_FILIAL) REFERENCES filial (ID_FILIAL),
ADD CONSTRAINT fk_chefe_setorfuncionario
FOREIGN KEY (ID_SETOR_FUNCIONARIO) REFERENCES setor_funcionario (ID_SETOR_FUNCIONARIO),
ADD CONSTRAINT fk_chefe_endereco
FOREIGN KEY (ID_ENDERECO) REFERENCES endereco (ID_ENDERECO),
ADD CONSTRAINT fk_chefe_telefone
 FOREIGN KEY (ID_TELEFONE) REFERENCES telefone (ID_TELEFONE),
ADD CONSTRAINT fk_chefe_imagem
FOREIGN KEY (ID_IMAGEM) REFERENCES imagem(ID_IMAGEM);

ALTER TABLE cliente
ADD CONSTRAINT fk_cliente_filial
FOREIGN KEY(ID_FILIAL) REFERENCES filial(ID_FILIAL),
ADD CONSTRAINT fk_cliente_endereco
FOREIGN KEY (ID_ENDERECO) REFERENCES endereco(ID_ENDERECO),
ADD CONSTRAINT fk_cliente_telefone
FOREIGN KEY (ID_TELEFONE) REFERENCES telefone(ID_TELEFONE),
ADD CONSTRAINT fk_cliente_imagem
FOREIGN KEY (ID_IMAGEM) REFERENCES imagem(ID_IMAGEM);

ALTER TABLE funcionario
ADD CONSTRAINT fk_funcionario_setorfuncionario
FOREIGN KEY (ID_SETOR_FUNCIONARIO) REFERENCES setor_funcionario (ID_SETOR_FUNCIONARIO),
ADD CONSTRAINT fk_funcionario_chefe
FOREIGN KEY (ID_CHEFE) REFERENCES chefe (ID_CHEFE),
ADD CONSTRAINT fk_funcionario_filial
FOREIGN KEY (ID_FILIAL) REFERENCES filial (ID_FILIAL),
ADD CONSTRAINT fk_funcionario_endereco
FOREIGN KEY (ID_ENDERECO) REFERENCES endereco (ID_ENDERECO),
ADD CONSTRAINT fk_funcionario_telefone
FOREIGN KEY (ID_TELEFONE) REFERENCES telefone (ID_TELEFONE);

ALTER TABLE produto
ADD CONSTRAINT fk_produto_setorproduto
FOREIGN KEY (ID_SETOR_PRODUTO) REFERENCES setor_produto (ID_SETOR_PRODUTO),
ADD CONSTRAINT fk_produto_imagem
FOREIGN KEY (ID_IMAGEM) REFERENCES imagem(ID_IMAGEM);

ALTER TABLE carrinho_compra
ADD CONSTRAINT fk_carrinho_cliente
FOREIGN KEY (ID_CLIENTE) REFERENCES cliente(ID_CLIENTE);

ALTER TABLE item_carrinho
ADD CONSTRAINT fk_item_carrinho
FOREIGN KEY (ID_CARRINHO) REFERENCES carrinho_compra(ID_CARRINHO),
ADD CONSTRAINT fk_item_produto
FOREIGN KEY (ID_PRODUTO) REFERENCES produto(ID_PRODUTO);  

ALTER TABLE compra
ADD CONSTRAINT fk_compra_filial
FOREIGN KEY (ID_FILIAL) REFERENCES filial(ID_FILIAL),
ADD CONSTRAINT fk_compra_carrinho
FOREIGN KEY (ID_CARRINHO) REFERENCES carrinho_compra(ID_CARRINHO);

ALTER TABLE item_comprado
ADD CONSTRAINT fk_item_comprado_compra
FOREIGN KEY (ID_COMPRA) REFERENCES compra(ID_COMPRA),
ADD CONSTRAINT fk_item_comprado_produto
FOREIGN KEY (ID_PRODUTO) REFERENCES produto(ID_PRODUTO);