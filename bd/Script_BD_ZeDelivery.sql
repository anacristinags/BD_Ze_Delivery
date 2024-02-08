-- criando tabela loja
create table [loja]
(
	[cod_loja] integer not null, 
	[nome] nvarchar(160) not null,
	[endereco] nvarchar(160) not null,
	[telefone] nvarchar(160) not null,
	constraint [PK_loja] primary key ([cod_loja])
);
create unique index [IPK_loja] on [loja]([cod_loja]);

-- criando tabela usuario 
create table [usuario]
(
	[cod_usuario] integer not null, 
	[login] nvarchar(160) not null,
	[senha] nvarchar(160) not null,
	[email] nvarchar(160) not null,
	constraint [PK_usuario] primary key ([cod_usuario])
);
create unique index [IPK_usuario] on [usuario]([cod_usuario]);

-- criando tabela cliente 
create table [cliente]
(
	[cod_cliente] integer not null, 
	[cod_usuario] integer not null, 
	[nome] nvarchar(160) not null,
	[cfp] nvarchar(160) not null,
	[endereco] nvarchar(160) not null,
	[telefone] nvarchar(160) not null,
	constraint [PK_cliente] primary key ([cod_cliente]),
	constraint [FK_usuario] foreign key ([cod_usuario]) references usuario(cod_usuario)
);
create unique index [IPK_cliente] on [cliente]([cod_cliente]); 

-- criando tabela fornecedor 
create table [fornecedor] 
(
	[cod_fornecedor] integer not null, 
	[nome] nvarchar(160) not null,
	[email] nvarchar(160) not null,
	[endereco] nvarchar(160) not null,
	[cnpj] nvarchar(160) not null,
	[telefone] nvarchar(160) not null,
	constraint [PK_fornecedor] primary key ([cod_fornecedor])
); 
create unique index [IPK_fornecedor] on [fornecedor]([cod_fornecedor]);

-- criando tabela vendedor 
create table [vendedor]
(
	[cod_vendedor] integer not null,
	[cod_usuario] integer not null, 
	[cod_loja] integer not null, 
	[nome] nvarchar(160) not null,
	[cpf] nvarchar(160) not null,
	[endereco] nvarchar(160) not null,
	[tefelone] nvarchar(160) not null,
	[admin] boolean not null, 
	constraint [PK_vendedor] primary key ([cod_vendedor]),
	constraint [FK_usuario] foreign key ([cod_usuario]) references usuario(cod_usuario),
	constraint [FK_loja] foreign key ([cod_loja]) references loja(cod_loja)
);
create unique index [IPK_vendedor] on [vendedor]([cod_vendedor]); 

-- criando tabela pedido 
create table [pedido]
(
	[cod_pedido] integer not null,
	[cod_cliente] integer not null, 
	[cod_vendedor] integer not null, 
	[cod_loja] integer not null, 
	[status] nvarchar(160) not null,
	[tempo_espera] time not null,
	[vlr_pedido] double(15,2) not null,
	[data_pedido] datatime not null,
	constraint [PK_pedido] primary key ([cod_pedido]), 
	constraint [FK_cliente] foreign key ([cod_cliente]) references cliente(cod_cliente),
	constraint [FK_vendedor] foreign key ([cod_vendedor]) references vendedor(cod_vendedor), 
	constraint [FK_loja] foreign key ([cod_loja]) references loja(cod_loja)
);
create unique index [IPK_pedido] on [pedido]([cod_pedido]); 

-- criando tabela relatorio 
create table [relatorio]
(
	[cod_relatorio] integer not null,
	[cod_loja] integer not null,
	[vlr_total] double(15,2) not null, 
	[data_inicio] datatime not null,
	[data_fim] datatime not null,
	constraint [PK_relatorio] primary key ([cod_relatorio]), 
	constraint [FK_loja] foreign key ([cod_loja]) references loja(cod_loja)
); 
create unique index [IPK_relatorio] on [relatorio]([cod_relatorio]);
	
-- criando tabela produto 
create table [produto]
(
	[cod_produto] integer not null,
	[cod_fornecedor] integer not null,
	[nome] nvarchar not null,
	[vlr_prouto] double(15,2) not null, 
	constraint [PK_produto] primary key ([cod_produto]),
	constraint [FK_fornecedor] foreign key ([cod_fornecedor]) references fornecedor(cod_fornecedor)
);
create unique index [IPK_produto] on [produto]([cod_produto]);

