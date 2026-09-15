USE pizzaria;

-- 1. LISTAR TODOS OS CLIENTES
SELECT *
FROM cliente;

-- 2. LISTAR CLIENTES EM ORDEM ALFABÉTICA
SELECT
    id_cliente,
    nome,
    email,
    telefone
FROM cliente
ORDER BY nome;

-- 3. LISTAR OS PRODUTOS
SELECT
    id_produto,
    nome,
    preco
FROM produto
ORDER BY preco DESC;

-- 4. LISTAR PRODUTOS E SUAS CATEGORIAS
SELECT
    p.nome AS produto,
    c.nome AS categoria,
    p.preco
FROM produto p
INNER JOIN categoria c
    ON p.id_categoria = c.id_categoria
ORDER BY c.nome, p.nome;

-- 5. PRODUTOS COM PREÇO ACIMA DE R$ 45,00
SELECT
    nome,
    preco
FROM produto
WHERE preco > 45
ORDER BY preco DESC;

-- 6. PRODUTOS DE UMA CATEGORIA ESPECÍFICA
SELECT
    p.nome AS produto,
    p.preco
FROM produto p
INNER JOIN categoria c
    ON p.id_categoria = c.id_categoria
WHERE c.nome = 'Pizzas Salgadas'
ORDER BY p.preco;

-- 7. LISTAR OS PEDIDOS E O CLIENTE
SELECT
    pe.id_pedido,
    c.nome AS cliente,
    pe.data_pedido,
    pe.status,
    pe.forma_pagamento,
    pe.valor_total
FROM pedido pe
INNER JOIN cliente c
    ON pe.id_cliente = c.id_cliente
ORDER BY pe.data_pedido DESC;

-- 8. LISTAR OS PEDIDOS ENTREGUES
SELECT
    pe.id_pedido,
    c.nome AS cliente,
    pe.valor_total,
    pe.status
FROM pedido pe
INNER JOIN cliente c
    ON pe.id_cliente = c.id_cliente
WHERE pe.status = 'Entregue';

-- 9. LISTAR OS ITENS DE CADA PEDIDO
SELECT
    pe.id_pedido,
    c.nome AS cliente,
    p.nome AS produto,
    ip.quantidade,
    ip.preco_unitario,
    ip.observacao
FROM item_pedido ip
INNER JOIN pedido pe
    ON ip.id_pedido = pe.id_pedido
INNER JOIN cliente c
    ON pe.id_cliente = c.id_cliente
INNER JOIN produto p
    ON ip.id_produto = p.id_produto
ORDER BY pe.id_pedido;

-- 10. MOSTRAR OS ENDEREÇOS DOS CLIENTES

SELECT
    c.nome AS cliente,
    e.rua,
    e.numero,
    e.complemento,
    e.bairro,
    e.cidade,
    e.cep
FROM cliente c
INNER JOIN endereco e
    ON c.id_cliente = e.id_cliente
ORDER BY c.nome;
