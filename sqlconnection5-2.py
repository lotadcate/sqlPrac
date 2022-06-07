
'''データベースを作成'''
import mysql.connector

# ユーザ名, パスワード, ホスト
config = {
    'user': 'root',
    'password': 'rootmysql',
    'host': 'localhost'
}

try:
    #config　の key と value　を渡す
    dbconnector = mysql.connector.connect(**config)

except mysql.connector.error as errmsg:
    print('Connection is failed')
    print('error: ', errmsg)
    exit(1)

# cursorオブジェクトの生成
cursor = dbconnector.cursor()

# sql命令の実行
cursor.execute("DROP DATABASE IF EXISTS sampledb")
cursor.execute('CREATE DATABASE sampledb')
cursor.execute('SHOW databases')

# 結果データを取得
tuples = cursor.fetchall()
# 表示
for tpl in tuples:
    print(tpl[0])

# mysql に保存
dbconnector.commit()

dbconnector.close()

