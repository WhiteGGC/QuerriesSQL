CREATE DATABASE ex2selects
GO
USE ex2selects

CREATE TABLE filme(
	id			INT			NOT NULL,
	titulo		VARCHAR(40)	NOT NULL,
	ano			INT	NULL		CHECK(ano < 2021),
	PRIMARY KEY(id)
)

CREATE TABLE estrela(
	id			INT			NOT NULL,
	nome		VARCHAR(50)	NOT NULL
	PRIMARY KEY(id)
)

CREATE TABLE filme_estrela(
	filmeid		INT			NOT NULL,
	estrelaid	INT			NOT NULL,
	PRIMARY KEY (filmeid, estrelaid),
	FOREIGN KEY (filmeid)		REFERENCES filme(id),
	FOREIGN KEY (estrelaid)		REFERENCES estrela(id)
)

CREATE TABLE dvd(
	num			INT			NOT NULL,
	data_fabricacao	DATETIME	NOT NULL	CHECK(data_fabricacao <	GETDATE()),
	filmeid		INT			NOT NULL,
	PRIMARY KEY (num),
	FOREIGN KEY (filmeid) REFERENCES filme(id)
)

CREATE TABLE cliente(
	num_cadastro		INT			NOT NULL,
	nome	VARCHAR(70)	NOT NULL,
	logradouro	VARCHAR(150)	NOT NULL,
	num		INT		NOT NULL	CHECK(num > 0),
	cep		VARCHAR(8)	NULL	CHECK(LEN(cep) = 8),
	PRIMARY KEY (num_cadastro)
)

CREATE TABLE locacao(
	dvdnum		INT		NOT NULL,
	clientenum_cadastro		INT		NOT NULL,
	data_locacao	DATETIME	NOT NULL	DEFAULT(GETDATE()),
	data_devolucao		DATETIME	NOT NULL,
	valor	DECIMAL(7, 2)	NOT NULL	CHECK(valor > 0),
	PRIMARY	KEY (data_locacao, dvdnum, clientenum_cadastro),
	FOREIGN KEY (dvdnum) REFERENCES dvd(num),
	FOREIGN KEY (clientenum_cadastro) REFERENCES cliente(num_cadastro),
	CONSTRAINT chk_dt CHECK (data_devolucao > data_locacao)
)

ALTER TABLE estrela
ADD nome_real VARCHAR(50) NULL

ALTER TABLE filme
ALTER COLUMN titulo VARCHAR(80) NOT NULL 

INSERT INTO filme (id, titulo, ano) VALUES
	(1001, 'Whiplash', 2015),
	(1002, 'Birdman', 2015),
	(1003, 'Interestelar', 2014),
	(1004, 'A Culpa � das estrelas', 2014),
	(1005, 'Alexandre e o Dia Terr�vel, Horr�vel, Espantoso e Horroroso', 2014),
	(1006, 'Sing', 2016)

INSERT INTO estrela (id, nome, nome_real) VALUES
	(9901, 'Michael Keaton', 'Michael John Douglas'),
	(9902, 'Emma Stone Emily', 'Jean Stone'),
	(9903, 'Miles Teller', NULL),
	(9904, 'Steve Carell', 'Steven John Carell'),
	(9905, 'Jennifer Garner', 'Jennifer Anne Garner')

INSERT INTO filme_estrela (filmeid, estrelaid) VALUES
	(1002, 9901),
	(1002, 9902),
	(1001, 9903),
	(1005, 9904),
	(1005, 9905)

INSERT INTO	dvd VALUES
	(10001, '2020-02-12', 1001),
	(10002, '2019-18-10', 1002),
	(10003, '2020-03-04', 1003),
	(10004, '2020-02-12', 1001),
	(10005, '2019-18-10', 1004),
	(10006, '2020-03-04', 1002),
	(10007, '2020-02-12', 1005),
	(10008, '2019-18-10', 1002),
	(10009, '2020-03-04', 1003)

