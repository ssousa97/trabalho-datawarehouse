CREATE TABLE IF NOT EXISTS Ano(ano integer primary key);
CREATE TABLE IF NOT EXISTS Organizacao(codigo integer primary key, nome text);
CREATE TABLE IF NOT EXISTS Grupo(codigo integer primary key, nome text);
CREATE TABLE IF NOT EXISTS Modalidade(codigo integer primary key, nome text);
CREATE TABLE IF NOT EXISTS Etnia(codigo text primary key, nome text);
CREATE TABLE IF NOT EXISTS Dificuldade(codigo text primary key, nome text);
CREATE TABLE IF NOT EXISTS Nota(nota real primary key);
CREATE TABLE IF NOT EXISTS UF(codigo integer primary key, nome text);
CREATE TABLE IF NOT EXISTS Idade(idade integer primary key);
CREATE TABLE IF NOT EXISTS Sexo(sexo text primary key);
CREATE TABLE IF NOT EXISTS Turno(codigo integer primary key, nome text);

CREATE TABLE IF NOT EXISTS Estudante(
    ano integer,
    organizacao integer, 
    grupo integer, 
    modalidade integer,
    uf integer,
    idade integer,
    sexo text,
    turno integer,
    nota real,
    dificuldade text,
    etnia text,
    foreign key(ano) references Ano(ano),
    foreign key(organizacao) references Organizacao(codigo),
    foreign key(grupo) references Grupo(codigo),
    foreign key(modalidade) references Modalidade(codigo),
    foreign key(uf) references UF(codigo),
    foreign key(idade) references Idade(idade),
    foreign key(sexo) references Sexo(sexo),
    foreign key(turno) references Turno(codigo),
    foreign key(nota) references Nota(nota),
    foreign key(dificuldade) references Dificuldade(codigo),
    foreign key(etnia) references Etnia(codigo)
);

INSERT or IGNORE INTO Ano (ano)
VALUES  (2017), 
        (2018),
        (2019);

INSERT or IGNORE INTO Organizacao(codigo, nome)
VALUES  (10019, 'Centro Federal de Educação Tecnológica'),
        (10020, 'Centro Universitário'),
        (10022, 'Faculdade'),
        (10026, 'Instituto Federal de Educação, Ciência e Tecnologia'),
        (10028, 'Universidade');

INSERT or IGNORE INTO Grupo(codigo, nome)
VALUES  (5 , 'MEDICINA VETERINÁRIA'),
        (6 , 'ODONTOLOGIA'),
        (12 , 'MEDICINA'),
        (17 , 'AGRONOMIA'),
        (19 , 'FARMÁCIA'),
        (21 , 'ARQUITETURA E URBANISMO'),
        (23 , 'ENFERMAGEM'),
        (27 , 'FONOAUDIOLOGIA'),
        (28 , 'NUTRIÇÃO'),
        (36 , 'FISIOTERAPIA'),
        (51 , 'ZOOTECNIA'),
        (55 , 'BIOMEDICINA'),
        (69 , 'TECNOLOGIA EM RADIOLOGIA'),
        (90 , 'TECNOLOGIA EM AGRONEGÓCIOS'),
        (91 , 'TECNOLOGIA EM GESTÃO HOSPITALAR'),
        (92 , 'TECNOLOGIA EM GESTÃO AMBIENTAL'),
        (95 , 'TECNOLOGIA EM ESTÉTICA E COSMÉTICA'),
        (3501 , 'EDUCAÇÃO FÍSICA (BACHARELADO)'),
        (4003 , 'ENGENHARIA DA COMPUTAÇÃO'),
        (5710 , 'ENGENHARIA CIVIL'),
        (5806 , 'ENGENHARIA ELÉTRICA'),
        (5814 , 'ENGENHARIA DE CONTROLE E AUTOMAÇÃO'),
        (5902 , 'ENGENHARIA MECÂNICA'),
        (6002 , 'ENGENHARIA DE ALIMENTOS'),
        (6008 , 'ENGENHARIA QUÍMICA'),
        (6208 , 'ENGENHARIA DE PRODUÇÃO'),
        (6307 , 'ENGENHARIA AMBIENTAL'),
        (6405 , 'ENGENHARIA FLORESTAL'),
        (6410 , 'TECNOLOGIA EM SEGURANÇA NO TRABALHO');

INSERT or IGNORE INTO Modalidade(codigo, nome)
VALUES  (0, 'EaD'),
        (1, 'Presencial');

INSERT or IGNORE INTO UF(codigo, nome)
VALUES  (11 ,' Rondônia (RO)'),
        (12 , 'Acre (AC)'),
        (13 , 'Amazonas (AM)'),
        (14 , 'Roraima (RR)'),
        (15 , 'Pará (PA)'),
        (16 , 'Amapa (AP)'),
        (17 , 'Tocantins (TO)'),
        (21 , 'Maranhão (MA)'),
        (22 , 'Piauí (PI)'),
        (23 , 'Ceará (CE)'),
        (24 , 'Rio Grande do Norte (RN)'),
        (25 , 'Paraíba (PB)'),
        (26 , 'Pernambuco (PE)'),
        (27 , 'Alagoas (AL)'),
        (28 , 'Sergipe (SE)'),
        (29 , 'Bahia (BA)'),
        (31 , 'Minas gerais (MG)'),
        (32 , 'Espírito Santo (ES)'),
        (33 , 'Rio de Janeiro (RJ)'),
        (35 , 'São Paulo (SP)'),
        (41 , 'Paraná (PR)'),
        (42 , 'Santa Catarina (SC)'),
        (43 , 'Rio Grande do Sul (RS)'),
        (50 , 'Mato Grosso do Sul (MS)'),
        (51 , 'Mato Grosso (MT)'),
        (52 , 'Goiás (GO)'),
        (53 , 'Distrito federal (DF)');

INSERT or IGNORE INTO Sexo(sexo)
VALUES  ('M'), ('F');

INSERT or IGNORE INTO Turno(codigo, nome)
VALUES  (1, 'Matutino'),
        (2, 'Verspertino'),
        (3, 'Integral'),
        (4, 'Noturno');

INSERT or IGNORE INTO Dificuldade(codigo, nome)
VALUES  ('A', 'Muito fácil'),
        ('B', 'Fácil'),
        ('C', 'Médio'),
        ('D', 'Difícil'),
        ('E', 'Muito difícil'),
        ('*', 'Resposta anulada'),
        ('.', 'Sem resposta');

INSERT or IGNORE INTO Etnia(codigo, nome)
VALUES  ('A', 'Branca'),
        ('B', 'Preta'),
        ('C', 'Amarela'),
        ('D', 'Parda'),
        ('E', 'Indígena'),
        ('F', 'Não declarado');


CREATE TRIGGER IF NOT EXISTS insert_idade_before_estudante
    BEFORE INSERT ON Estudante
BEGIN
    INSERT or IGNORE INTO Idade(idade) VALUES (NEW.idade);
END