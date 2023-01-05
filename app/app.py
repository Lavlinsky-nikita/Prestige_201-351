from flask import Flask, render_template, request, url_for, redirect
import pymysql.cursors
from config import MYSQL_DATABASE, MYSQL_HOST, MYSQL_PASSWORD, MYSQL_USER

app = Flask(__name__)
application = app

connection = pymysql.connect(host=MYSQL_HOST,
                            user=MYSQL_USER,
                            password=MYSQL_PASSWORD,
                            database=MYSQL_DATABASE,
                            charset='utf8mb4',
                            cursorclass=pymysql.cursors.DictCursor)

class Cub:
    def __init__(self, length, width, height):
        self.length = length
        self.width  = width
        self.height = height

    @property
    def volume(self):
        return self.length * self.width * self.height

class Square:
    def __init__(self, length, width):
        self.length = length
        self.width  = width

    @property
    def area(self):
        return self.width * self.length

@app.route('/')
def index():
    with connection.cursor() as cursor:
        sql = 'SELECT * FROM user'
        cursor.execute(sql)
        names= cursor.fetchall()
    return render_template('index.html', names=names)



@app.route('/', methods=["GET", "POST"])
def post_new():
    form = request.form.get('name')
    with connection.cursor() as cursor:
        sql = """INSERT INTO user VALUES (%s)"""
        cursor.execute(sql, (form))
    connection.commit()

    with connection.cursor() as cursor:
        sql = 'SELECT * FROM user'
        cursor.execute(sql)
        names = cursor.fetchall()
        
    return render_template('index.html', names=names)
