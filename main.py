import requests
import threading
import zipfile
import sqlite3
import pandas as pd
import numpy as np


def download_data(link, zip_name, save_path):
    data = requests.get(link)

    open(zip_name, 'wb').write(data.content)

    with zipfile.ZipFile(zip_name, 'r') as zip_ref:
        zip_ref.extractall(save_path)


def main():

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

main()


def create_database():
    con = sqlite3.connect('estudante.db')
    cursor = con.cursor()

    sql_file = open('script.sql')
    sql_string = sql_file.read()
    cursor.executescript(sql_string)

    con.commit()
    con.close()


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
10 - CO_RS_l1(string) - grau de dificuldade
11 - QE_I02(string) - etnia 
'''
def read_data():
    data_2017 = pd.read_csv('./enade_2017/3.DADOS/MICRODADOS_ENADE_2017.txt', skipinitialspace=True, sep=';', low_memory=False)
    data_2018 = pd.read_csv('./enade_2018/2018/3.DADOS/microdados_enade_2018.txt', skipinitialspace=True, sep=';', low_memory=False)
    data_2019 = pd.read_csv('./enade_2019/3.DADOS/microdados_enade_2019.txt', skipinitialspace=True, sep=';', low_memory=False)

    print({
        len(data_2017.index),
        len(data_2018.index),
        len(data_2019.index)
    })
        