
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

else:
    print('Success!')
    dbconnector.close()

# try-except-error-finally
# https://note.nkmk.me/python-try-except-else-finally/
