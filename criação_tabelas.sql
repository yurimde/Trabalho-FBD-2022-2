drop table if exists cliente;
drop table if exists vendedor;
drop table if exists usuario;
drop table if exists cartao;
drop table if exists produto;
drop table if exists pedido;
drop table if exists endereco;
drop table if exists atribuicao;
drop table if exists avaliacao;


create table usuario(
	email	varchar(20) not null,
	nome	varchar(25) not null,
	senha	varchar(15) not null,
	nacionalidade varchar(20) not null);

create table cliente
(	codc 	char(3) NOT NULL PRIMARY KEY UNIQUE,
	cpf varchar(11	) unique ) inherits (usuario);



create table vendedor(
	codv char(2) NOT NULL PRIMARY KEY UNIQUE,
	cnpj varchar(11) unique not null) inherits (usuario);

create table cartao(
	codca 	char(3) NOT NULL PRIMARY KEY,
	numero varchar(16) not null,
	cvv		varchar(3) not null,
	vencimento date not null,
	nome	varchar(25), 
	codc	char(3) NOT NULL,
    FOREIGN KEY (codc) REFERENCES cliente(codc)
);

create table endereco(
	code	char(3) NOT NULL PRIMARY KEY UNIQUE,
	pais	varchar(15) not null,
	uf		varchar(20) not null,
	cidade	varchar(25) not null,
	rua		varchar(25) not null,
	numero	varchar(10) not null,
	compl	varchar(30) not null,
	codc	char(3) not null,
	FOREIGN KEY (codc) REFERENCES cliente(codc)
);

create table pedido(
	codpe 		char(3) primary key unique,
	dEntrega 	date,
	dPedido		date not null,
	nota		float,
	code		char(3) not null,
	codca		char(3) not null,
	codc		char(3) not null,
	FOREIGN KEY (code) REFERENCES endereco(code),
	FOREIGN KEY (codca) REFERENCES cartao(codca),
	FOREIGN KEY (codc) REFERENCES cliente(codc)
 );


create table produto
(codp		char(3) primary key unique,
 nome		varchar(20) not null,
 preco		decimal not null,
 descricao	text not null,
 dataL		date not null,
 nota		float,
 codv		char(3) not null,
 FOREIGN KEY (codv) REFERENCES vendedor(codv);
);
 
create table avaliacao
(nota	float not null,
 descricao text,
 codp	char(3) not null,
 codc 	char(3) not null,
 FOREIGN KEY (codp) REFERENCES produto (codp),
 FOREIGN KEY (codc) REFERENCES cliente (codc)
);

create table atribuicao
(quant	SMALLINT not null,
 codpe	char(3) not null,
 codp 	char(3) not null,
 FOREIGN KEY (codpe) REFERENCES pedido (codpe),
 FOREIGN KEY (codp) REFERENCES produto (codp)
 );
 
 
 
 
 
insert into cliente(codc, email, nome, senha, nacionalidade, cpf) values
('1', 'yurimde@gmail.com','Yuri Vargas','12345678','Brasileiro','11122233344'),
('2', 'testeaqui@seila.com','Jorge Amado','Pastel','Ratanabá','12345678910'),
('3', 'iamironman@stark.com', 'Tony Stark', 'Avengers', 'Estadunidense','10987654321');

insert into vendedor(codv, email, nome, senha, nacionalidade, cnpj) values
('1','yurimde@gmail.com','Vargas Yuri','abcdefgh','Brasileiro','44433322211'),
('2','testeaqui@seila.com','Amado Jorge','flango','Ratanabá','13579135791'),
('3','iamironman@stark.com', 'Stark Tony', 'Vingadores', 'Estadunidense','02468024680');

insert into cartao(codca, numero, cvv, vencimento, nome, codc) 
values('1','1111222233334444', '123', '2028-10-05', 'Yuri Vargas', 1),
('2','5555666677778888', '456', '2029-10-5', 'Jorge Amado', 2),
('3','9999000011112222', '789', '2027-10-4', 'Tony Stark', 3);

insert into endereco values
('1','Brasil','RS', 'Eldorado do Sul','Esmeralda','777','casa','1'),
('2','Brasil','AM','Ratanabá','Rua obi wan kenobi','420','nave','2'),
('3','Estados Unidos','NW','Nova Iorque','5ª avenue','789','Avengers','3');

insert into pedido values
('1',null,'2023-5-10', 5, '1','1'),
('2','2023-6-10','2023-5-25', 3, '2','2'),
('3',null,'2023-7-10', 4, '3','3');

insert into produto values
('1','Monitor LED',500,'Monitor LED 19 polegadas', '2022-02-25', 4.5),
('2','Reator fusão', 77777777,'Reator de fusão nuclear para naves de hiperespaço','1969-07-31',9.999),
('3','Reator Arc', 12, 'Reator arc do tony stark', '2011-01-01', 12);

insert into avaliacao values
(4.5,'Monitor de excelente custo benefício','1','1'),
(420,'Muito bom reator, agora posso fazer viagens insterestelares entre ratanaba e marte', '2','2'),
(777,'Muito bom, energia limpa','3','3');

insert into atribuicao values
(1,'1','1'),
(333,'2','2'),
(42,'3','3');

insert into aquisicao values
('1','1'),
('2','2'),
('3','3');

insert into cadastro values
('1','1'),
('2','2'),
('3','3');

SELECT * FROM cliente;
SELECT * FROM vendedor;
select * FROM cartao;
select * from endereco;
select * from pedido;
select * from produto;
select * from avaliacao;
select * from atribuicao;
select * from aquisicao;
select * from cadastro;


