with open('./find_replace') as file:
    values = ''
    for line in file.readlines():
        pair = line.split('=')
        codigo = pair[0].strip()
        nome = pair[1].strip()
        values += f'''({codigo},'{nome}'),\n'''
    print(values)