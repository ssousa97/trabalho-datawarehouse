import requests
import threading
import zipfile
import sqlite3
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import dataframe_image as dfi


'''
Dimensões da tabela fato :
1 - NU_ANO(int) - ano do exame - (2017, 2018, 2019)
2 - CO_ORGACAD(int - string) - codigo da categoria da faculdade
3 - CO_GRUPO(int - string) - grupo do curso
4 - CO_MODALIDADE(int - string) - modalidade de ensino
5 - CO_UF_CURSO(int - string) - estado do curso
6 - NU_IDADE(int) - idade
7 - TP_SEXO(string) - sexo
8 - CO_TURNO_GRADUACAO(int-string) - turno
9 - NT_GER(double) - nota geral
10 - CO_RS_I1(string) - grau de dificuldade
11 - QE_I02(string) - etnia 
'''


def download_data(link, zip_name, save_path):
    data = requests.get(link)

    open(zip_name, 'wb').write(data.content)

    with zipfile.ZipFile(zip_name, 'r') as zip_ref:
        zip_ref.extractall(save_path)


def download_files():

    enade_2019_link = 'https://download.inep.gov.br/microdados/Enade_Microdados/microdados_enade_2019.zip'
    enade_2018_link = 'https://download.inep.gov.br/microdados/Enade_Microdados/microdados_enade_2018.zip'
    enade_2017_link = 'https://download.inep.gov.br/microdados/Enade_Microdados/microdados_Enade_2017_portal_2018.10.09.zip'


    t1 = threading.Thread(target=download_data, args=(enade_2019_link, 'enade_2019_zip', './enade_2019/'))
    t2 = threading.Thread(target=download_data, args=(enade_2018_link, 'enade_2018_zip', './enade_2018/'))
    t3 = threading.Thread(target=download_data, args=(enade_2017_link, 'enade_2017_zip', './enade_2017/'))

    t1.start()
    t2.start()
    t3.start()

    t1.join()
    t2.join()
    t3.join()

    print('Download de arquivos concluído.')


def create_database():
    con = sqlite3.connect('estudante.db')
    cursor = con.cursor()

    sql_file = open('script.sql')
    sql_string = sql_file.read()
    cursor.executescript(sql_string)

    con.commit()
    con.close()


def parse_nota(nota):
    if nota is np.NaN:
        return -1
    if type(nota) is int or type(nota) is float:
        return nota
    elif type(nota) is str:
        if ',' in nota:
            return float(nota.replace(',','.'))
        elif '.' in nota:
            return float(nota)
        else:
            return int(nota)
    else:
        return -1
    

def is_NaN(data):
    return str(data) == 'nan'

def treat_data(row):
    return {
        'ano' : row['NU_ANO'] if not is_NaN(row['NU_ANO']) else 0,
        'organizacao' : row['CO_ORGACAD'] if not is_NaN(row['CO_ORGACAD']) else 0,
        'grupo' : row['CO_GRUPO'] if not is_NaN(row['CO_GRUPO']) else 0,
        'modalidade' : row['CO_MODALIDADE'] if not is_NaN(row['CO_MODALIDADE']) else -1,
        'uf' : row['CO_UF_CURSO'] if not is_NaN(row['CO_UF_CURSO']) else 0,
        'idade' : row['NU_IDADE'] if not is_NaN(row['NU_IDADE']) else 0,
        'sexo' : row['TP_SEXO'] if not is_NaN(row['TP_SEXO']) else 'NE',
        'turno' : row['CO_TURNO_GRADUACAO'] if not is_NaN(row['CO_TURNO_GRADUACAO']) else 0,
        'nota' : parse_nota(row['NT_GER']),
        'dificuldade' : row['CO_RS_I1'] if not is_NaN(row['CO_RS_I1']) else '-',
        'etnia' : row['QE_I02'] if not is_NaN(row['QE_I02']) else '-'
    }
    

