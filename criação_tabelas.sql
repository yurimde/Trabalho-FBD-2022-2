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
	id SERIAL NOT NULL PRIMARY KEY unique,
	email	varchar(20) not null,
	nome	varchar(25) not null,
	senha	varchar(15) not null,
	nacionalidade varchar(20) not null);

create table cliente
(	id SERIAL PRIMARY KEY UNIQUE,
	cpf varchar(11) unique ) inherits (usuario);

SHOW (TABLE cliente);

create table vendedor(
	id SERIAL PRIMARY KEY UNIQUE,
	cnpj varchar(11) unique not null) inherits (usuario);

create table cartao(
	id SERIAL PRIMARY KEY,
	numero varchar(16) not null,
	cvv		varchar(3) not null,
	vencimento date not null,
	nome	varchar(25), 
	cliente_id INTEGER NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

create table endereco(
	id		SERIAL PRIMARY KEY UNIQUE,
	pais	varchar(15) not null,
	uf		varchar(20) not null,
	cidade	varchar(25) not null,
	rua		varchar(25) not null,
	numero	varchar(10) not null,
	compl	varchar(30) not null,
	cliente_id	INTEGER not null,
	FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

create table pedido(
	id SERIAL 	primary key unique,
	dEntrega 	date,
	dPedido		date not null,
	nota		float,
	endereco_id	INTEGER not null,
	cartao_id	INTEGER not null,
	FOREIGN KEY (endereco_id) REFERENCES endereco(id),
	FOREIGN KEY (cartao_id) REFERENCES cartao(id)
 );


create table produto
(id		SERIAL primary key unique,
 nome		varchar(20) not null,
 preco		decimal not null,
 descricao	text not null,
 dataL		date not null,
 nota		float
);
 
create table avaliacao
(nota	float not null,
 descricao text,
 codp	varchar(15) not null,
 cliente_id INTEGER not null,
 FOREIGN KEY (codp) REFERENCES produto (codp),
 FOREIGN KEY (cliente_id) REFERENCES cliente (id)
);

create table atribuicao
(quant	SMALLINT not null,
 idPedido INTEGER not null,
 produto_id INTEGER not null,
 FOREIGN KEY (idPedido) REFERENCES pedido (id),
 FOREIGN KEY (produto_id) REFERENCES produto (id)
 );
 
 create table aquisicao(
 	idCliente 	INT NOT NULL,
	idPedido	INT NOT NULL,
	FOREIGN KEY (idCliente) references cliente (id),
	FOREIGN KEY (idPedido) references pedido (id)
 );
 
 
 create table cadastro(
 	produto_id 	integer not null,
	vendedor_id integer not null,
	FOREIGN KEY (produto_id) REFERENCES produto(id),
	FOREIGN KEY (vendedor_id) REFERENCES vendedor(id)
 );
 


