-- Arquivo utilizado para gerar o banco de dados do portal do aluno
-- para a disciplina de engenharia de software.
-- o software utilizado para hostear o banco de dados foi o pgadmin 4



CREATE TYPE tipo_pessoa AS ENUM ('v', 'a'); -- a é gerente \\ v é vinculado

CREATE TABLE Registros (
	matricula VARCHAR(8) NOT NULL PRIMARY KEY,
	senha VARCHAR(15) NOT NULL,
	tipo tipo_pessoa NOT NULL,
	nome VARCHAR(25) NOT NULL
);

INSERT INTO  Registros VALUES ('00315418', 'cabritoteves', 'a', 'Luana Hahn');
INSERT INTO  Registros VALUES ('00333363','ladygaga', 'v', 'Henry Ribeiro');
INSERT INTO Registros VALUES ('00334954', 'ecpporamor', 'v', 'Artur Ruiz');
INSERT INTO  Registros VALUES ('00332849', 'soudacic', 'a', 'Douglas Schlatter');
insert into Registros VALUES('0','123','v','TesteVinculado');
insert into Registros VALUES('1','123','a','TesteGerente');

CREATE TABLE Vinculado (
	matricula_vinculado VARCHAR(8) NOT NULL PRIMARY KEY,
	prae BOOL NOT NULL,
	FOREIGN KEY (matricula_vinculado) REFERENCES Registros(matricula)
);

INSERT INTO Vinculado VALUES ('00333363', 'true');
INSERT INTO Vinculado VALUES ('00334954', 'false');
INSERT INTO Vinculado VALUES ('0', 'false');

CREATE TABLE Gerente (
	matricula_gerente VARCHAR(8) NOT NULL PRIMARY KEY,
	
	FOREIGN KEY (matricula_gerente) REFERENCES Registros(matricula)
);

INSERT INTO Gerente VALUES ('00315418');
INSERT INTO Gerente VALUES ('00332849');
INSERT INTO Gerente VALUES ('1');

CREATE TABLE Pool (
	id_pool VARCHAR(8) NOT NULL PRIMARY KEY,
	uses SMALLINT NOT NULL
);
insert into Pool values ('10001000', 50);
insert into Pool values ('10001001', 1);

CREATE TABLE Tiquetes (
	id_tiquete VARCHAR(8) NOT NULL PRIMARY KEY,
	matricula_vinculado VARCHAR(8) NOT NULL,
	usos_restantes int NOT NULL,
	FOREIGN KEY (matricula_vinculado) REFERENCES Vinculado(matricula_vinculado)
);

INSERT INTO Tiquetes VALUES ('01111111', '00333363',1);
INSERT INTO Tiquetes VALUES ('01111112', '00333363',1);
INSERT INTO Tiquetes VALUES ('01111113', '00334954',1);
INSERT INTO Tiquetes VALUES ('01111114', '00333363',10);
INSERT INTO Tiquetes VALUES ('01111115', '00333363',1);
INSERT INTO Tiquetes VALUES ('01111116', '00333363',1);
INSERT INTO Tiquetes VALUES ('01111117', '0',10);
select * from tiquetes

CREATE TABLE relation_vinculado_pool (
	id_vin_pool SERIAL NOT NULL PRIMARY KEY,
	id_pool VARCHAR(8) NOT NULL,
	matricula_vinculado VARCHAR(8) NOT NULL,
	FOREIGN KEY (matricula_vinculado) REFERENCES Vinculado(matricula_vinculado) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (id_pool) REFERENCES Pool(id_pool) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO relation_vinculado_pool values (DEFAULT,'10001000','00333363');
INSERT INTO relation_vinculado_pool values (DEFAULT,'10001000','00334954');
INSERT INTO relation_vinculado_pool values (DEFAULT,'10001001','00333363');


CREATE TABLE Enquete (
	id_enquete SERIAL NOT NULL PRIMARY KEY,
	matricula_gerente VARCHAR(8) NOT NULL,
	enunciado VARCHAR(500) NOT NULL,
	
	FOREIGN KEY (matricula_gerente) REFERENCES Gerente(matricula_gerente)
);

INSERT INTO Enquete VALUES (DEFAULT, '00332849', '|O que você gostaria de comer segunda-feira?|Arroz, feijão, aipim, salada, frango|Arroz, feijão, aipim, salada, guisado|Arroz, feijão, aipim, salada, peixe|Arroz, feijão, aipim, salada, bife|Arroz, feijão, aipim, salada, porco');
--select * from Enquete;

CREATE TYPE resposta AS ENUM ('a', 'b', 'c', 'd', 'e');
CREATE TABLE Vota (
	id_voto SERIAL NOT NULL PRIMARY KEY,
	id_enquete INTEGER NOT NULL,
	matricula_vinculado VARCHAR(8) NOT NULL,
	resp resposta NOT NULL,
	
	FOREIGN KEY (matricula_vinculado) REFERENCES Vinculado(matricula_vinculado),
	FOREIGN KEY (id_enquete) REFERENCES Enquete(id_enquete)
);

INSERT INTO Vota VALUES (DEFAULT, 2, '00333363', 'a')
SELECT * 
FROM Vota NATURAL JOIN Enquete 

SELECT * FROM relation_vinculado_pool NATURAL JOIN Pool WHERE matricula_vinculado = '00333363'



select *
from Pool
WHERE id_pool = '1'

SELECT * FROM Tiquetes NATURAL JOIN Vinculado WHERE id_tiquete = '11111111' and matricula_vinculado = '00333363';
DELETE FROM Tiquetes WHERE id_tiquete = '11111111' and matricula_vinculado = '00333363';

SELECT *
FROM Vinculado NATURAL JOIN Tiquetes
WHERE matricula_vinculado = '00333363'