'''
Extração de colunas que serão utilizadas. Facilita leituras posteriores dos arquivos e impacta menos na memória.
'''
def preprocess_data():

    columns = [
        'NU_ANO','CO_ORGACAD','CO_GRUPO', 
        'CO_MODALIDADE', 'CO_UF_CURSO',
        'NU_IDADE', 'TP_SEXO',
        'CO_TURNO_GRADUACAO', 'NT_GER',
        'CO_RS_I1', 'QE_I02'
    ]

    data_2017 = pd.read_csv('./enade_2017/3.DADOS/MICRODADOS_ENADE_2017.txt',
        skipinitialspace=True, sep=';', low_memory=False)
    data_2018 = pd.read_csv('./enade_2018/2018/3.DADOS/microdados_enade_2018.txt',
        skipinitialspace=True, sep=';', low_memory=False)
    data_2019 = pd.read_csv('./enade_2019/3.DADOS/microdados_enade_2019.txt',
        skipinitialspace=True, sep=';', low_memory=False)

    data_2017 = data_2017[columns]
    data_2018 = data_2018[columns]
    data_2019 = data_2019[columns]

    data_2017.to_csv('enade_2017_preprocessed')
    data_2018.to_csv('enade_2018_preprocessed')
    data_2019.to_csv('enade_2019_preprocessed')


def read_insert_data():

    data_2017 = pd.read_csv('./enade_2017_preprocessed', skipinitialspace=True, sep=',', low_memory=False)
    data_2018 = pd.read_csv('./enade_2018_preprocessed', skipinitialspace=True, sep=',', low_memory=False)
    data_2019 = pd.read_csv('./enade_2019_preprocessed', skipinitialspace=True, sep=',', low_memory=False)

    sql_string = 'INSERT INTO Estudante(ano, organizacao, grupo, modalidade, uf, idade, sexo, turno, nota, dificuldade, etnia) VALUES '
    values = ''
    with open('./test', 'w') as file:
            for dataset in [data_2017, data_2018, data_2019 ]:
                for index, row in dataset.iterrows():
                    estudante = treat_data(row)
                    values += f'''  ({estudante['ano']},{estudante['organizacao']},{estudante['grupo']},
                                    {estudante['modalidade']},{estudante['uf']},{estudante['idade']},
                                    '{estudante['sexo']}',{estudante['turno']},{estudante['nota']},
                                    '{estudante['dificuldade']}', '{estudante['etnia']}' ),'''

    
    sql_string += values[:-1] + ';'
    con = sqlite3.connect('estudante.db')
    cursor = con.cursor()
    cursor.execute(sql_string)

    con.commit()
    con.close()



''''
1 - Nota media por curso
2 - Notas por idade
3 - Nota media por região do brasil
4 - Dificuldade percebida por etnia
5 - Etnia por turno
'''
def test_data():
    con = sqlite3.connect('estudante.db')
    cursor = con.cursor()

    # Nota média por curso
    nota_media_curso(cursor.execute('SELECT COUNT(*), AVG(Estudante.nota), Grupo.nome FROM Estudante INNER JOIN Grupo ON Estudante.grupo = Grupo.codigo GROUP BY Estudante.grupo'))

    # # Nota média por idade
    # for row in cursor.execute('select avg(nota), idade from Estudante group by idade'):
    #     print(row)

    # # Nota média por região do brasil
    # for row in cursor.execute('select avg(nota), uf from Estudante group by uf'):
    #     print(row)    


    etnias = ['A', 'B', 'C', 'D', 'E', 'F', '-']

    # Dificuldade percebida por etnia
    # for etnia in etnias:
    #     sql_string = f'''select dificuldade, count(dificuldade), etnia from Estudante where etnia='{etnia}' group by dificuldade'''
    #     for row in cursor.execute(sql_string):
    #         print(row) 

    # Etnia por turno
    # for etnia in etnias:
    #     sql_string = f'''select turno, count(turno), etnia from Estudante where etnia='{etnia}' group by turno'''
    #     for row in cursor.execute(sql_string):
    #         print(row)
    
    con.commit()
    con.close()


def nota_media_curso(query_result):
    
    fig, ax = plt.subplots()

    data = [(row[2], row[1]) for row in query_result]
    
    data_x = [dx[0] for dx in data]
    data_y = [dy[1] for dy in data]
    df = pd.DataFrame(data_x, data_y)

    ax.plot(data_y, data_x)

    plt.savefig('nota_media_curso.png')
    # dfi.export(df, 'nota_media_curso_tabela.png')
    



# Etapas iniciais, só precisam ser executadas uma vez.
# preprocess_data()
# create_database()
test_data()


