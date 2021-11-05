CREATE DATABASE exsite3
GO
USE exsite3

CREATE TABLE paciente(
	cpf				VARCHAR(15)	NOT NULL,
	nome			VARCHAR(50)	NOT NULL,
	rua				VARCHAR(70)	NOT NULL,
	num				INT			NOT NULL,
	bairro			VARCHAR(70)	NOT NULL,
	telefone		INT			NULL,
	data_nascimento	DATETIME	NOT NULL
	PRIMARY KEY(cpf)
)

CREATE TABLE medico(
	cod				INT			NOT NULL,
	nome			VARCHAR(50)	NOT NULL,
	especialidade	VARCHAR(50)	NOT NULL
	PRIMARY KEY(cod)
)

CREATE TABLE prontuario(
	data			DATETIME	NOT NULL,
	paciente_cpf	VARCHAR(15)	NOT NULL,
	medico_cod		INT			NOT NULL,
	diagnostico		VARCHAR(50)	NOT NULL,
	medicamento		VARCHAR(50)	NOT NULL
	PRIMARY KEY(paciente_cpf, medico_cod, data),
	FOREIGN KEY(paciente_cpf) REFERENCES paciente(cpf),
	FOREIGN KEY(medico_cod) REFERENCES medico(cod)
)

INSERT INTO paciente VALUES
	('35454562890', 'José Rubens', 'Campos Salles', 2750, 'Centro', 21450998,	'18/10/1954'),
	('29865439810', 'Ana Claudia', 'Sete de Setembro', 178, 'Centro',	97382764, '29/05/1960'),
	('82176534800', 'Marcos Aurélio', 'Timóteo Penteado', 236, 'Vila Galvão', 68172651, '24/09/1980'),
	('12386758770', 'Maria Rita', 'Castello Branco', 7765, 'Vila Rosália', NULL, '30/03/1975'),
	('92173458910', 'Joana de Souza', 'XV de Novembro', 298, 'Centro', 21276578, '24/04/1944')

INSERT INTO medico VALUES
	(1,	'Wilson Cesar',	'Pediatra'),
	(2,	'Marcia Matos',	'Geriatra'),
	(3,	'Carolina Oliveira',	'Ortopedista'),
	(4,	'Vinicius Araujo',	'Clínico Geral')

INSERT INTO prontuario VALUES
	('10/09/2020',	'35454562890',	2,	'Reumatismo',	'Celebra'),
	('10/09/2020',	'92173458910',	2,	'Renite Alérgica',	'Allegra'),
	('12/09/2020',	'29865439810',	1,	'Inflamação de garganta',	'Nimesulida'),
	('13/09/2020',	'35454562890',	2,	'H1N1',	'Tamiflu'),
	('15/09/2020',	'82176534800',	4,	'Gripe', 'Resprin'),
	('15/09/2020',	'12386758770',	3,	'Braço Quebrado',	'Dorflex + Gesso')

/*1*/
SELECT rua + ', ' + CAST(num as VARCHAR(5)) + ' - ' + bairro AS endereço FROM paciente
WHERE DATEDIFF(YEAR, data_nascimento, GETDATE()) > 50

/*2*/
SELECT especialidade FROM medico WHERE nome LIKE 'CAROLINA OLIVEIRA'

/*3*/
SELECT medicamento FROM prontuario WHERE diagnostico LIKE 'REUMATISMO'

/*4*/
SELECT diagnostico, medicamento FROM prontuario WHERE paciente_cpf IN(
	SELECT cpf FROM paciente WHERE nome LIKE 'José Rubens'
)

/*5*/
SELECT nome, SUBSTRING(especialidade, 1, 3) + '.' AS especialidade FROM medico WHERE cod IN(
	SELECT medico_cod FROM prontuario WHERE paciente_cpf IN(
		SELECT cpf FROM paciente WHERE nome LIKE 'José Rubens'
	)
)

/*6*/
SELECT DATEDIFF(DAY, data, GETDATE()) AS desde_a_consulta FROM prontuario 
WHERE paciente_cpf IN(
	SELECT cpf FROM paciente WHERE nome LIKE 'Maria Rita'
)

UPDATE paciente
SET telefone = 98345621
WHERE nome LIKE 'Maria%'

UPDATE paciente
SET rua = 'Voluntários da Pátria', num = 1980, bairro = 'Jd. Aeroporto'
WHERE nome LIKE 'JOANA%'