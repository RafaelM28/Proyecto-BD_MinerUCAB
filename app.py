from flask import Flask, render_template, request, redirect, url_for 
import psycopg2 

app = Flask(__name__) 

# Datos para la conexion a la base de datos 
db_name = "db_minerucab"
db_user = "postgres"
db_pass = "0000"
db_host = "localhost"
db_port = "5432"

# Conectar a Base de Datos
conn = psycopg2.connect(db_name, db_user, db_pass, db_host, db_port)


if __name__ == '__main__': 
    app.run(debug=True) 