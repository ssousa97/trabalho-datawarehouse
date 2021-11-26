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
        (2019),
        (0);

INSERT or IGNORE INTO Organizacao(codigo, nome)
VALUES  (10019, 'Centro Federal de Educação Tecnológica'),
        (10020, 'Centro Universitário'),
        (10022, 'Faculdade'),
        (10026, 'Instituto Federal de Educação, Ciência e Tecnologia'),
        (10028, 'Universidade'),
        (0 , 'Dado faltante');

INSERT or IGNORE INTO Grupo(codigo, nome)
VALUES  (21,'ARQUITETURA E URBANISMO'),
        (72,'TECNOLOGIA EM ANÁLISE E DESENVOLVIMENTO DE SISTEMAS'),
        (76,'TECNOLOGIA EM GESTÃO DA PRODUÇÃO INDUSTRIAL'),
        (79,'TECNOLOGIA EM REDES DE COMPUTADORES'),
        (701,'MATEMÁTICA (BACHARELADO)'),
        (702,'MATEMÁTICA (LICENCIATURA)'),
        (903,'LETRAS-PORTUGUÊS (BACHARELADO)'),
        (904,'LETRAS-PORTUGUÊS (LICENCIATURA)'),
        (905,'LETRAS-PORTUGUÊS E INGLÊS (LICENCIATURA)'),
        (906,'LETRAS-PORTUGUÊS E ESPANHOL (LICENCIATURA)'),
        (1401,'FÍSICA (BACHARELADO)'),
        (1402,'FÍSICA (LICENCIATURA)'),
        (1501,'QUÍMICA (BACHARELADO)'),
        (1502,'QUÍMICA (LICENCIATURA)'),
        (1601,'CIÊNCIAS BIOLÓGICAS (BACHARELADO)'),
        (1602,'CIÊNCIAS BIOLÓGICAS (LICENCIATURA)'),
        (2001,'PEDAGOGIA (LICENCIATURA)'),
        (2401,'HISTÓRIA (BACHARELADO)'),
        (2402,'HISTÓRIA (LICENCIATURA)'),
        (2501,'ARTES VISUAIS (LICENCIATURA)'),
        (3001,'GEOGRAFIA (BACHARELADO)'),
        (3002,'GEOGRAFIA (LICENCIATURA)'),
        (3201,'FILOSOFIA (BACHARELADO)'),
        (3202,'FILOSOFIA (LICENCIATURA)'),
        (3502,'EDUCAÇÃO FÍSICA (LICENCIATURA)'),
        (4003,'ENGENHARIA DA COMPUTAÇÃO'),
        (4004,'CIÊNCIA DA COMPUTAÇÃO (BACHARELADO)'),
        (4005,'CIÊNCIA DA COMPUTAÇÃO (LICENCIATURA)'),
        (4006,'SISTEMAS DE INFORMAÇÃO'),
        (4301,'MÚSICA (LICENCIATURA)'),
        (5401,'CIÊNCIAS SOCIAIS (BACHARELADO)'),
        (5402,'CIÊNCIAS SOCIAIS (LICENCIATURA)'),
        (5710,'ENGENHARIA CIVIL'),
        (5806,'ENGENHARIA ELÉTRICA'),
        (5814,'ENGENHARIA DE CONTROLE E AUTOMAÇÃO'),
        (5902,'ENGENHARIA MECÂNICA'),
        (6002,'ENGENHARIA DE ALIMENTOS'),
        (6008,'ENGENHARIA QUÍMICA'),
        (6208,'ENGENHARIA DE PRODUÇÃO'),
        (6306,'ENGENHARIA'),
        (6307,'ENGENHARIA AMBIENTAL'),
        (6405,'ENGENHARIA FLORESTAL'),
        (6407,'LETRAS - INGLÊS'),
        (6409,'TECNOLOGIA EM GESTÃO DA TECNOLOGIA DA INFORMAÇÃO'),
        (1,'ADMINISTRAÇÃO'),
        (2,'DIREITO'),
        (13,'CIÊNCIAS ECONÔMICAS'),
        (18,'PSICOLOGIA'),
        (22,'CIÊNCIAS CONTÁBEIS'),
        (26,'DESIGN'),
        (29,'TURISMO'),
        (38,'SERVIÇO SOCIAL'),
        (67,'SECRETARIADO EXECUTIVO'),
        (81,'RELAÇÕES INTERNACIONAIS'),
        (83,'TECNOLOGIA EM DESIGN DE MODA'),
        (84,'TECNOLOGIA EM MARKETING'),
        (85,'TECNOLOGIA EM PROCESSOS GERENCIAIS'),
        (86,'TECNOLOGIA EM GESTÃO DE RECURSOS HUMANOS'),
        (87,'TECNOLOGIA EM GESTÃO FINANCEIRA'),
        (88,'TECNOLOGIA EM GASTRONOMIA'),
        (93,'TECNOLOGIA EM GESTÃO COMERCIAL'),
        (94,'TECNOLOGIA EM LOGÍSTICA'),
        (100,'ADMINISTRAÇÃO PÚBLICA'),
        (101,'TEOLOGIA'),
        (102,'TECNOLOGIA EM COMÉRCIO EXTERIOR'),
        (103,'TECNOLOGIA EM DESIGN DE INTERIORES'),
        (104,'TECNOLOGIA EM DESIGN GRÁFICO'),
        (105,'TECNOLOGIA EM GESTÃO DA QUALIDADE'),
        (106,'TECNOLOGIA EM GESTÃO PÚBLICA'),
        (803,'COMUNICAÇÃO SOCIAL - JORNALISMO'),
        (804,'COMUNICAÇÃO SOCIAL - PUBLICIDADE E PROPAGANDA'),
        (5,'MEDICINA VETERINÁRIA'),
        (6,'ODONTOLOGIA'),
        (12,'MEDICINA'),
        (17,'AGRONOMIA'),
        (19,'FARMÁCIA'),
        (21,'ARQUITETURA E URBANISMO'),
        (23,'ENFERMAGEM'),
        (27,'FONOAUDIOLOGIA'),
        (28,'NUTRIÇÃO'),
        (36,'FISIOTERAPIA'),
        (51,'ZOOTECNIA'),
        (55,'BIOMEDICINA'),
        (69,'TECNOLOGIA EM RADIOLOGIA'),
        (90,'TECNOLOGIA EM AGRONEGÓCIOS'),
        (91,'TECNOLOGIA EM GESTÃO HOSPITALAR'),
        (92,'TECNOLOGIA EM GESTÃO AMBIENTAL'),
        (95,'TECNOLOGIA EM ESTÉTICA E COSMÉTICA'),
        (3501,'EDUCAÇÃO FÍSICA (BACHARELADO)');

