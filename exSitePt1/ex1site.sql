CREATE DATABASE exsite1
GO
USE exsite1

CREATE TABLE aluno(
	ra			INT			NOT NULL,
	nome		VARCHAR(50)	NOT NULL,
	sobrenome	VARCHAR(50) NOT NULL,
	rua			VARCHAR(70) NOT NULL,
	num			INT			NOT NULL,
	bairro		VARCHAR(70) NOT NULL,
	cep			INT			NOT NULL,
	telefone	INT
)

CREATE TABLE cursos(
	cod				INT			NOT NULL,
	nome			VARCHAR(50)	NOT NULL,
	carga_horaria	INT			NOT NULL,
	turno			VARCHAR(15) NOT NULL
)

CREATE TABLE disciplina(
	cod				INT			NOT NULL,
	nome			VARCHAR(50)	NOT NULL,
	carga_horaria	INT			NOT NULL,
	turno			VARCHAR(15)	NOT NULL,
	semestre		INT			NOT NULL
)

INSERT INTO aluno VALUES
	(12345, 'Jos�', 'Silva', 'Almirante Noronha', 236, 'Jardim S�o Paulo', '1589000', '69875287'),
	(12346, 'Ana', 'Maria Bastos', 'Anhaia', 1568, 'Barra Funda', '3569000', '25698526'),
	(12347, 'Mario', 'Santos', 'XV de Novembro', 1841, 'Centro', '1020030', null),
	(12348, 'Marcia', 'Neves', 'Volunt�rios da Patria', 225, 'Santana', '2785090', '78964152')

INSERT INTO cursos VALUES
	(1, 'Inform�tica', 2800, 'Tarde'),
	(2, 'Inform�tica', 2800, 'Noite'),
	(3, 'Log�stica', 2650, 'Tarde'),
	(4, 'Log�stica', 2650, 'Noite'),
	(5, 'Pl�sticos', 2500, 'Tarde'),
	(6, 'Pl�sticos', 2500, 'Noite')

INSERT INTO disciplina VALUES
	(1, 'Inform�tica', 4, 'Tarde', 1),
	(2, 'Inform�tica', 4, 'Noite', 1),
	(3, 'Quimica', 4, 'Tarde', 1),
	(4, 'Quimica', 4, 'Noite', 1),
	(5, 'Banco de Dados I', 2, 'Tarde', 3),
	(6, 'Banco de Dados I', 2, 'Noite', 3),
	(7, 'Estrutura de Dados', 4, 'Tarde', 4),
	(8, 'Estrutura de Dados', 4, 'Noite', 4)

/*1*/
SELECT nome + ' ' + sobrenome AS nome_completo FROM aluno

/*2*/
SELECT rua + ', ' + CAST(num AS VARCHAR(4)) + ' ' 
+ SUBSTRING(CAST(cep AS VARCHAR), 1, 5) + '-' + SUBSTRING(CAST(cep AS VARCHAR), 6, 9)
AS endereco 
FROM aluno
WHERE telefone IS NULL

/*3*/
SELECT telefone FROM aluno WHERE ra = 12348

/*4*/
SELECT nome, turno FROM cursos WHERE carga_horaria = 2800

/*5*/
SELECT semestre FROM disciplina WHERE nome LIKE '%BANCO DE DADOS%' AND turno LIKE '%NOITE%'