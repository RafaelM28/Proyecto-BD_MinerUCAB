from flask import Flask, render_template, request, redirect, url_for, jsonify# Importación de Flask y render_template para renderizar plantillas HTML
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
    

@app.route('/')
def inicio():
    return redirect(url_for('home'))

@app.route('/home')
def home():
    # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'lista_aliados' que retorna una lista de aliados
    cur.execute("SELECT * FROM lista_minerales_home()")
    minerales_home = cur.fetchall()  
    
    # Cierre del cursor y de la conexión a la base de datos
    cur.close()  
    connection().close()  
    
    # Renderización de la plantilla HTML para 'lista_aliados', pasando los datos de aliados al template
    return render_template('Home/home.html', minerales_home=minerales_home)
    
# Definición de la ruta '/lista_clientes' 
@app.route('/lista_clientes', methods=['GET'])
def lista_clientes():
    sort = request.args.get('sort', 'cliente_codigo')  # Orden por defecto: código
    order = request.args.get('order', 'asc')  # Orden ascendente por defecto
    search = request.args.get('search', '')

    query = "SELECT * FROM lista_clientes()"
    
    # Añadir condición de búsqueda si hay un término de búsqueda
    if search:
        query += f" WHERE CAST(cliente_codigo AS TEXT) LIKE '%{search}%' OR cliente_rif LIKE '%{search}%' OR cliente_denom_comercial LIKE '%{search}%' OR cliente_dir_fiscal LIKE '%{search}%'"

    # Añadir ordenamiento
    query += f" ORDER BY {sort} {order}"
    
    # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'lista_clientes' que retorna una lista de clientes
    cur.execute(query)
    clientes = cur.fetchall()  
    
    # Cierre del cursor y de la conexión a la base de datos
    cur.close()  
    connection().close()  
    
    # Renderización de la plantilla HTML para 'lista_clientes', pasando los datos de clientes al template
    return render_template('Ventas/lista_clientes.html', clientes=clientes)

# Definicion de la ruta '/register'
@app.route('/register', methods=['GET','POST'])
def register():
    if request.method == 'POST':
        # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
        conn = connection()
        cur = conn.cursor()

        # Obtener informacion del form
        razon_social = request.form['razonSocial']
        rif = request.form['rif']
        denominacion_comercial = request.form['denominacionComercial']
        correo_electronico = request.form['correoElectronico']
        telefono_prefijo = request.form['prefijo']
        telefono_numero = request.form['numero']
        telefono_tipo = request.form['tipo']
        estado_1 = request.form['estado1']
        municipio_1 = request.form['municipio1']
        parroquia_1 = request.form['parroquia1']
        direccion_principal_detalle = request.form['detalle1']
        estado_2 = request.form['estado2']
        municipio_2 = request.form['municipio2']
        parroquia_2 = request.form['parroquia2']
        direccion_fiscal_detalle = request.form['detalle2']
        capital_total = request.form['capitalTotal']
        nombre_usuario = request.form['nombreUsuario']
        clave = request.form['clave']
        confirmar_clave = request.form['confirmarClave']

        cur.execute("CALL sp_crear_cliente(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", 
                    (razon_social, rif, denominacion_comercial, capital_total, direccion_principal_detalle, 
                     direccion_fiscal_detalle, estado_1, municipio_1, parroquia_1, estado_2, municipio_2, parroquia_2, 
                     correo_electronico, telefono_prefijo, telefono_numero, telefono_tipo, nombre_usuario, clave, confirmar_clave))

        # Commit de los cambios
        conn.commit()

        # Cierre del cursor y de la conexión a la base de datos
        cur.close()  
        conn.close() 
    
        # Renderización de la plantilla HTML para 'crear_cliente'
        return redirect(url_for('lista_clientes'))

    cur = connection().cursor()
    cur.execute("SELECT * FROM lista_estados()")
    estados = cur.fetchall()
    cur.close()
    connection().close()

    return render_template('Seguridad/Usuarios/crear_usuario.html', estados=estados)

@app.route('/get_municipios/<estado_id>')
def get_municipios(estado_id: int):
    cursor = connection().cursor()
    cursor.execute("SELECT * FROM lista_municipios(%s)", (estado_id,))
    municipios = cursor.fetchall()
    cursor.close()
    connection().close()
    return jsonify([{"lugar_codigo": m[0], "lugar_nombre": m[1]} for m in municipios])

