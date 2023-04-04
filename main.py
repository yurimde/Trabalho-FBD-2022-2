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

print('Conectado')

cursor = conn.cursor()


cursor.execute('select * from clientesBrasil;')