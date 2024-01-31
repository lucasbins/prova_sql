-- A1 - Lista de funcionários ordenando pelo salário decrescente.
SELECT ven.id_vendedor, ven.nome, ven.cargo, ven.salario, ven.data_admissao, ven.inativo
FROM vendedores ven
ORDER by ven.salario DESC;

-- A2 - Lista de pedidos de vendas ordenado por data de emissão.
SELECT * FROM pedido 
ORDER BY data_emissao;

-- A3 - Valor de faturamento por cliente.
SELECT ped.id_cliente, SUM(ped.valor_total) as Faturamento FROM pedido ped 
GROUP BY ped.id_cliente;

-- A4 - Valor de faturamento por empresa.
SELECT ped.id_empresa, SUM(ped.valor_total) as Faturamento FROM pedido ped 
GROUP BY ped.id_empresa;

-- A5 -Valor de faturamento por vendedor.
SELECT cli.id_vendedor, SUM(ped.valor_total) as Faturamento FROM pedido ped
INNER JOIN clientes cli on ped.id_empresa = cli.id_empresa
GROUP BY cli.id_vendedor;

-- B1 -
 SELECT 
ped.data_emissao,
prod.id_produto,
prod.descricao,
ped.id_cliente,
cli.razao_social,
emp.id_empresa,
emp.razao_social,
vend.id_vendedor,
vend.nome AS Nome_Vendedor,
con.preco_minimo,
con.preco_maximo,
itens.preco_praticado as Preço_base
FROM PEDIDO ped
JOIN itens_pedido itens ON itens.id_pedido = ped.id_pedido
JOIN produtos prod ON prod.id_produto = itens.id_produto
JOIN clientes cli ON cli.id_cliente = ped.id_cliente
JOIN empresa emp ON emp.id_empresa = ped.id_empresa
JOIN config_preco_produto con ON con.id_produto = prod.id_produto
JOIN vendedores vend ON vend.id_vendedor = con.id_vendedor
WHERE ped.id_pedido = (SELECT MAX(id_pedido) FROM pedido WHERE id_cliente = ped.id_cliente)
ORDER BY ped.data_emissao ASC