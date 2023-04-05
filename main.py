import psycopg2

#configurações

host = 'localhost'
dbname = 'DicionarioAmazon'
user = 'postgres'
password = 'mesmoassim1'
sslmode = 'require'

#string conexão
conn_string = 'host={0} user={1} dbname={2} password={3}'.format(host, user, dbname, password)

conn = psycopg2.connect(conn_string)

cursor = conn.cursor()

queries = []
file = open('consultas.sql','r')
fullquery = ''
end = 0
while (end == 0):
  aux=file.readline()
  
  if (aux.startswith('select') or aux.startswith('SELECT')):

    queries.append(fullquery)
    fullquery =  ''

  if (aux.startswith('--')):
    aux = ' '

  fullquery += aux

  if aux ==  '':
    
    queries.append(fullquery)
    end = 1

file.close()

x = int(input('Digite o numero da consulta presente no arquivo consultas.sql para ser executada \n'))

cursor.execute(queries[x])
consulta = cursor.fetchall()

for row in consulta:
  print(row)

conn.close