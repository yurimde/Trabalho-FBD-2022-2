-- Clientes que residem no Brasil
create view clientesBrasil as
	Select * from cliente join endereco using (codc)
	where pais = 'Brasil';

select * from clientesBrasil

-- Exibe os pedidos feitos por clientes no brasil, o local onde foi feito o pedido e o número de produtos no pedido
select clientesBrasil.nome, cidade, uf, produto.nome
from clientesBrasil join pedido using (codc) join atribuicao using (codpe) join produto using (codp)

