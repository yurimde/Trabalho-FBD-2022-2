-- Clientes que residem no Brasil
create view clientesBrasil as
	Select * from cliente join endereco using (codc)
	where pais = 'Brasil';

select * from clientesBrasil

-- Consulta número de pedidos 
