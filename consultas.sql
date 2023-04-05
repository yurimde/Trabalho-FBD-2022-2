-- Clientes que residem no Brasil
create view clientesBrasil as
	Select * from cliente join endereco using (codc)
	where pais = 'Brasil';

select * from clientesBrasil

-- Exibe os pedidos feitos por clientes no RS, o local onde foi feito o pedido e o número de produtos no pedido
select clientesBrasil.nome, cidade, uf, produto.nome
from clientesBrasil join pedido using (codc) join atribuicao using (codpe) join produto using (codp)
where uf = 'RS'

-- Exibe o nome dos produtos que custam mais de 500 reais e em quantos pedidos
select produto.nome, count(*) numVezesPedidas
from produto join atribuicao using (codp) join pedido using (codpe)
where produto.preco >= 500
group by produto.nome

-- Exibe o nome dos produtos que tem o valor máximo, e onde foi feito o pedido de sua compra
select produto.nome, produto.preco, cidade, uf
from produto join atribuicao using (codp) join pedido using (codpe) join endereco using (code)
where produto.preco = (select max(produto.preco)
					   from produto
						);
-- Exibe o nome dos produtos avaliados por clientes brasileiros e vendidos por vendedores brasileiros						
select produto.nome
from produto
where codp in (select codp
			  from cliente join avaliacao using (codc) join produto using (codp) join vendedor using (codv)
			  where cliente.nacionalidade = 'Brasileiro' and vendedor.nacionalidade = 'Brasileiro')

-- Exibe o nome dos vendedores estrangeiros com produtos avaliados com nota maior que 4
select vendedor.nome
from produto join vendedor using (codv) join avaliacao using (codp)
where avaliacao.nota >= 4 AND (NOT (nacionalidade = 'Brasileiro'))

--Exibe o nome e o numero do cartao dos clientes brasileiros que efetuaram pedidos antes de 2023
select cliente.nome, cartao.numero
from pedido join cliente using (codc) join cartao using (codca)
where cliente.nacionalidade = 'Brasileiro' AND ( pedido.dpedido < '2023-1-1')

-- Exibe o nome do cliente e a data dos pedidos efetuados com cartões  que já expiraram
select cliente.nome,dpedido
from pedido join cliente using (codc) join cartao using (codca)
where cartao.vencimento < '2023-3-1'

--Exibe o nome dos produtos entregues fora do brasil em quantidades maiores que 20
SELECT produto.nome from pedido JOIN endereco using (code) join atribuicao using (codpe) join produto USING (codp)
WHERE (Not endereco.pais = 'Brasil') AND (quant > 20)

--Exibe o nome do cliente e código de pedidos feitos por clientes brasileiros cujos produtos não tenham avaliação menor que 4
SELECT clientesBrasil.nome, pedido.codpe 
FROM clientesBrasil 
JOIN pedido USING (codc)
WHERE NOT EXISTS (
    SELECT codp 
    FROM avaliacao 
    WHERE codp IN (
        SELECT codp 
        FROM avaliacao 
        WHERE nota <= 4
    )
);

--Exibe o nome do cliente e dos produtos importados para o Brasil em quantidades maiores que 100
SELECT cliente.nome,produto.nome from pedido join cliente using (codc) join endereco using (code) join atribuicao using (codpe) JOIN produto using (codp) join vendedor using (codv)
WHERE endereco.pais = 'Brasil' and (Not vendedor.nacionalidade = 'Brasileiro') AND (quant > 100)
group by produto.nome,cliente.nome