-- criando tabela itens_pedido
create table [itens_pedido]
(
	[cod_itens_pedido] integer not null,
	[cod_pedido] integer not null,
	[cod_produto] integer not null,
	[qnt_produto] int not null, 
	constraint [PK_itens_pedido] primary key ([cod_itens_pedido]),
	constraint [FK_pedido] foreign key ([cod_pedido]) references pedido(cod_pedido), 
	constraint [FK_produto] foreign key ([cod_produto]) references produto(cod_produto)
);
create unique index [IPK_itens_pedido] on [itens_pedido]([cod_itens_pedido]); 

-- criando tabela estoque 
create table [estoque]
(
	[cod_estoque] integer not null,
	[cod_produto] integer not null,
	[cod_loja] integer not null,
	[qnt_produto] int not null, 
	constraint [PK_estoque] primary key ([cod_estoque]), 
	constraint [FK_produto] foreign key ([cod_produto]) references produto(cod_produto), 
	constraint [FK_loja] foreign key ([cod_loja]) references loja(cod_loja)
); 
create unique index [IPK_estoque] on [estoque]([cod_estoque]);

-- Inserindo na tabela loja
insert into loja (cod_loja, nome, endereco, telefone)
values (1, 'Bedidas do Ze', 'Rua Francisco Dias 1217', '(31)93245-5975'); 

-- Inserindo na tabela loja
insert into loja (cod_loja, nome, endereco, telefone)
values (2, 'Ze Bebidas', 'Rua Sete de Setembro 309', '(31)3397-5689'); 

-- Inserindo na tabela loja
insert into loja (cod_loja, nome, endereco, telefone)
values (3, 'Distribuidora Dois Irmãos', 'Av.Roberto Carlos 574', '(31)3032-8543'); 

-- Inserindo na tabela loja
insert into loja (cod_loja, nome, endereco, telefone)
values (4, 'José Delivery', 'Rua Maria Lucia 85', '(31)3254-7521'); 

-- Inserindo na tabela fornecedor
insert into fornecedor (cod_fornecedor, nome, email, endereco, cnpj, telefone)
values (1, 'Ambev', 'ambev@gmail.com', 'Av.São Paulo 3975', '34.526.544/0001-00', '(11)98374-8563');

-- Inserindo na tabela fornecedor
insert into fornecedor (cod_fornecedor, nome, email, endereco, cnpj, telefone)
values (2, 'Coca-Cola', 'cocacola@gmail.com', 'Rua Rio de Janeiro 932', '05.327.975/0007-04', '(11)93478-2956');
	
-- Inserindo na tabela fornecedor
insert into fornecedor (cod_fornecedor, nome, email, endereco, cnpj, telefone)
values (3, 'Heineken', 'heineken@.com.br', 'Av.Santa Maria 7492', '87.328.298/0003-00', '(11)94236-3896');	
	
-- Inserindo na tabela fornecedor
insert into fornecedor (cod_fornecedor, nome, email, endereco, cnpj, telefone)
values (4, 'Smirnoff', 'smirnoff@hotmail.com', 'Rua Juscelino Kubitschek 432', '95.894.822/0000-11', '(11)91854-7392');	
	
-- Inserindo na tabela usuario 
insert into usuario (cod_usuario, login, senha, email)
values (1, 'ana_luiza03', 'Alz2003*', 'analuiza2003@hotmail.com');

-- Inserindo na tabela usuario 
insert into usuario (cod_usuario, login, senha, email)
values (2, 'feliperr', 'Flpe1990', 'filiperodrigues19@gmail.com');

-- Inserindo na tabela usuario 
insert into usuario (cod_usuario, login, senha, email)
values (3, 'leandro', 'Ldr9182', 'leandroalves32@hotmail.com');

-- Inserindo na tabela usuario 
insert into usuario (cod_usuario, login, senha, email)
values (4, 'maria_clara2000', 'maCL2000', 'mariaclaraa2000@gmail.com');

-- Inserindo na tabela usuario 
insert into usuario (cod_usuario, login, senha, email)
values (5, 'leticiaandrade', 'LetANDde', 'leticiaandrade87@hotmail.com');

-- Inserindo na tabela usuario 
insert into usuario (cod_usuario, login, senha, email)
values (6, 'rodrigovend', 'vendRODR', 'vendedorrodrigo06@hotmail.com');

