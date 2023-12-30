--Criando a tabela de Produto
create table produto(nomeProduto varchar(30),
					tipo varchar(30),
					preço money,
					codProduto serial not null check (codProduto > 0),
					constraint pkProduto primary key (codProduto));

--Criando a tabela de Cliente					
create table cliente(nomeCliente varchar(30),
					telefone varchar(11),
					endereço varchar(50),
					codCliente serial not null check (codCliente > 0),
					constraint pkCliente primary key (codCliente));

--Criando a tabela de pedido
create table pedido(dataPedido date,
				   pagamento varchar(15),
				   status varchar(20),
				   codPedido serial not null check (codPedido > 0),				   
				   constraint pkPedido primary key (codPedido));
				   
--Adicionando a chave estrangeira na tabela Pedido				   
alter table pedido
add column codCliente serial not null check (codCliente > 0),
add constraint fkCliente foreign key (codCliente) references cliente;

--Criando a tabela de Pedido-Item
create table pedidoItem(quantidade integer,
					   codPedidoItem serial not null check (codPedidoItem > 0),
					   constraint pkPedidoItem primary key (codPedidoItem));
					   
--Adicionando as cheves estrangeiras na tabela Pedido-Item
alter table pedidoItem
add column codPedido serial not null check (codPedido > 0),
add column codProduto serial not null check (codProduto > 0),
add constraint fkPedido foreign  key (codPedido) references pedido,
add constraint fkProduto foreign key (codProduto) references produto;

--Criando a tabela de motoboy
create table motoboy(nomeMotoboy varchar(20),
					codMotoboy serial not null check (codMotoboy > 0),
					constraint pkMotoboy primary key (codMotoboy));
					
--Criando a tabela encomenda
create table encomenda(dataRetirada date,
					  tipoPagamento varchar(20),
					  status varchar(20),
					  codEncomenda serial not null check (codEncomenda > 0),
					  constraint pkEncomenda primary key (codEncomenda));
					  
--Aicionando a chave estrangeira na tabela encomenda
alter table encomenda
add column codCliente serial not null check (codCliente > 0),
add constraint fkCliente foreign key (codCliente) references cliente;

--Criando a tabela Encomenda-Item
create table encomendaItem(quantidade integer,
						  codEncomendaItem serial not null check (codEncomendaItem > 0),
						  constraint pkEncomendaItem primary key (codEncomendaItem));
						  
--adcionando as chaves estrangeiras na tabela Encomenda-Item
alter table encomendaItem
add column codEncomenda serial not null check (codEncomenda > 0),
add column codProduto serial not null check (codProduto > 0),
add constraint fkEncomenda foreign key (codEncomenda) references encomenda,
add constraint fkProduto foreign key (codProduto) references produto;

--Criando a tabela Pagamento
create table pagamento(valor money,
					  pagamento varchar(15),
					  codPagamento serial not null check (codPagamento > 0),
					  constraint pkPagamento primary key (codPagamento));
					  
--Adiconando a chave estrangeira na tabela Pagamento
alter table pagamento
add column codPedido serial not null check (codPedido > 0),
add constraint fkPedido foreign key (codPedido) references pedido;