INSERT INTO cliente (num_cadastro, nome, logradouro, num, cep) VALUES
	(5501, 'Matilde Luz', 'Rua S�ria', 150, '03086040'),
	(5502, 'Carlos Carreiro', 'Rua Bartolomeu Aires', 1250, '04419110'),
	(5503, 'Daniel Ramalho', 'Rua Itajutiba', 169, NULL),
	(5504, 'Roberta Bento', 'Rua Jayme Von Rosenburg', 36, NULL),
	(5505, 'Rosa Cerqueira', 'Rua Arnaldo Sim�es Pinto', 235, '02917110')

INSERT INTO locacao VALUES
	(10001, 5502, '2021-18-02', '2021-21-02', 3.50),
	(10009, 5502, '2021-18-02', '2021-21-02', 3.50),
	(10002, 5503, '2021-18-02', '2021-19-02', 3.50),
	(10002, 5505, '2021-20-02', '2021-23-02', 3.00),
	(10004, 5505, '2021-20-02', '2021-23-02', 3.00),
	(10005, 5505, '2021-20-02', '2021-23-02', 3.00),
	(10001, 5501, '2021-24-02', '2021-26-02', 3.50),
	(10008, 5501, '2021-24-02', '2021-26-02', 3.50)

UPDATE cliente
SET cep = '08411150'
WHERE num_cadastro = 5503

UPDATE cliente
SET cep = '02918190'
WHERE num_cadastro = 5504

UPDATE locacao
SET valor = 3.25
WHERE data_locacao = '2021-18-02' AND clientenum_cadastro = 5502

UPDATE locacao
SET valor = 3.10
WHERE data_locacao = '2021-24-02' AND clientenum_cadastro = 5501

UPDATE dvd
SET data_fabricacao = '2019-14-07'
WHERE num = 10005

UPDATE estrela
SET nome_real = 'Miles Alexander Teller'
WHERE nome = 'Miles Teller'

DELETE filme
WHERE titulo = 'Sing'

/*1*/
SELECT TOP 4 cl.num_cadastro, cl.nome, fm.titulo,
lc.valor, MAX(dvd.data_fabricacao) AS maior_data
FROM cliente cl, filme fm, locacao lc, dvd
WHERE cl.num_cadastro = lc.clientenum_cadastro
AND dvd.num = lc.dvdnum
AND fm.id = dvd.filmeid
GROUP BY dvd.data_fabricacao, cl.num_cadastro, cl.nome, dvd.num, fm.titulo, lc.valor
ORDER BY dvd.data_fabricacao DESC

/*2*/
SELECT CONVERT(VARCHAR(10) , lc.data_locacao, 103) AS data_locacao, cl.num_cadastro, cl.nome,
COUNT (lc.dvdnum) as qtn
FROM cliente cl, locacao lc
WHERE lc.clientenum_cadastro = cl.num_cadastro 
GROUP BY lc.data_locacao, cl.num_cadastro, cl.nome
ORDER BY lc.data_locacao

/*3*/
SELECT cl.num_cadastro, cl.nome, CONVERT(VARCHAR(10) , lc.data_locacao, 103) AS data_locacao,
SUM (lc.valor) as valor_total
FROM cliente cl, locacao lc
WHERE cl.num_cadastro = lc.clientenum_cadastro
GROUP BY cl.num_cadastro, cl.nome, lc.data_locacao
ORDER BY lc.data_locacao

/*4*/
SELECT cl.num_cadastro, cl.nome, cl.logradouro + ', ' + CAST(cl.num as VARCHAR(04)) AS endereco,
CONVERT(VARCHAR(10) , lc.data_locacao, 103) AS data_locacao
FROM cliente cl, locacao lc
WHERE cl.num_cadastro = lc.clientenum_cadastro
GROUP BY cl.num_cadastro, cl.nome, lc.data_locacao,
cl.logradouro, cl.num 
HAVING COUNT(lc.dvdnum) > 2