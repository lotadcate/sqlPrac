
'''テーブルの作成とデータ入力'''
import mysql.connector

config = {
    'host': 'localhost',
    'port' : '3306',
    'user' : 'root',
    'password': 'mysqlroot',
    'database': 'sampledb'
}

dbconnector = mysql.connector.connect(**config)

# 接続が成功していたら 成功　とでる
if dbconnector.is_connected():
    print('Success!')
else:
    print('Failed')
    exit(1)

# 失敗していたら 失敗　とでる
cursor = dbconnctor.cursor(buffered=True)

# if exists
# https://johobase.com/exists-database-object-sqlserver/
cursor.execute("create table xxx")
cursor.execute("insert into table values () ")
cursor.execute("select * from xxx")