@app.route('/get_parroquias/<municipio_id>')
def get_parroquias(municipio_id: int):
    cursor = connection().cursor()
    cursor.execute("SELECT * FROM lista_parroquias(%s)", (municipio_id,))
    parroquias = cursor.fetchall()
    cursor.close()
    connection().close()
    return jsonify([{"lugar_codigo": p[0], "lugar_nombre": p[1]} for p in parroquias])

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
    return render_template('Alianzas/Aliados/lista_aliados.html', aliados=aliados)

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
    return render_template('Personal/Empleados/lista_empleados.html', empleados=empleados)

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
    return render_template('Seguridad/Usuarios/lista_usuarios.html', usuarios=usuarios)

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
    return render_template('Seguridad/Privilegios/lista_privilegios.html', privilegios=privilegios)

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
    return render_template('Seguridad/Roles/lista_roles.html', roles=roles)

# Definición de la ruta '/lista_minerales'
@app.route('/lista_minerales')
def lista_minerales():
    # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'lista_minerales' que retorna una lista de minerales
    cur.execute("SELECT * FROM lista_minerales()")
    minerales = cur.fetchall()  
    
    # Cierre del cursor y de la conexión a la base de datos
    cur.close()  
    connection().close()  
    
    # Renderización de la plantilla HTML para 'lista_minerales', pasando los datos de minerales al template
    return render_template('Almacen/Minerales/lista_minerales.html', minerales=minerales)

# Definición de la ruta '/lista_recursos'
@app.route('/lista_recursos')
def lista_recursos():
    # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'lista_recursos' que retorna una lista de recursos
    cur.execute("SELECT * FROM lista_recursos()")
    recursos = cur.fetchall()  
    
    # Cierre del cursor y de la conexión a la base de datos
    cur.close()  
    connection().close()  
    
    # Renderización de la plantilla HTML para 'lista_recursos', pasando los datos de recursos al template
    return render_template('Personal/Recursos/lista_recursos.html', recursos=recursos)

# Definición de la ruta '/lista_inventario'
@app.route('/lista_inventario')
def lista_inventario():
    # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'lista_inventario' que retorna una lista de inventario
    cur.execute("SELECT * FROM lista_inventario()")
    inventario = cur.fetchall()  
    
    # Cierre del cursor y de la conexión a la base de datos
    cur.close()  
    connection().close()  
    
    # Renderización de la plantilla HTML para 'lista_inventario', pasando los datos de inventario al template
    return render_template('Almacen/Inventario/lista_operaciones.html', inventario=inventario)

# Definición de la ruta '/lista_solicitudes'
@app.route('/lista_solicitudes')
def lista_solicitudes():
    # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'lista_solicitudes' que retorna una lista de solicitudes
    cur.execute("SELECT * FROM lista_solicitudes()")
    solicitudes = cur.fetchall()  
    
    # Cierre del cursor y de la conexión a la base de datos
    cur.close()  
    connection().close()  
    
    # Renderización de la plantilla HTML para 'lista_solicitudes', pasando los datos de solicitudes al template
    return render_template('Alianzas/Solicitudes/lista_solicitudes.html', solicitudes=solicitudes)

# Definición de la ruta '/lista_proyectos_config'
@app.route('/lista_proyectos_config')
def lista_proyectos():
    # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'lista_proyectos' que retorna una lista de proyectos
    cur.execute("SELECT * FROM lista_proyectos_config()")
    proyectos = cur.fetchall()  
    
    # Cierre del cursor y de la conexión a la base de datos
    cur.close()  
    connection().close()  
    
    # Renderización de la plantilla HTML para 'lista_proyectos', pasando los datos de proyectos al template
    return render_template('Proyecto_Config/Proyecto/lista_proyectos.html', proyectos=proyectos)

# Definición de la ruta '/lista_etapas_config'
@app.route('/lista_etapas_config')
def lista_etapas():
    # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'lista_etapas' que retorna una lista de etapas
    cur.execute("SELECT * FROM lista_etapas_config()")
    etapas = cur.fetchall()  
    
    # Cierre del cursor y de la conexión a la base de datos
    cur.close()  
    connection().close()  
    
    # Renderización de la plantilla HTML para 'lista_etapas', pasando los datos de etapas al template
    return render_template('Proyecto_Config/Etapa/lista_etapas.html', etapas=etapas)

# Definición de la ruta '/lista_actividades_config'
@app.route('/lista_actividades_config')
def lista_actividades():
    # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'lista_actividades' que retorna una lista de actividades
    cur.execute("SELECT * FROM lista_actividades_config()")
    actividades = cur.fetchall()  
    
    # Cierre del cursor y de la conexión a la base de datos
    cur.close()  
    connection().close()  
    
    # Renderización de la plantilla HTML para 'lista_actividades', pasando los datos de actividades al template
    return render_template('Proyecto_Config/Actividad/lista_actividades.html', actividades=actividades)

if __name__ == '__main__': 
    app.run(debug=True) 