-- Inserindo na tabela usuario 
insert into usuario (cod_usuario, login, senha, email)
values (7, 'gabrielasantoss', 'SANTgabri', 'gabrielasantoss@gmail.com');

-- Inserindo na tabela usuario 
insert into usuario (cod_usuario, login, senha, email)
values (8, 'adrianacarol', 'ADRcarol', 'vend_adrianacarolina@gmail.com');

-- Inserindo na tabela cliente
insert into cliente (cod_cliente, cod_usuario, nome, cfp, endereco, telefone)
values (1, 1, 'Ana Luiza', '195.032.694-56', 'Rua Floriano Rodrigues 15', '(31)96384-8462');

-- Inserindo na tabela cliente
insert into cliente (cod_cliente, cod_usuario, nome, cfp, endereco, telefone)
values (2, 2, 'Felipe Rodrigues', '115.670.032-32', 'Av. João Soares 302', '(31)92384-0384');

-- Inserindo na tabela cliente
insert into cliente (cod_cliente, cod_usuario, nome, cfp, endereco, telefone)
values (3, 3, 'Leandro Alves', '345.043.558-33', 'Rua Casablanca 89', '(31)99384-4658');

-- Inserindo na tabela cliente
insert into cliente (cod_cliente, cod_usuario, nome, cfp, endereco, telefone)
values (4, 4, 'Maria Clara', '123.012.557-89', 'Rua Florença 532', '(31)98652-7349');

-- Inserindo na tabela vendedor
insert into vendedor (cod_vendedor, cod_usuario, cod_loja, nome, cpf, endereco, tefelone, admin)
values (1, 5, 1, 'Leticia Andrade', '193.837.047-93', 'Rua Monteiro Lobato 722', '(31)93847-8342', false); 

-- Inserindo na tabela vendedor
insert into vendedor (cod_vendedor, cod_usuario, cod_loja, nome, cpf, endereco, tefelone, admin)
values (2, 6, 2, 'Rodrigo Andre', '114.942.092-67', 'Av. Antonio Francisco Lisboa', '(31)93486-9234', true); 

-- Inserindo na tabela vendedor
insert into vendedor (cod_vendedor, cod_usuario, cod_loja, nome, cpf, endereco, tefelone, admin)
values (3, 7, 3, 'Gabriela Santos', '139.085.553-84', 'Av. Fleming 13', '(31)97453-9384', false); 

-- Inserindo na tabela vendedor
insert into vendedor (cod_vendedor, cod_usuario, cod_loja, nome, cpf, endereco, tefelone, admin)
values (4, 8, 4, 'Adriana Carolina', '463.849.039-99', 'Rua Trento 119', '(31)99365-8374', true); 

-- Inserindo na tabela produto 
insert into produto (cod_produto, cod_fornecedor, nome, vlr_prouto)
values (1, 1, 'Brahma 600ml', '8.50'); 

-- Inserindo na tabela produto 
insert into produto (cod_produto, cod_fornecedor, nome, vlr_prouto)
values (2, 2, 'Coca-Cola 2l', '12.00'); 

-- Inserindo na tabela produto 
insert into produto (cod_produto, cod_fornecedor, nome, vlr_prouto)
values (3, 3, 'Heineken 473ml', '7.25'); 

-- Inserindo na tabela produto 
insert into produto (cod_produto, cod_fornecedor, nome, vlr_prouto)
values (4, 4, 'Smirnoff Ice 275ml', '8.75'); 

-- Inserindo na tabela estoque
insert into estoque (cod_estoque, cod_produto, cod_loja, qnt_produto)
values (1, 1, 3, '70');

-- Inserindo na tabela estoque
insert into estoque (cod_estoque, cod_produto, cod_loja, qnt_produto)
values (2, 2, 4, '144');

-- Inserindo na tabela estoque
insert into estoque (cod_estoque, cod_produto, cod_loja, qnt_produto)
values (3, 4, 1, '84');

-- Inserindo na tabela estoque
insert into estoque (cod_estoque, cod_produto, cod_loja, qnt_produto)
values (4, 3, 2, '320');

-- Inserindo na tabela pedido
insert into pedido (cod_pedido, cod_cliente, cod_vendedor, cod_loja, status, tempo_espera, vlr_pedido, data_pedido)
values (1, 3, 2, 2, 'Pedido Entregue', '00:23:40', '61.25', '2023-10-10');