INSERT or IGNORE INTO Modalidade(codigo, nome)
VALUES  (0, 'EaD'),
        (1, 'Presencial'),
        (-1 , 'Dado faltante');

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
        (53 , 'Distrito federal (DF)'),
        (0 , 'Dado faltante');

INSERT or IGNORE INTO Sexo(sexo)
VALUES  ('M'), ('F'), ('NE');

INSERT or IGNORE INTO Turno(codigo, nome)
VALUES  (1, 'Matutino'),
        (2, 'Verspertino'),
        (3, 'Integral'),
        (4, 'Noturno'),
        (0, 'Dado faltante');

INSERT or IGNORE INTO Dificuldade(codigo, nome)
VALUES  ('A', 'Muito fácil'),
        ('B', 'Fácil'),
        ('C', 'Médio'),
        ('D', 'Difícil'),
        ('E', 'Muito difícil'),
        ('*', 'Resposta anulada'),
        ('.', 'Sem resposta'),
        ('-', 'Dado faltante');

INSERT or IGNORE INTO Etnia(codigo, nome)
VALUES  ('A', 'Branca'),
        ('B', 'Preta'),
        ('C', 'Amarela'),
        ('D', 'Parda'),
        ('E', 'Indígena'),
        ('F', 'Não declarado'),
        ('-', 'Dado faltante');


CREATE TRIGGER IF NOT EXISTS insert_idade_before_estudante
    BEFORE INSERT ON Estudante
BEGIN
    INSERT or IGNORE INTO Idade(idade) VALUES (NEW.idade);
END;

CREATE TRIGGER IF NOT EXISTS insert_nota_before_estudante
    BEFORE INSERT ON Estudante
BEGIN
    INSERT or IGNORE INTO Nota(nota) VALUES (NEW.nota);
END;