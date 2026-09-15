CREATE DATABASE IF NOT EXISTS pizzaria;
USE pizzaria;

CREATE TABLE cliente (
    id_cliente INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone VARCHAR(15) NOT NULL,
    cpf VARCHAR(11) UNIQUE,
    
    PRIMARY KEY (id_cliente)
);

CREATE TABLE endereco (
    id_endereco INT NOT NULL AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    rua VARCHAR(150) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(50),
    bairro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL DEFAULT 'Brasilia',
    cep VARCHAR(8) NOT NULL,

    PRIMARY KEY (id_endereco),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE
);

CREATE TABLE categoria (
    id_categoria INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL UNIQUE,
    
    PRIMARY KEY (id_categoria)
);

CREATE TABLE produto (
    id_produto INT NOT NULL AUTO_INCREMENT,
    id_categoria INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(8, 2) NOT NULL,
    
    PRIMARY KEY (id_produto),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE pedido (
    id_pedido INT NOT NULL AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_endereco INT NOT NULL,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pendente', 'Em Preparo', 'Em Transporte', 'Entregue', 'Cancelado') DEFAULT 'Pendente',
    forma_pagamento ENUM('Dinheiro', 'Cartao_Credito', 'Cartao_Debito', 'Pix') NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    
    PRIMARY KEY (id_pedido),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco)
);

CREATE TABLE item_pedido (
    id_item INT NOT NULL AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    preco_unitario DECIMAL(8, 2) NOT NULL,
    observacao VARCHAR(255),
    
    PRIMARY KEY (id_item),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

INSERT INTO categoria 
(nome) 
VALUES 
('Pizzas Salgadas'),
('Pizzas Doces'),
('Bebidas');

INSERT INTO cliente 
(nome, email, telefone, cpf) 
VALUES 
('João Silva', 'joao.silva@gmail.com', '61988887777', '12345678901'),
('Maria Oliveira', 'maria.oliveira@gmail.com', '61977776666', '98765432100'),
('Carlos Souza', 'carlos.souza@gmail.com', '61966665555', '45678912300'),
('laura beatriz', 'laura.beatriz@gmail.com', '61991419899', '07698678121' ),
('eduardo guedes', 'eduardo.guedes@gmail.com', '61998578455', '02598658455'),
('joseane sena', 'joseane.sena@gmail.com', '61998659866', '03568958742'),
('breno rocha', 'breno.rocha@gmail.com', '61998658562', '32658945788'),
('djalma', 'djalma@gmail.com', '61778457855', '96895662365');

INSERT INTO endereco 
(id_cliente, rua, numero, complemento, bairro, cidade, cep) 
VALUES 
(1, 'Rua das Flores', '123', 'Apt 42', 'Centro', 'Brasilia', '01001000'),
(1, 'Avenida Brasil', '500', 'Bloco B', 'Jardins', 'Brasilia', '01430000'),
(2, 'Avenida Paulista', '1500', 'Conjunto 12', 'Bela Vista', 'Brasilia', '01310100'),
(2, 'Rua Augusta', '850', 'S/N', 'Consolação', 'Brasilia', '01304000'),
(3, 'Rua Domingos de Morais', '2100', 'Casa 2', 'Vila Mariana', 'Brasilia', '04010000'),
(3, 'Alameda Santos', '300', 'Apt 101', 'Paraíso', 'Brasilia', '01418000'),
(3, 'Rua Teodoro Sampaio', '1420', 'Loja A', 'Pinheiros', 'Brasilia', '05406000');

INSERT INTO produto 
(id_categoria, nome, descricao, preco) 
VALUES 
(1, 'Calabresa', 'Molho de tomate, calabresa fatiada, cebola e azeitonas', 45.00),
(1, 'Muçarela', 'Molho de tomate, muçarela, rodelas de tomate e orégano', 42.00),
(1, 'Frango com Catupiry', 'Frango desfiado com cobertura de catupiry original', 50.00),
(2, 'Brigadeiro', 'Chocolate ao leite com granulado', 48.00),
(3, 'Refrigerante Cola 2L', 'Garrafa de 2 Litros', 12.00);

INSERT INTO pedido 
(id_cliente, id_endereco, status, forma_pagamento, valor_total) 
VALUES 
(1, 1, 'Entregue', 'Pix', 57.00),
(2, 3, 'Em Preparo', 'Cartao_Credito', 92.00);

INSERT INTO item_pedido 
(id_pedido, id_produto, quantidade, preco_unitario, observacao) 
VALUES 
(1, 1, 1, 45.00, 'Sem cebola'),
(1, 5, 1, 12.00, NULL),
(2, 2, 1, 42.00, 'Massa fina'),
(2, 3, 1, 50.00, 'Caprichar no molho');