-- Inserindo na tabela pedido
insert into pedido (cod_pedido, cod_cliente, cod_vendedor, cod_loja, status, tempo_espera, vlr_pedido, data_pedido)
values (2, 1, 4, 1, 'Pedido a Caminho', '01:15:53', '48.00', '2023-09-20');

-- Inserindo na tabela pedido
insert into pedido (cod_pedido, cod_cliente, cod_vendedor, cod_loja, status, tempo_espera, vlr_pedido, data_pedido)
values (3, 4, 1, 3, 'Pedido em Preparação', '00:35:21', '161.50', '2023-11-03');

-- Inserindo na tabela pedido
insert into pedido (cod_pedido, cod_cliente, cod_vendedor, cod_loja, status, tempo_espera, vlr_pedido, data_pedido)
values (4, 2, 3, 4, 'Pedido Entregue', '00:18:39', '174.00', '2023-10-09');

-- Inserindo na tabela itens_pedido
insert into itens_pedido (cod_itens_pedido, cod_pedido, cod_produto, qnt_produto)
values (1, 4, 3, '24'); 

-- Inserindo na tabela itens_pedido
insert into itens_pedido (cod_itens_pedido, cod_pedido, cod_produto, qnt_produto)
values (2, 1, 4, '7');  

-- Inserindo na tabela itens_pedido
insert into itens_pedido (cod_itens_pedido, cod_pedido, cod_produto, qnt_produto)
values (3, 3, 1, '19'); 

-- Inserindo na tabela itens_pedido
insert into itens_pedido (cod_itens_pedido, cod_pedido, cod_produto, qnt_produto)
values (4, 2, 2, '4');

-- Inserindo na tabela relatorio 
insert into relatorio (cod_relatorio, cod_loja, vlr_total, data_inicio, data_fim)
values (1, 4, '174.00', '2023-10-01', '2023-10-31');

-- Inserindo na tabela relatorio 
insert into relatorio (cod_relatorio, cod_loja, vlr_total, data_inicio, data_fim)
values (2, 2, '61.25', '2023-10-01', '2023-10-31');

-- Inserindo na tabela relatorio 
insert into relatorio (cod_relatorio, cod_loja, vlr_total, data_inicio, data_fim)
values (3, 1, '48.00', '2023-09-01', '2023-09-31');

-- Inserindo na tabela relatorio 
insert into relatorio (cod_relatorio, cod_loja, vlr_total, data_inicio, data_fim)
values (4, 3, '00.00', '2023-10-01', '2023-10-31');

-- update da tabela loja
update loja set nome = 'Bebidas do Zeca' where cod_loja =1; 
update loja set endereco = 'Rua Sete de Setembro 1945' where cod_loja =2;
update loja set endereco = 'Av. Carlos Braga 1941' where cod_loja = 3;
update loja set telefone  = '(31)3476-9846' where cod_loja = 4;

-- update da tabela fornecedor 
update fornecedor set nome = 'Ambev S.A' where cod_fornecedor =1; 
update fornecedor set nome = 'Coca-Cola FEMSA' where cod_fornecedor =2; 
update fornecedor set endereco  = 'Rua das Perobas 301' where cod_fornecedor =3; 
update fornecedor set cnpj  = '05.254.957/0001-89' where cod_fornecedor =3; 

-- update da tabela usuario 
update usuario set senha = 'alnZ3002' where cod_usuario =1;
update usuario set email = 'claramaria2000@hotmail.com' where cod_usuario =4;
update usuario set login = 'santos_gabi' where cod_usuario =7;
update usuario set cod_usuario = 9 where cod_usuario =8;

-- update na tabela cliente 
update cliente set telefone = '(31)99792-0773' where cod_cliente = 1;
update cliente set cfp = '511.067.320-23' where cod_cliente = 2;
update cliente set endereco = 'Rua Toronto 309' where cod_cliente =3;
update cliente set nome = 'Clara Maria' where cod_cliente =4;

-- update na tabela vendedor 
update vendedor set admin = true where cod_vendedor =1; 
update vendedor set cod_loja = 3 where cod_vendedor =2;
update vendedor set cod_loja = 2 where cod_vendedor =3;
update vendedor set cpf = '364.048.930-99' where cod_vendedor =4;
update vendedor set cod_usuario = 9 where cod_vendedor =4;

