CREATE DATABASE exercicio1
GO
USE exercicio1

CREATE TABLE projects (
	id 			INT IDENTITY(10001, 1) 	NOT NULL,
	name		VARCHAR(45)				NOT NULL,
	description VARCHAR(45),
	date		VARCHAR(45)				NOT NULL	CHECK(date > '01/09/2014')
	PRIMARY KEY(id)
)

CREATE TABLE users (
	id			INT IDENTITY(1, 1)		NOT NULL,
	name		VARCHAR(45)				NOT NULL,
	username	VARCHAR(45)				NOT	NULL,
	password	VARCHAR(45)				NOT	NULL	DEFAULT '123mudar',
	email		VARCHAR(45)				NOT	NULL
	PRIMARY KEY(id),
	CONSTRAINT UQ_username UNIQUE (username)
)

CREATE TABLE users_has_projects (
	users_id	INT						NOT NULL,
	projects_id	INT						NOT NULL
	PRIMARY KEY(users_id, projects_id)
	FOREIGN KEY(users_id)	 REFERENCES users(id),
	FOREIGN KEY(projects_id) REFERENCES projects(id)	
)

ALTER TABLE users
DROP CONSTRAINT UQ_username

ALTER TABLE users
ALTER COLUMN username VARCHAR(10)	NOT NULL

ALTER TABLE users
ADD CONSTRAINT UQ_username UNIQUE (username)

ALTER TABLE users
ALTER COLUMN password VARCHAR(8)	NOT NULL

INSERT INTO users (name, username, password, email) VALUES
	('Maria', 'Rh_maria', default, 'maria@empresa.com'),
	('Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com'),
	('Ana', 'Rh_ana', default, 'ana@empresa.com'),
	('Clara', 'Ti_maria', default, 'clara@empresa.com'),
	('Aparecido', 'Rh_apareci', '55@!cido', 'aparecido@empresa.com')

INSERT INTO projects (name, description, date) VALUES
	('Re-folha', 'Refatoração das Folhas', '05/09/2014'),
	('Manutenção PC´s', 'Manutenção PC´s', '06/09/2014'),
	('Auditoria', NULL, '07/09/2014')

INSERT INTO users_has_projects (users_id, projects_id) VALUES
	(1, 10001),
	(5, 10001),
	(3, 10003),
	(4, 10002),
	(2, 10002)

UPDATE projects 
SET date = '12/09/2014' 
WHERE name = 'Manutenção PC´s'

UPDATE users
SET username = 'Rh_cido'
WHERE name = 'Aparecido'

UPDATE users
SET password = '888@'
WHERE username = 'Rh_maria' AND password = '123mudar'

DELETE users_has_projects
WHERE users_id = 2 AND projects_id = 10002

INSERT INTO users VALUES ('Joao', 'Ti_joao', DEFAULT, 'joao@empresa.com')

INSERT INTO projects VALUES ('Atualização de Sistemas', 'Modificação de Sistemas Operacionais nos PC´s', '12/09/2014')

/*1*/
SELECT COUNT(pj.id) AS aty_projects_no_users
FROM projects pj LEFT OUTER JOIN users_has_projects up
ON pj.id = up.projects_id
WHERE up.projects_id IS NULL

/*2*/
SELECT pj.id, pj.name, COUNT(up.users_id) AS qty_users_projects  
FROM projects pj, users_has_projects up
WHERE pj.id = up.projects_id
GROUP BY pj.id, pj.name
ORDER BY pj.name