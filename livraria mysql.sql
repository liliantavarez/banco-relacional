create database livraria;
use livraria;

create table if not exists cliente(
  idCliente int NOT NULL AUTO_INCREMENT,
  endereco varchar(45) NOT NULL,
  contato varchar(12) NOT NULL,
  PRIMARY KEY (idCliente)
);

alter table cliente add column nome varchar(70) after idcliente;

select * from cliente;
describe cliente;

create table if not exists pessoafisica(
idPessoaFisica int,
cpf varchar(11),
foreign key (idPessoaFisica) references cliente (idCliente)
);

select * from pessoafisica;

CREATE TABLE if not exists pessoajuridica(
	idPessoaJuridica int,
    cnpj varchar(14),
    nomefantasia varchar(60),
    razaosocial varchar(60),
    foreign key (idPessoaJuridica) references cliente(idCliente)
);

describe pessoajuridica;

alter table pessoajuridica drop column razaosocial;

INSERT INTO cliente VALUES ('1','Rosa Vitória Patrícia Jesus','Rua do Comércio II','92983663239'),
						   ('2','Sophia Carolina Nicole','Rua Pedro Soares','8439627207'),
                           ('3','Fátima Caroline Esther Almeida','Rua Juazeiro','67986905697'),
                           ('4','Erick Mário Samuel Almeida','Rua José de Mello Lima','51992224110'),
                           ('5','Clara e Cecília Buffet Ltda','Rua Angelini','1237083935'),
                           ('6','Antônia e Eliane Comercio de Bebidas Ltda','Rua dos Girassóis','1935958584'),
                           ('7','Marcelo e Tereza Construções Ltda','Rua Pedro Molina','1635530272'),
                           ('8','Kaique e Renan Telas Ltda','Rua São João','16997480641');
                           
INSERT INTO pessoafisica(idpessoafisica, cpf) VALUES ('1','57333236200'),
													 ('2','70425495469'),
                                                     ('3','91339208695'),
                                                     ('4','13788976845');

INSERT INTO pessoajuridica (idPessoajuridica, cnpj) VALUES ('5','35649166000118'),
													    	('6','64488371000147'),
                                                            ('7','25386159000117'),
                                                            ('8','93949104000128');
select * from cliente;

select cliente.idcliente,cliente.nome,pessoafisica.cpf,cliente.contato 
from pessoafisica 
join cliente 
on pessoafisica.idpessoafisica = cliente.idcliente;
                                                                
select cliente.idcliente, cliente.nome, pessoajuridica.cnpj from pessoajuridica 
join cliente on pessoajuridica.idpessoajuridica = cliente.idcliente;

CREATE TABLE IF NOT EXISTS  editora(
idEditora int primary key auto_increment not null,
endereco varchar(50),
telefone varchar(20),
nomegerente varchar(30)
);

insert into editora (idEditora,endereco,telefone,nomegerente) 
values (default,'Rua Bela Cintra, 986 - 4º andar','1130878848','Jorge Araujo da Silva'),
(default,'Rua do Passeio, 38 – 11º andar, Centro','2135252000','Carla Andreia Souza'),
(default,'RUA FUNCHAL, 538 - CONJUNTOS 52 E 54','1138684492','Leandro dos Santos');

create table if not exists livros(
idLivro int not null primary key AUTO_INCREMENT,
isbn varchar(50) unique not null,
id_editora int,
quantidade int,
nome varchar(30),
assunto varchar(20),
autor varchar(40),
foreign key (id_editora) references editora (idEditora)
);

insert into livros (idLivro,isbn,id_editora,quantidade,nome,assunto,autor) 
values (default,'9788525428806','3','13','Dexter: a mão esquerda de Deus',' Romance policial','Jeff Lindsay'),
(default,'97884342938252','2','76','A exaustão no topo da montanha','Psicoterapia','Alexandre Coimbra Amaral'),
(default,'978212320893','1','85','PERTO DO CORAÇÃO SELVAGEM','Romance','CLARICE LISPECTOR'),
(default,'86522457996','2','96','REINO TRANSCENDENTE','ficção estrangeira','YAA GYASI'),
(default,'565867656534','3','32','GRAÇA E O ANJO DO NATAL','LITERATURA INFANTIL','HARRY WHITTAKER'),
(default,'4346456859340','1','76','O DESEJO','Romance','Nicholas Sparks');

create table if not exists compras(
 idVenda int not null auto_increment primary key,
 id_cliente int,
 id_livro int,
 datavenda TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 foreign key(id_cliente) references cliente(idCliente),
 foreign key (id_livro) references livros(idLivro)
);

insert into compras(idVenda,id_cliente,id_livro,datavenda)
values (default,'1','2',default),(default,'2','2',default),(default,'1','3',default),(default,'3','4',default),(default,'5','6',default),(default,'7','5',default),(default,'8','1',default);

select idLivro, nome, assunto,autor from livros order by nome;

select cliente.idcliente,cliente.nome,pessoafisica.cpf,cliente.contato 
from pessoafisica 
join cliente 
on pessoafisica.idpessoafisica = cliente.idcliente;

select cliente.id_cliente, cliente.nome  
from cliente
join compras
on cliente.idcliente = compras.idcliente;

select * from compras;

select cliente.idcliente,cliente.nome, compras.id_livro,livros.nome,livros.autor,compras.dataVenda from cliente
join compras 
on cliente.idCliente = compras.id_cliente
join livros
on livros.idlivro = compras.id_livro
order by cliente.nome;