-- update na tabela produto 
update produto set nome = 'Chopp Brahma 600ml' where cod_produto =1;
update produto set vlr_prouto = 11.50 where cod_produto =2;
update produto set nome = 'Cerveja Heineken 473ml' where cod_produto =3;
update produto set cod_produto = 5 where cod_produto =4;

-- update na tabela estoque 
update estoque set cod_loja = 4 where cod_estoque =1;
update estoque set cod_loja = 3 where cod_estoque =2;
update estoque set cod_produto = 5 where cod_estoque =3;
update estoque set qnt_produto = 327 where cod_estoque = 4;

-- update na tabela pedido
update pedido set data_pedido = '2023-10-20' where cod_pedido =1;
update pedido set vlr_pedido = 57.50 where cod_pedido =2;
update pedido set status = 'Pedido Entregue' where cod_pedido =3;
update pedido set tempo_espera = '00:20:47' where cod_pedido =4;
update pedido set vlr_pedido = 78.75 where cod_pedido =1;

-- update na tabela itens_pedido

update itens_pedido set qnt_produto = 5 where cod_itens_pedido =4; 
update itens_pedido set qnt_produto = 9 where cod_itens_pedido =2; 
update itens_pedido set cod_produto = 5 where cod_itens_pedido =2;
update itens_pedido set cod_itens_pedido = 5 where cod_itens_pedido =4;

-- update na tabela relatorio 
update relatorio set vlr_total = 57.50 where cod_relatorio =1;
update relatorio set cod_relatorio = 4 where cod_relatorio =3;
update relatorio set vlr_total = 78.75 where cod_relatorio =2;
update relatorio set cod_relatorio = 5 where cod_relatorio =4;

-- select na tabela loja
select * from loja l;
select * from loja l where nome like '%bebidas do zeca';
select * from loja l where endereco like '%rua maria lucia%';
select * from loja l where telefone like '(31)3032-8543%';

-- select na tabela fornecedor 
select * from fornecedor f ;
select * from fornecedor f where nome like '%Ambev%';
select * from fornecedor f where email like 'heineken%';
select * from fornecedor f where endereco like '%juscelino kubitschek%';

-- select na tabela usuario 
select * from usuario u ;
select * from usuario u where login like 'leticiaandrade%';
select * from usuario u where email like 'vendedorrodrigo06@hotmail.com%';
select * from usuario u where senha like 'adrcarol%';

-- select na tabela cliente
select * from cliente c ;
select * from cliente c where nome like '%Felipe%';
select * from cliente c where telefone like '%(31)99792-0773%';
select * from cliente c where endereco like '%toronto%';

-- select na tabela produto 
select * from produto p;
select * from produto p where nome like '%heineken%';
select * from produto p where cod_produto like 5;
select * from produto p where cod_fornecedor like 2;

-- select na tabela vendedor 
select * from vendedor v;
select * from vendedor v where nome like '%gabriela%';
select * from vendedor v where cod_usuario like 9;
select * from vendedor v where cpf like '%114%';

-- select na tabela estoque
select * from estoque e;
select * from estoque e where qnt_produto like '%70';
select * from estoque e where cod_estoque like 2;
select * from estoque e where cod_loja like 1;

-- select na tabela relatorio 
select * from relatorio r;
select * from relatorio r where vlr_total like '%57%';
select * from relatorio r where vlr_total like '%78%';
select * from relatorio r where cod_loja  like 3;

-- select na tabela pedido 
select * from pedido p; 
select * from pedido p where tempo_espera like '%23%';
select * from pedido p where cod_vendedor like 4;
select * from pedido p where vlr_pedido like '%161%';

-- select na tabela itens_pedido
select * from itens_pedido ip;
select * from itens_pedido ip where cod_itens_pedido like 5;
select * from itens_pedido ip where qnt_produto like '%24';
select * from itens_pedido ip where cod_pedido like 2;

-- delete para a tabela loja
delete from loja where cod_loja =1;
delete from loja where cod_loja =2;
delete from loja where cod_loja =3;
delete from loja where cod_loja =4;

-- delete para a tebela fornecedor
delete from fornecedor where cod_fornecedor =1;
delete from fornecedor where cod_fornecedor =2;
delete from fornecedor where cod_fornecedor =3;
delete from fornecedor where cod_fornecedor =4;

