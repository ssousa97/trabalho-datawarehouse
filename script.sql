CREATE TABLE IF NOT EXISTS Ano(ano integer primary key);
CREATE TABLE IF NOT EXISTS Organizacao(codigo integer primary key, nome text);
CREATE TABLE IF NOT EXISTS Grupo(codigo integer primary key, nome text);
CREATE TABLE IF NOT EXISTS Modalidade(codigo integer primary key, nome text);
CREATE TABLE IF NOT EXISTS Etnia(codigo integer primary key, nome text);
CREATE TABLE IF NOT EXISTS Dificuldade(codigo integer primary key, nome text);
CREATE TABLE IF NOT EXISTS Nota(nota real primary key);
CREATE TABLE IF NOT EXISTS UF(codigo integer primary key, nome text);
CREATE TABLE IF NOT EXISTS Idade(idade integer primary key);
CREATE TABLE IF NOT EXISTS Sexo(sexo text);
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
    dificuldade integer,
    etnia integer,
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

INSERT INTO Ano (ano)
VALUES  (2017), 
        (2018),
        (2019);

INSERT INTO Organizacao(codigo, nome)
VALUES  (10019, 'Centro Federal de Educação Tecnológica'),
        (10020, 'Centro Universitário'),
        (10022, 'Faculdade'),
        (10026, 'Instituto Federal de Educação, Ciência e Tecnologia'),
        (10028, 'Universidade');

INSERT INTO Grupo(codigo, nome)
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

