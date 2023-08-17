CREATE DATABASE livraria;

CREATE TABLE
    IF NOT EXISTS cliente (
        idcliente serial PRIMARY KEY,
        endereco varchar(45) NOT NULL,
        contato varchar(12) NOT NULL,
        nome varchar(70)
    );

CREATE TABLE
    IF NOT EXISTS pessoafisica (
        idpessoafisica serial PRIMARY KEY,
        cpf varchar(11),
        idclientefk int REFERENCES cliente(idcliente)
    );

CREATE TABLE
    IF NOT EXISTS pessoajuridica (
        idpessoajuridica serial PRIMARY KEY,
        cnpj varchar(14),
        nomefantasia varchar(60),
        idclientefk int REFERENCES cliente(idcliente)
    );

CREATE TABLE
    IF NOT EXISTS editora (
        ideditora serial PRIMARY KEY,
        endereco varchar(50),
        telefone varchar(20),
        nomegerente varchar(30)
    );

CREATE TABLE
    IF NOT EXISTS livros (
        idlivro serial PRIMARY KEY,
        isbn varchar(50) UNIQUE,
        id_editora int REFERENCES editora(ideditora),
        quantidade int,
        nome varchar(30),
        assunto varchar(20),
        autor varchar(40)
    );

CREATE TABLE
    IF NOT EXISTS compras (
        idvenda serial PRIMARY KEY,
        id_cliente int REFERENCES cliente(idcliente),
        id_livro int REFERENCES livros(idlivro),
        datavenda TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

INSERT INTO
    cliente (endereco, contato, nome)
VALUES (
        'Rua do Comércio II',
        '92983663239',
        'Rosa Vitória Patrícia Jesus'
    ), (
        'Rua Pedro Soares',
        '8439627207',
        'Sophia Carolina Nicole'
    ), (
        'Rua Juazeiro',
        '67986905697',
        'Fátima Caroline Esther Almeida'
    ), (
        'Rua José de Mello Lima',
        '51992224110',
        'Erick Mário Samuel Almeida'
    ), (
        'Rua Angelini',
        '1237083935',
        'Clara e Cecília Buffet Ltda'
    ), (
        'Rua dos Girassóis',
        '1935958584',
        'Antônia e Eliane Comercio de Bebidas Ltda'
    ), (
        'Rua Pedro Molina',
        '1635530272',
        'Marcelo e Tereza Construções Ltda'
    ), (
        'Rua São João',
        '16997480641',
        'Kaique e Renan Telas Ltda'
    );

INSERT INTO
    pessoafisica (cpf, idclientefk)
VALUES ('57333236200', 1), ('70425495469', 2), ('91339208695', 3), ('13788976845', 4);

INSERT INTO
    pessoajuridica (
        cnpj,
        nomefantasia,
        idclientefk
    )
VALUES ('35649166000118', NULL, 5), ('64488371000147', NULL, 6), ('25386159000117', NULL, 7), ('93949104000128', NULL, 8);

INSERT INTO
    editora (
        endereco,
        telefone,
        nomegerente
    )
VALUES (
        'Rua Bela Cintra, 986 - 4º andar',
        '1130878848',
        'Jorge Araujo da Silva'
    ), (
        'Rua do Passeio, 38 – 11º andar, Centro',
        '2135252000',
        'Carla Andreia Souza'
    ), (
        'RUA FUNCHAL, 538 - CONJUNTOS 52 E 54',
        '1138684492',
        'Leandro dos Santos'
    );

INSERT INTO
    livros (
        isbn,
        id_editora,
        quantidade,
        nome,
        assunto,
        autor
    )
VALUES (
        '9788525428806',
        3,
        13,
        'Dexter: a mão esquerda de Deus',
        ' Romance policial',
        'Jeff Lindsay'
    ), (
        '97884342938252',
        2,
        76,
        'A exaustão no topo da montanha',
        'Psicoterapia',
        'Alexandre Coimbra Amaral'
    ), (
        '978212320893',
        1,
        85,
        'PERTO DO CORAÇÃO SELVAGEM',
        'Romance',
        'CLARICE LISPECTOR'
    ), (
        '86522457996',
        2,
        96,
        'REINO TRANSCENDENTE',
        'ficção estrangeira',
        'YAA GYASI'
    ), (
        '565867656534',
        3,
        32,
        'GRAÇA E O ANJO DO NATAL',
        'LITERATURA INFANTIL',
        'HARRY WHITTAKER'
    ), (
        '4346456859340',
        1,
        76,
        'O DESEJO',
        'Romance',
        'Nicholas Sparks'
    );

INSERT INTO
    compras (
        id_cliente,
        id_livro,
        datavenda
    )
VALUES (1, 2, now()), (2, 2, now()), (1, 3, now()), (3, 4, now()), (5, 6, now()), (7, 5, now()), (8, 1, now());

SELECT idlivro, nome, assunto, autor FROM livros ORDER BY nome;

SELECT
    cliente.idcliente,
    cliente.nome,
    pessoafisica.cpf,
    cliente.contato
FROM pessoafisica
    JOIN cliente ON pessoafisica.idclientefk = cliente.idcliente;

SELECT
    cliente.idcliente,
    cliente.nome
FROM cliente
    JOIN compras ON cliente.idcliente = compras.id_cliente;

SELECT * FROM compras;

SELECT
    cliente.idcliente,
    cliente.nome,
    compras.id_livro,
    livros.nome,
    livros.autor,
    compras.datavenda
FROM cliente
    JOIN compras ON cliente.idcliente = compras.id_cliente
    JOIN livros ON livros.idlivro = compras.id_livro
ORDER BY cliente.nome;