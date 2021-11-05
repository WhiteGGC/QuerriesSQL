CREATE DATABASE exsite4
GO 
USE exsite4

CREATE TABLE cliente(
	cpf VARCHAR(15)	NOT NULL,
	nome VARCHAR(50) NOT NULL,
	telefone INT	NOT NULL
	PRIMARY KEY(cpf)
)

CREATE TABLE fornecedor(
	id	INT		NOT NULL,
	nome	VARCHAR(50)		NOT NULL,
	logradouro		VARCHAR(70)		NOT NULL,
	num		INT		NOT NULL,
	complemento		VARCHAR(50)	NOT NULL,
	cidade		VARCHAR(50)		NOT NULL
	PRIMARY KEY(id)
)

CREATE TABLE produto(
	cod		INT		NOT NULL,
	descricao	VARCHAR(150)	NOT NULL,
	fornecedor_id	INT		NOT NULL,
	preco		FLOAT		NOT NULL
	PRIMARY KEY(cod)
)

CREATE TABLE venda(
	cod		INT		NOT NULL,
	produto_cod		INT		NOT NULL,
	cliente_cpf		VARCHAR(15)		NOT NULL,
	quantidade		INT		NOT NULL,
	valor_total		FLOAT		NOT NULL,
	data		DATETIME	NOT NULL
	PRIMARY KEY(cod, produto_cod, cliente_cpf),
	FOREIGN KEY(produto_cod) REFERENCES produto(cod),
	FOREIGN KEY (cliente_cpf) REFERENCES cliente(cpf)
)

INSERT INTO cliente VALUES
	('345789092-90', 'Julio Cesar', 82736541),
	('251865337-10',	'Maria Antonia',	87652314),
	('876273154-16',	'Luiz Carlos',	61289012),
	('791826398-00',	'Paulo Cesar',	90765273)

INSERT INTO	produto VALUES
	(1,	'Monitor 19 pol.',	1,	(449.99)),
	(2,	'Netbook 1GB Ram 4 Gb HD',	2,	(699.99)),
	(3,	'Gravador de DVD - Sata',	1,	(99.99)),
	(4,	'Leitor de CD',	1,	(49.99)),
	(5,	'Processador - Phenom X3 - 2.1GHz',	3,	(349.99)),
	(6,	'Mouse', 4,	(19.99)),
	(7,	'Teclado',	4,	(25.99)),
	(8,	'Placa de Video - Nvidia 9800 GTX - 256MB/256 bits',	5,	(599.99))

INSERT INTO fornecedor VALUES
	(1,	'LG',	'Rod. Bandeirantes',	70000,	'Km 70',	'Itapeva'),
	(2,	'Asus',	'Av. Nações Unidas',	10206,	'Sala 225',	'São Paulo'),
	(3,	'AMD',	'Av. Nações Unidas',	10206,	'Sala 1095',	'São Paulo'),
	(4,	'Leadership',	'Av. Nações Unidas',	10206,	'Sala 87',	'São Paulo'),
	(5,	'Inno',	'Av. Nações Unidas',	10206,	'Sala 34',	'São Paulo')

INSERT INTO venda VALUES
	(1,	1,	'251865337-10',	1,	449.99,	'03/09/2009'),
	(1,	4,	'251865337-10',	1,	49.99,	'03/09/2009'),
	(1,	5,	'251865337-10',	1,	349.99,	'03/09/2009'),
	(2,	6,	'791826398-00',	4,	79.96,	'06/09/2009'),
	(3,	8,	'876273154-16',	1,	599.99,	'06/09/2009'),
	(3,	3,	'876273154-16',	1,	99.99,	'06/09/2009'),
	(3,	7,	'876273154-16',	1,	25.99,	'06/09/2009'),
	(4,	2,	'345789092-90',	2,	1399.98,	'08/09/2009')

SELECT CONVERT(VARCHAR(10), data, 103) FROM venda
WHERE cod = 4

ALTER TABLE fornecedor
ADD telefone INT NULL

UPDATE fornecedor
SET telefone = 72165371
WHERE id = 1

UPDATE fornecedor
SET	telefone = 87153738
WHERE id = 2

UPDATE fornecedor
SET	telefone = 36546289
WHERE id = 4

SELECT nome, logradouro + ', ' + CAST(num AS VARCHAR(2)) + ' - ' + complemento AS endereco, telefone 
FROM fornecedor ORDER BY nome ASC

SELECT produto_cod, quantidade, valor_total FROM venda WHERE cliente_cpf IN(
	SELECT cpf FROM cliente WHERE nome LIKE 'JULIO CESAR'
)

SELECT CONVERT(VARCHAR(10), data, 103) AS data, valor_total FROM venda WHERE cliente_cpf IN(
	SELECT cpf FROM cliente WHERE nome LIKE 'Paulo Cesar'
)

SELECT descricao, preco FROM produto ORDER BY preco DESC
