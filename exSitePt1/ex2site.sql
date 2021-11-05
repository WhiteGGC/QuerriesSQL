CREATE DATABASE exsite2
GO
USE exsite2

CREATE TABLE carro(
	placa		VARCHAR(10)	NOT NULL,
	marca		VARCHAR(50)	NOT NULL,
	modelo		VARCHAR(50) NOT NULL,
	cor			VARCHAR(20) NOT NULL,
	ano			INT			NOT NULL
	PRIMARY KEY(placa)
)

CREATE TABLE pecas(
	cod				INT			NOT NULL,
	nome			VARCHAR(50)	NOT NULL,
	valor			INT			NOT NULL
	PRIMARY KEY(cod)
)

CREATE TABLE cliente(
	nome			VARCHAR(50)	NOT NULL,
	logradouro		VARCHAR(70)	NOT NULL,
	num				INT			NOT NULL,
	bairro			VARCHAR(70)	NOT NULL,
	telefone		INT			NOT NULL,
	carro_placa		VARCHAR(10) NOT NULL
	PRIMARY KEY(carro_placa)
	FOREIGN KEY(carro_placa) REFERENCES carro(placa)
)

CREATE TABLE servico(
	carro_placa		VARCHAR(10)	NOT NULL,
	peca_cod		INT			NOT NULL,
	quantidade		INT			NOT NULL,
	valor			INT			NOT NULL,
	data			DATETIME	NOT NULL
	PRIMARY KEY(carro_placa, peca_cod, data),
	FOREIGN KEY(carro_placa) REFERENCES carro(placa),
	FOREIGN KEY(peca_cod) REFERENCES pecas(cod)
)

INSERT INTO carro VALUES
	('AFT9087', 'VW', 'Gol', 'Preto', 2007),
	('DXO9876', 'Ford', 'Ka', 'Azul', 2000),
	('EGT4631', 'Renault', 'Clio', 'Verde', 2004),
	('LKM7380', 'Fiat', 'Palio', 'Prata', 1997),
	('BCD7521', 'Ford', 'Fiesta', 'Preto', 1999)

INSERT INTO pecas VALUES
	(1, 'Vela', 70),
	(2, 'Correia Dentada', 125),
	(3, 'Trambulador', 90),
	(4, 'Filtro de Ar', 30)

INSERT INTO cliente VALUES
	('João Alves', 'R. Pereira Barreto', 1258, 'Jd. Oliveiras', 21549658, 'DXO9876'),
	('Ana Maria', 'R. 7 de Setembro', 259, 'Centro', 96588541, 'LKM7380'),
	('Clara Oliveira', 'Av. Nações Unidas', 10254, 'Pinheiros', 24589658, 'EGT4631'),
	('José Simões', 'R. XV de Novembro', 36, 'Água Branca', 78952459, 'BCD7521'),
	('Paula Rocha', 'R. Anhaia', 548, 'Barra Funda', 69582548, 'AFT9087')

INSERT INTO servico VALUES
	('DXO9876', 1, 4, 280, '01/08/2020'),
	('DXO9876', 4, 1, 30, '01/08/2020'),
	('EGT4631', 3, 1, 90, '02/08/2020'),
	('DXO9876', 2, 1, 125, '07/08/2020')

/*1*/
SELECT SUBSTRING(CAST(telefone AS VARCHAR(8)), 1, 4) + '-' + SUBSTRING(CAST(telefone AS VARCHAR(8)), 5, 8) AS telefone
FROM cliente WHERE carro_placa IN(
	SELECT placa FROM carro WHERE modelo LIKE '%Ka%' AND cor LIKE '%Azul%'
)

/*2*/
SELECT logradouro + ', ' + CAST(num as VARCHAR(5)) + ' - ' + bairro AS endereço FROM cliente
WHERE carro_placa IN(
	SELECT carro_placa FROM servico WHERE data = '02/08/2020'
)

/*3*/
SELECT placa FROM carro WHERE ano < 2001

/*4*/
SELECT marca + ' ' + modelo + ' ' + cor FROM carro WHERE ano > 2005

/*5*/
SELECT cod, nome FROM pecas WHERE valor < 80