-- delete para a tabela usuario
delete from usuario where cod_usuario =1;
delete from usuario where cod_usuario =2;
delete from usuario where cod_usuario =3;
delete from usuario where cod_usuario =4;

-- delete para a tabela relatorio 
delete from relatorio where cod_relatorio =1;
delete from relatorio where cod_relatorio =2;
delete from relatorio where cod_relatorio =3;
delete from relatorio where cod_relatorio =4;

-- delete para a tabela cliente
delete from cliente where cod_cliente =1;
delete from cliente where cod_cliente =2;
delete from cliente where cod_cliente =3;
delete from cliente where cod_cliente =4;

-- delete para a tabela produto 
delete from produto where cod_produto =1;
delete from produto where cod_produto =2;
delete from produto where cod_produto =3;
delete from produto where cod_produto =4;

-- delete para a tabela estoque
delete from estoque where cod_estoque =1;
delete from estoque where cod_estoque =2;
delete from estoque where cod_estoque =3;
delete from estoque where cod_estoque =4;

-- delete para a tabela vendedor
delete from vendedor where cod_vendedor =1;
delete from vendedor where cod_vendedor =2;
delete from vendedor where cod_vendedor =3;
delete from vendedor where cod_vendedor =4;

-- delete para a tabela pedido
delete from pedido where cod_pedido =1;
delete from pedido where cod_pedido =2;
delete from pedido where cod_pedido =3;
delete from pedido where cod_pedido =4;

-- delete para a tabela itens_pedido
delete from itens_pedido where cod_itens_pedido =1;
delete from itens_pedido where cod_itens_pedido =2;
delete from itens_pedido where cod_itens_pedido =3;
delete from itens_pedido where cod_itens_pedido =4;

-- inner join 
-- 1 -- quero recuperar todos os pedidos feitos no ze_delivery até o momento 
select p.cod_pedido, c.nome as nome_cliente, v.nome as nome_vendedor, l.nome as nome_loja, 
p.status, p.tempo_espera, p.vlr_pedido, p.data_pedido
from pedido p 
inner join cliente c on c.cod_cliente = p.cod_cliente 
inner join vendedor v on v.cod_vendedor = p.cod_vendedor 
inner join loja l on l.cod_loja = p.cod_loja;

-- 2 -- quero todos os produtos em estoque
select e.cod_estoque, p.nome as nome_produto, l.nome as nome_loja, qnt_produto
from estoque e 
inner join produto p on p.cod_produto = e.cod_produto 
inner join loja l on l.cod_loja = e.cod_loja;

-- 3 -- quero saber quais usuarios são clientes
select u.cod_usuario, c.nome as nome_cliente, u.login as nome_usuario
from usuario u
inner join cliente c on c.cod_cliente = u.cod_usuario;

-- 4 -- quero saber quais vendedores possuem permissão de ADMIN
select v.cod_vendedor, l.nome as nome_loja, v.nome as nome_vendedor, v.cpf, v.admin as permissao_ADIM
from vendedor v 
inner join vendedor v2 on v.admin = true
inner join loja l on l.cod_loja = v.cod_loja
group by v.nome;

-- 5 -- quero saber quais usuarios são vendedores
select u.cod_usuario, v.nome as nome_vendedor, u.login as nome_vendedor, v.admin as permissao_ADIM 
from usuario u
inner join vendedor v on v.cod_usuario = u.cod_usuario;

-- 6 -- quero recuperar os produtos mais vendidos 
select p.nome as nome_produto, ip.qnt_produto as quant_vendida, p2.vlr_pedido as vlr_total_vendido
from itens_pedido ip 
inner join produto p on p.cod_produto =ip.cod_produto 
inner join pedido p2 on p2.cod_pedido = ip.cod_pedido
order by p2.vlr_pedido desc;

-- 7 -- quero a loja que mais vendeu
select l.nome as nome_loja, max (vlr_pedido) as valor_vendido 
from pedido p 
inner join loja l on l.cod_loja = p.cod_loja;

-- 8 -- quero saber o pedido que mais demorou
select max (tempo_espera) as tempo_espera, p.status, p.vlr_pedido, 
l.nome as nome_loja, v.nome as nome_vendedor, p2.nome as nome_produto
from pedido p
inner join loja l on l.cod_loja = p.cod_loja 
inner join vendedor v on v.cod_vendedor = p.cod_vendedor
inner join produto p2 on p2.cod_produto;












	