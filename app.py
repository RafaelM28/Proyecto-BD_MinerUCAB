from flask import Flask, render_template # Importación de Flask y render_template para renderizar plantillas HTML
import psycopg2 # Importación de psycopg2 para la conexión a PostgreSQL

# Inicialización de la aplicación Flask, especificando la carpeta que contiene las plantillas HTML
app = Flask(__name__, template_folder='frontend') 

# Función para establecer conexión con la base de datos PostgreSQL
def connection():
    # Creación de variables con los datos de conexión a la base de datos
    db_name = "db_minerucab"
    db_user = "postgres"
    db_pass = "0000"
    db_host = "localhost"
    db_port = "5432"

    try:
        conn = psycopg2.connect(
            database=db_name,
            user=db_user,
            password=db_pass,
            host=db_host,
            port=db_port
        )
        print("Conexión exitosa")  
        return conn  
    except Exception as e:
        # Manejo de excepciones en caso de fallo en la conexión
        print("Ocurrió un error al conectar a la base de datos:", e)
        return None  
    
# Definición de la ruta '/lista_clientes' 
@app.route('/lista_clientes')
def lista_clientes():
    # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'lista_clientes' que retorna una lista de clientes
    cur.execute("SELECT * FROM lista_clientes()")
    clientes = cur.fetchall()  
    
    # Cierre del cursor y de la conexión a la base de datos
    cur.close()  
    connection().close()  
    
    # Renderización de la plantilla HTML para 'lista_clientes', pasando los datos de clientes al template
    return render_template('Lista_Clientes/lista_clientes.html', clientes=clientes)

# Definición de la ruta '/lista_aliados'
@app.route('/lista_aliados')
def lista_aliados():
    # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'lista_aliados' que retorna una lista de aliados
    cur.execute("SELECT * FROM lista_aliados()")
    aliados = cur.fetchall()  
    
    # Cierre del cursor y de la conexión a la base de datos
    cur.close()  
    connection().close()  
    
    # Renderización de la plantilla HTML para 'lista_aliados', pasando los datos de aliados al template
    return render_template('Lista_Aliados/lista_aliados.html', aliados=aliados)

@app.route('/lista_empleados')
def lista_empleados():
    # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'lista_empleados' que retorna una lista de empleados
    cur.execute("SELECT * FROM lista_empleados()")
    empleados = cur.fetchall()  
    
    # Cierre del cursor y de la conexión a la base de datos
    cur.close()  
    connection().close()  
    
    # Renderización de la plantilla HTML para 'lista_empleados', pasando los datos de empleados al template
    return render_template('Lista_Empleados/lista_empleados.html', empleados=empleados)

# Definición de la ruta '/lista_productos'
@app.route('/lista_usuarios')
def lista_usuarios():
    # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'lista_usuarios' que retorna una lista de usuarios
    cur.execute("SELECT * FROM lista_usuarios()")
    usuarios = cur.fetchall()  
    
    # Cierre del cursor y de la conexión a la base de datos
    cur.close()  
    connection().close()  
    
    # Renderización de la plantilla HTML para 'lista_usuarios', pasando los datos de usuarios al template
    return render_template('Lista_Usuarios/lista_usuarios.html', usuarios=usuarios)

@app.route('/lista_privilegios')
def lista_privilegios():
    # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'lista_privilegios' que retorna una lista de privilegios
    cur.execute("SELECT * FROM lista_privilegios()")
    privilegios = cur.fetchall()  
    
    # Cierre del cursor y de la conexión a la base de datos
    cur.close()  
    connection().close()  
    
    # Renderización de la plantilla HTML para 'lista_privilegios', pasando los datos de privilegios al template
    return render_template('Lista_Privilegios/lista_privilegios.html', privilegios=privilegios)

@app.route('/lista_roles')
def lista_roles():
    # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'lista_roles' que retorna una lista de roles
    cur.execute("SELECT * FROM lista_roles()")
    roles = cur.fetchall()  
    
    # Cierre del cursor y de la conexión a la base de datos
    cur.close()  
    connection().close()  
    
    # Renderización de la plantilla HTML para 'lista_roles', pasando los datos de roles al template
    return render_template('Lista_Roles/lista_roles.html', roles=roles)

if __name__ == '__main__': 
    app.run(debug=True) 