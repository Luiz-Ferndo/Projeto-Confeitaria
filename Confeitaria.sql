--Criando a tabela de Produto
create table produto(nomeProduto varchar(30),
					tipo varchar(30),
					preco money,
					codProduto serial not null check (codProduto > 0),
					constraint pkProduto primary key (codProduto));

--Criando a tabela de Cliente					
create table cliente(nomeCliente varchar(30),
					telefone varchar(11),
					endereco varchar(50),
					codCliente serial not null check (codCliente > 0),
					constraint pkCliente primary key (codCliente));

--Criando a tabela de pedido
create table pedido(dataPedido date,
				   tipoVenda varchar(15),
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
				   	tipoVenda varchar(15),
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

--Criando a tabela Entrega
create table entrega(codEntrega serial not null check (codEntrega > 0),
					  constraint pkEntrega primary key (codEntrega));
					  
--Adiconando a chave estrangeira na tabela Entrega
alter table entrega
add column codPedido serial not null check (codPedido > 0),
add constraint fkPedido foreign key (codPedido) references pedido(codPedido),
add column codMotoboy serial not null check (codMotoboy > 0),
add constraint fkMotoboy foreign key (codMotoboy) references motoboy(codMotoboy);

-- SQL de inserções dos dados
insert into produto (nomeProduto, tipo, preco) values 
('Bolo de Chocolate', 'bolo', 10.00),
('Bolo de Laranja', 'bolo', 11.00),
('Bolo de Tapioca', 'bolo', 11.50),
('Bolo de Goiabada', 'bolo', 12.00),
('Bolo de Morango', 'bolo', 15.00),
('Bolo de Creme de Milho', 'bolo', 15.00),
('Bolo de Cenoura', 'bolo', 15.00),
('Bolo de Brigadeiro', 'bolo', 15.00),
('Torta de Limão', 'torta', 10.00),
('Banoffee', 'torta', 16.00),
('Manteiga de Amendoim', 'torta', 12.00),
('Oreo', 'torta', 12.00),
('Maçã', 'torta', 10.00),
('Abóbora', 'torta', 12.00),
('Coxinha', 'salgado', 12.00),
('Bolinha de Queijo', 'salgado', 10.00),
('Quibe', 'salgado', 12.00),
('Croissant', 'salgado', 16.00),
('Esfiha de 4 Queijos', 'salgado', 15.00),
('Brigadeirão', 'doce', 5.00),
('Doce de Leite', 'doce', 4.00),
('Beijinho', 'doce', 6.00),
('Leite em Pó e Creme de Avelã', 'doce', 7.00);

insert into cliente (nomeCliente, telefone, endereco) values
('Cliente 1', '1234567890', 'Rua Endereço 1, 1'),
('Cliente 2', '1234567890', 'Rua Endereço 1, 2'),
('Cliente 3', '1234567890', 'Rua Endereço 1, 3'),
('Cliente 4', '1234567890', 'Rua Endereço 1, 4'),
('Cliente 5', '1234567890', 'Rua Endereço 1, 5');

insert into motoboy (nomeMotoboy, codMotoboy) values
('Motoboy 1', 1),
('Motoboy 2', 2),
('Motoboy 3', 3);

insert into pedido (codCliente, tipoVenda, dataPedido, pagamento, status) values 
(1, 'balcão', '2023-01-04', 'à vista', 'finalizado'),
(2, 'balcão', '2023-02-04', 'à prazo', 'finalizado'),
(3, 'balcão', '2023-02-04', 'à vista', 'finalizado'),
(4, 'balcão', '2023-02-04', 'débito', 'finalizado'),
(5, 'balcão', '2023-02-20', 'à prazo', 'finalizado'),
(1, 'delivery', '2023-02-22', 'à prazo', 'finalizado'),
(2, 'delivery', '2023-02-23', 'à prazo', 'finalizado'),
(2, 'delivery', '2023-06-04', 'à vista', 'finalizado'),
(1, 'delivery', '2023-06-06', 'à prazo', 'finalizado'),
(5, 'delivery', '2023-06-10', 'à prazo', 'finalizado'),
(1, 'balcão', '2023-06-15', 'débito', 'finalizado'),
(2, 'balcão', '2023-06-15', 'débito', 'finalizado'),
(3, 'balcão', '2023-06-15', 'pix', 'finalizado'),
(3, 'balcão', '2023-06-20', 'pix', 'finalizado'),
(1, 'delivery', '2023-10-06', 'à prazo', 'em aberto'),
(3, 'delivery', '2023-10-08', 'à prazo', 'finalizado'),
(4, 'delivery', '2023-11-10', 'à prazo', 'em aberto'),
(5, 'balcão', '2023-11-10', 'à prazo', 'finalizado'),
(1, 'delivery', '2023-11-12', 'débito', 'em aberto'),
(1, 'balcão', '2023-12-15', 'débito', 'finalizado'),
(2, 'delivery', '2023-12-15', 'débito', 'em aberto'),
(3, 'balcão', '2023-12-15', 'pix', 'finalizado'),
(3, 'delivery', '2023-12-20', 'pix', 'em aberto');

insert into pedidoItem (quantidade, codPedido, codProduto) values
(2, 1, 1),
(1, 1, 2),
(1, 1, 6),
(1, 2, 8),
(1, 2, 11),
(1, 3, 12),
(3, 4, 12),
(2, 5, 8),
(1, 6, 4),
(1, 6, 14),
(1, 7, 11),
(4, 8, 11),
(2, 8, 1),
(1, 9, 7),
(2, 9, 10),
(2, 10, 12),
(1, 11, 6),
(3, 12, 14),
(2, 13, 9),
(1, 14, 3),
(2, 15, 15),
(4, 16, 15),
(1, 17, 4),
(2, 18, 4),
(3, 18, 10),
(1, 19, 5),
(2, 19, 8),
(2, 19, 5),
(1, 20, 6),
(3, 20, 8),
(2, 21, 13),
(2, 21, 8),
(1, 22, 1),
(3, 22, 10),
(2, 22, 12),
(4, 22, 15);

insert into entrega (codPedido, codMotoboy, codEntrega) values 
(6, 1, 1),
(7, 1, 2),
(8, 2, 3),
(9, 3, 4),
(10, 1, 5),
(15, 1, 6),
(16, 2, 7),
(17, 3, 8),
(19, 3, 9),
(21, 2, 10),
(23, 2, 11);

insert into encomenda (codCliente, tipoVenda, dataRetirada, tipoPagamento, status) values
(2, 'encomenda', '2023-01-08', 'à vista', 'finalizado'),
(4, 'encomenda', '2023-01-10', 'à prazo', 'em aberto'),
(1, 'encomenda', '2023-01-12', 'débito', 'finalizado'),
(5, 'encomenda', '2023-04-08', 'à prazo', 'em aberto'),
(4, 'encomenda', '2023-05-10', 'pix', 'em aberto'),
(1, 'encomenda', '2023-05-12', 'débito', 'finalizado'),
(3, 'encomenda', '2023-06-08', 'pix', 'em aberto'),
(4, 'encomenda', '2023-08-10', 'pix', 'finalizado'),
(1, 'encomenda', '2023-08-12', 'débito', 'finalizado');

insert into encomendaItem (quantidade, codEncomenda, codProduto) values
(2, 1, 1),
(1, 1, 2),
(1, 1, 6),
(1, 2, 8),
(1, 2, 11),
(1, 3, 12),
(3, 4, 12),
(2, 5, 8),
(1, 6, 4),
(1, 6, 14),
(1, 7, 11),
(4, 8, 11),
(2, 8, 1),
(1, 9, 7),
(2, 9, 10);

-- Exercicio
-- Primeiro Item
select tipovenda, count(tipovenda) from pedido group by tipovenda limit 1; 

 -- Segundo Item
select p.codpedido, p.tipovenda, p.datapedido, p.pagamento, p.status, sum(pr.preco * pi.quantidade) from pedido p join pedidoitem pi on p.codpedido = pi.codpedido join produto pr on pi.codproduto = pr.codproduto where tipovenda = 'balcão' and status = 'finalizado' group by p.codpedido order by sum(pr.preco * pi.quantidade) desc limit 1;

-- Terceiro Item
select m.codmotoboy, m.nomemotoboy, count(e.codpedido) from entrega e join motoboy m on e.codmotoboy = m.codmotoboy join pedido p on e.codpedido  = p.codpedido where extract (month from p.datapedido) = '06' and tipovenda = 'delivery' group by m.codmotoboy order by count(e.codpedido) desc limit 1;

-- Quarto Item
-- 1 Segunda / 2 Terça / 3 Quarta / 4 Quinta / 5 Sexta / 6 Sabado / 7 Domingo
select extract (isodow from p.datapedido) as diadasemana, count(extract (isodow from p.datapedido)) as quantidade from pedido p group by extract (isodow from p.datapedido) order by count(extract (isodow from p.datapedido)) desc limit 1;

-- Quinto Item
select nomeproduto, count(quantidade) from produto p1 join pedidoitem pi1 on p1.codproduto = pi1.codproduto group by nomeproduto, p1.codproduto order by count(quantidade) desc limit 1;

-- Sexto Item
select c.nomeCliente, count(*) as total_pedidos from cliente c join pedido p on c.codCliente = p.codCliente where p.Tipovenda = 'delivery' and p.status = 'finalizado' group by c.nomeCliente having count(*) > 10;

-- Sétimo Item
select e.* from encomenda e where e.status <> 'finalizado';

-- Oitavo Item
select extract (day from dataPedido) as dia, count (*) as total_vendas from pedido where extract (month from dataPedido) = 2 and extract (year from dataPedido) = 2023 group by dia order by total_vendas desc limit 1;

-- Nono Item
select extract (month from p.datapedido) as mes, sum(pr.preco * pi.quantidade) as lucro from pedido p join pedidoItem pi on p.codPedido = pi.codPedido join produto pr on pi.codProduto = pr.codProduto where extract(year from p.dataPedido) = 2023 group by mes order by lucro asc limit 1;

-- Décimo Item
select pr.nomeProduto, count(pi.codProduto) as total_vendas from produto pr left join pedidoItem pi on pr.codProduto = pi.codProduto group by pr.nomeProduto order by total_vendas asc limit 1;