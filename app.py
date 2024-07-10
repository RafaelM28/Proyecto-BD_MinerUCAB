from flask import flash, Flask, render_template, request, redirect, url_for, jsonify# Importación de Flask y render_template para renderizar plantillas HTML
import psycopg2 # Importación de psycopg2 para la conexión a PostgreSQL
import json # Importación de json para manejar datos JSON
import os

# Inicialización de la aplicación Flask, especificando la carpeta que contiene las plantillas HTML
app = Flask(__name__, template_folder='frontend') 
app.secret_key = os.urandom(16)

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
@app.route('/lista_solicitudes', methods=['GET'])
def lista_solicitudes():
    sort = request.args.get('sort', 'pedido_codigo')  # Orden por defecto: número
    order = request.args.get('order', 'asc')  # Orden ascendente por defecto
    search = request.args.get('search', '')
    query = "SELECT * FROM lista_solicitudes()"
    
    # Añadir condición de búsqueda si hay un término de búsqueda
    if search:
        query += f" WHERE CAST(pedido_codigo AS TEXT) LIKE '%{search}%' OR CAST(pedido_fecha_emision AS TEXT) LIKE '%{search}%' OR aliado LIKE '%{search}%' OR pedido_estatus LIKE '%{search}%'"

    # Añadir ordenamiento
    query += f" ORDER BY {sort} {order}"

    # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
    cur = connection().cursor()
    cur.execute(query)
    solicitudes = cur.fetchall()  
    
    # Cierre del cursor y de la conexión a la base de datos
    cur.close()  
    connection().close()  
    
    # Renderización de la plantilla HTML para 'lista_solicitudes_compras', pasando los datos de solicitudes al template
    return render_template('Alianzas/Solicitudes/lista_solicitudes_compras.html', solicitudes=solicitudes)

@app.route('/register_solicitud', methods=['GET','POST'])
def register_solicitud(): 
    if request.method == 'POST':	
        # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
        cur = connection().cursor()

        aliado = request.form['aliado']
        # Inicializar la lista de tuplas para 'tablaMinerales'
        tablaMinerales = []
        # Suponiendo que los campos del formulario vienen indexados (mineral[0], cantidad[0], precio[0], ...)
        i = 0
        while True:
            try:
                # Intentar obtener el conjunto de datos para cada mineral
                mineral = request.form[f'mineral[{i}]']
                cantidad = request.form[f'cantidad[{i}]']
                precio = request.form[f'precio[{i}]']
                tablaMinerales.append((mineral, int(cantidad), float(precio)))
                i += 1
            except KeyError:
                # Si no hay más minerales, romper el ciclo
                break
        
        # Construir la parte de la llamada que incluye 'tablaMinerales'
        tablaMinerales_str = ", ".join([
            f"CAST(ROW('{mineral}', {cantidad}, {precioUnit}) AS tipo_detalle_compra)" 
            for mineral, cantidad, precioUnit in tablaMinerales
        ])
        # Formatear la llamada completa al procedimiento almacenado
        query = f"""CALL sp_crear_solicitud_compra({aliado},ARRAY[{tablaMinerales_str}])"""
                
        # Ejecutar la consulta
        cur.execute(query)
        # Commit de los cambios
        cur.connection.commit()
        # Cerrar el cursor 
        cur.connection.close()
        cur.close()
        
        return redirect(url_for('lista_solicitudes'))
    
    cur = connection().cursor()
    cur.execute("SELECT * FROM lista_aliados_solicitud()")
    aliados = cur.fetchall()
    cur.close()
    connection().close()
    return render_template('Alianzas/Solicitudes/crear_solicitud_compra.html', aliados=aliados)

# Definición de la ruta '/get_minerales_aliados/<int:aliado_id>'
@app.route('/get_minerales_aliados/<int:aliado_id>')
def get_minerales_aliados(aliado_id: int):
    cursor = connection().cursor()
    # Ejecución de la función almacenada 'lista_minerales_solicitud' que retorna una lista de minerales de un aliado
    cursor.execute("SELECT * FROM lista_minerales_solicitud(%s)", (aliado_id,))
    minerales = cursor.fetchall()
    cursor.close()
    connection().close()
    # Retorno de los minerales en formato JSON
    return jsonify([{"mineral_codigo": m[0], "mineral_nombre": m[1]} for m in minerales])

# Definición de la ruta '/chequear_estatus_pedido_compra/<int:pedido_codigo>'
@app.route('/chequear_estatus_pedido_compra/<int:pedido_codigo>/<int:aliado_id>')
def chequear_estatus_pedido_compra(pedido_codigo, aliado_id):
    conn = connection()
    cursor = conn.cursor()
    # Ejecución de la función almacenada 'obtener_estatus_pedido_compra' que retorna el estatus de un pedido de compra
    cursor.execute("SELECT * FROM obtener_estatus_pedido_compra(%s)", (pedido_codigo,))
    estatus = cursor.fetchone()[0] 
    cursor.close()
    conn.close()

    # Definir conjuntos de estatus
    conjunto_en_espera = {'En proceso', 'En espera', 'En revisión'}
    conjunto_por_pagar = {'Por pagar', 'Confirmado', 'Aprobado'}
    conjunto_pagado = {'Pagado', 'Completado'}
    
    # Decidir a qué ruta redirigir basado en el resultado
    if estatus in conjunto_en_espera:
        return redirect(url_for('ver_solicitud_compra', pedido_codigo=pedido_codigo))
    elif estatus in conjunto_por_pagar:
        return redirect(url_for('ver_solicitud_compra_confirmada', pedido_codigo=pedido_codigo))
    elif estatus in conjunto_pagado:    
        return redirect(url_for('ver_solicitud_compra_pagada', pedido_codigo=pedido_codigo, aliado_id=aliado_id))
    else:
        return "Estatus desconocido o pedido no encontrado", 404    
    
# Definición de la ruta '/ver_solicitud_compra/<int:pedido_codigo>'
@app.route('/ver_solicitud_compra/<int:pedido_codigo>', methods=['GET'])
def ver_solicitud_compra(pedido_codigo):
    # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'ver_solicitud_compra' que retorna los datos de una solicitud de compra
    cur.execute("SELECT * FROM ver_solicitud_compra(%s)", (pedido_codigo,))
    solicitud = cur.fetchone() 
    cur.close()  
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'obtener_detalles_pedido_compra' que retorna los detalles de una solicitud de compra
    cur.execute("SELECT * FROM obtener_detalles_pedido_compra(%s)", (pedido_codigo,))
    detalles = cur.fetchall()
    cur.close()
    connection().close()  
    
    # Renderización de la plantilla HTML para 'ver_solicitud_compra', pasando los datos de la solicitud al template
    return render_template('Alianzas/Solicitudes/ver_solicitud_compra.html', solicitud=solicitud, detalles=detalles)

# Definición de la ruta '/ver_solicitud_compra_confirmada/<int:pedido_codigo>'
@app.route('/ver_solicitud_compra_confirmada/<int:pedido_codigo>', methods=['GET'])
def ver_solicitud_compra_confirmada(pedido_codigo):
    # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'ver_solicitud_compra' que retorna los datos de una solicitud de compra
    cur.execute("SELECT * FROM ver_solicitud_compra(%s)", (pedido_codigo,))
    solicitud = cur.fetchone() 
    cur.close()  
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'obtener_detalles_pedido_compra' que retorna los detalles de una solicitud de compra
    cur.execute("SELECT * FROM obtener_detalles_pedido_compra(%s)", (pedido_codigo,))
    detalles = cur.fetchall()
    cur.close()
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'obtener_metodos_pago' que retorna los métodos de pago
    cur.execute("SELECT * FROM obtener_metodos_pago()")
    metodos = cur.fetchall()
    cur.close()
    connection().close()  
    
    # Renderización de la plantilla HTML para 'ver_solicitud_compra', pasando los datos de la solicitud al template
    return render_template('Alianzas/Solicitudes/ver_solicitud_compra_confirmada.html', solicitud=solicitud, detalles=detalles, metodos=metodos)

@app.route('/register_pago', methods=['POST'])
def register_pago():
    try:
        # Obtener los datos del formulario
        pedido_codigo = request.form['numero-orden']
        aliado_id = request.form['razon-social']
        metodo_pago = request.form['metodo-pago']
        metodo_codigo, tipo_metodo = metodo_pago.split('|', 1)
        monto_pedido = request.form['total']
        fecha_pago = request.form['fecha-pago']
        
        # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
        conn = connection()
        cursor = conn.cursor()
        cursor.execute("CALL sp_crear_pago_compra(%s, %s, %s, %s, %s, %s)", (pedido_codigo, aliado_id, metodo_codigo, tipo_metodo, monto_pedido, fecha_pago))
        conn.commit()
    
    except psycopg2.errors.RaiseException as e:
        # Manejo de excepciones en caso de fallo en la conexión
        flash('El monto del efectivo no es suficiente para realizar el pago.')
        return redirect(url_for('mostrar_error', pedido_codigo=pedido_codigo))
    
    finally:
        # Asegúrate de cerrar el cursor y la conexión en el bloque finally para que se ejecuten sin importar si hubo una excepción o no
        cursor.close()
        conn.close()

    # Si todo fue exitoso, rediriges al usuario a otra página
    return redirect(url_for('update_estatus', pedido_codigo=pedido_codigo, aliado_id=aliado_id))

# Definición de la ruta '/mostrar_error/<int:pedido_codigo>'
@app.route('/mostrar_error/<int:pedido_codigo>')
def mostrar_error(pedido_codigo):
        return redirect(url_for('ver_solicitud_compra_confirmada', pedido_codigo=pedido_codigo))
    
# Definición de la ruta '/mostrar_error/<int:pedido_codigo>/<int:cliente_id>'
@app.route('/mostrar_error_venta/<int:pedido_codigo>/<int:cliente_id>')
def mostrar_error_venta(pedido_codigo, cliente_id):
        return redirect(url_for('ver_pedido_venta_confirmada', pedido_codigo=pedido_codigo, cliente_id=cliente_id))

# Definición de la ruta '/ver_solicitud_compra_pagada/<int:pedido_codigo>/<int:aliado_id>'
@app.route('/ver_solicitud_compra_pagada/<int:pedido_codigo>/<int:aliado_id>', methods=['GET'])
def ver_solicitud_compra_pagada(pedido_codigo, aliado_id):
    # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'ver_solicitud_compra' que retorna los datos de una solicitud de compra
    cur.execute("SELECT * FROM ver_solicitud_compra(%s)", (pedido_codigo,))
    solicitud = cur.fetchone() 
    cur.close()  
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'obtener_detalles_pedido_compra' que retorna los detalles de una solicitud de compra
    cur.execute("SELECT * FROM obtener_detalles_pedido_compra(%s)", (pedido_codigo,))
    detalles = cur.fetchall()
    cur.close()
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'obtener_metodos_pago' que retorna los métodos de pago
    cur.execute("SELECT * FROM obtener_pago_compra(%s, %s)", (pedido_codigo,aliado_id))
    pago = cur.fetchone()
    cur.close()
    connection().close()  
    
    # Renderización de la plantilla HTML para 'ver_solicitud_compra', pasando los datos de la solicitud al template
    return render_template('Alianzas/Solicitudes/ver_solicitud_compra_pagada.html', solicitud=solicitud, detalles=detalles, pago=pago)

# Definición de la ruta '/ver_solicitud_compra/update_estatus/<int:pedido_codigo>/<int:aliado_id>'
@app.route('/ver_solicitud_compra/update_estatus/<int:pedido_codigo>/<int:aliado_id>')
def update_estatus(pedido_codigo, aliado_id):
    # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'update_estatus_pedido_compra' que actualiza el estatus de un pedido de compra
    cur.execute("CALL update_estatus_pedido_compra(%s,%s)", (pedido_codigo,aliado_id))
    # Commit de los cambios
    cur.connection.commit()
    
    cur.close()
    connection().close() 
    
    return redirect(url_for('lista_solicitudes'))

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

# Definición de la ruta '/lista_pedidos_venta'
@app.route('/lista_pedidos_venta')
def lista_pedidos_venta():
    # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
    cur = connection().cursor()
    # Ejecución de la función almacenada 'lista_pedidos_venta' que retorna una lista de pedidos de venta
    cur.execute("SELECT * FROM lista_pedidos_venta()")
    pedidos = cur.fetchall()  
    
    # Cierre del cursor y de la conexión a la base de datos
    cur.close()  
    connection().close()  
    
    # Renderización de la plantilla HTML para 'lista_pedidos_venta', pasando los datos de pedidos al template
    return render_template('Ventas/lista_pedidos_venta.html', pedidos=pedidos)


# Definición de la ruta '/register_pedido'
@app.route('/register_pedido', methods=['GET','POST'])
def register_pedido(): 
    if request.method == 'POST':	
        # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
        cur = connection().cursor()

        cliente = request.form['cliente']
        # Inicializar la lista de tuplas para 'tablaMinerales'
        tablaMinerales = []
        # Suponiendo que los campos del formulario vienen indexados (mineral[0], cantidad[0], precio[0], ...)
        i = 0
        while True:
            try:
                # Intentar obtener el conjunto de datos para cada mineral
                mineral = request.form[f'mineral[{i}]']
                cantidad = request.form[f'cantidad[{i}]']
                precio = request.form[f'precio[{i}]']
                tablaMinerales.append((mineral, int(cantidad), float(precio)))
                i += 1
            except KeyError:
                # Si no hay más minerales, romper el ciclo
                break
        
        # Construir la parte de la llamada que incluye 'tablaMinerales'
        tablaMinerales_str = ", ".join([
            f"CAST(ROW('{mineral}', {cantidad}, {precioUnit}) AS tipo_detalle_venta)" 
            for mineral, cantidad, precioUnit in tablaMinerales
        ])
        # Formatear la llamada completa al procedimiento almacenado
        query = f"""CALL sp_crear_pedido_venta({cliente},ARRAY[{tablaMinerales_str}])"""
                
        # Ejecutar la consulta
        cur.execute(query)
        # Commit de los cambios
        cur.connection.commit()
        # Cerrar el cursor 
        cur.connection.close()
        cur.close()
        
        return redirect(url_for('lista_pedidos_venta'))
    
    cur = connection().cursor()
    cur.execute("SELECT * FROM lista_clientes_venta()")
    clientes = cur.fetchall()
    cur.close()
    cur = connection().cursor()
    cur.execute("SELECT * FROM lista_minerales_venta()")
    minerales = cur.fetchall()
    cur.close()
    
    connection().close()
    return render_template('Ventas/crear_pedido_venta.html', clientes=clientes, minerales=minerales)

# Definición de la ruta '/chequear_estatus_pedido_venta/<int:pedido_codigo>/<int:cliente_id>'
@app.route('/chequear_estatus_pedido_venta/<int:pedido_codigo>/<int:cliente_id>')
def chequear_estatus_pedido_venta(pedido_codigo, cliente_id):
    conn = connection()
    cursor = conn.cursor()
    # Ejecución de la función almacenada 'obtener_estatus_pedido_venta' que retorna el estatus de un pedido de venta
    cursor.execute("SELECT * FROM obtener_estatus_pedido_venta(%s)", (pedido_codigo,))
    estatus = cursor.fetchone()[0] 
    cursor.close()
    conn.close()

    # Definir conjuntos de estatus
    conjunto_en_espera = {'En proceso', 'En espera', 'En revisión'}
    conjunto_por_pagar = {'Por pagar', 'Confirmado', 'Aprobado'}
    conjunto_pagado = {'Pagado', 'Completado'}
    
    # Decidir a qué ruta redirigir basado en el resultado
    if estatus in conjunto_en_espera:
        return redirect(url_for('ver_pedido_venta', pedido_codigo=pedido_codigo))
    elif estatus in conjunto_por_pagar:
        return redirect(url_for('ver_pedido_venta_confirmada', pedido_codigo=pedido_codigo, cliente_id=cliente_id))
    elif estatus in conjunto_pagado:    
        return redirect(url_for('ver_pedido_venta_pagada', pedido_codigo=pedido_codigo, cliente_id=cliente_id))
    else:
        return "Estatus desconocido o pedido no encontrado", 404   
    
# Definición de la ruta '/ver_pedido_venta/<int:pedido_codigo>'
@app.route('/ver_pedido_venta/<int:pedido_codigo>', methods=['GET'])
def ver_pedido_venta(pedido_codigo):
    # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'ver_solicitud_venta' que retorna los datos de pedido de venta
    cur.execute("SELECT * FROM ver_solicitud_venta(%s)", (pedido_codigo,))
    pedido = cur.fetchone() 
    cur.close()  
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'obtener_detalles_pedido_venta' que retorna los detalles de un pedido de venta
    cur.execute("SELECT * FROM obtener_detalles_pedido_venta(%s)", (pedido_codigo,))
    detalles = cur.fetchall()
    cur.close()
    connection().close()  
    
    # Renderización de la plantilla HTML para 'ver_pedido_venta', pasando los datos del pedido al template
    return render_template('Ventas/ver_pedido_venta.html', pedido=pedido, detalles=detalles) 

# Definición de la ruta '/ver_pedido_venta_confirmada/<int:pedido_codigo>/<int:cliente_id>'
@app.route('/ver_pedido_venta_confirmada/<int:pedido_codigo>/<int:cliente_id>', methods=['GET'])
def ver_pedido_venta_confirmada(pedido_codigo, cliente_id):
    # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'ver_solicitud_venta' que retorna los datos de un pedido de venta
    cur.execute("SELECT * FROM ver_solicitud_venta(%s)", (pedido_codigo,))
    pedido = cur.fetchone() 
    cur.close()  
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'obtener_detalles_pedido_venta' que retorna los detalles de un pedido de venta
    cur.execute("SELECT * FROM obtener_detalles_pedido_venta(%s)", (pedido_codigo,))
    detalles = cur.fetchall()
    cur.close()
    connection().close()  
    
    # Ejecución de la función almacenada 'obtener_metodos_pago_cliente' que retorna los métodos de pago del cliente
    cur.execute("SELECT * FROM obtener_metodos_pago_cliente(%s)", (cliente_id,))
    metodos = cur.fetchall()
    cur.close()
    connection().close()  
    
    # Renderización de la plantilla HTML para 'ver_pedido_venta', pasando los datos del pedido al template
    return render_template('Ventas/ver_pedido_venta_confirmada.html', pedido=pedido, detalles=detalles, metodos=metodos)

# Definición de la ruta '/register_pago_venta'
@app.route('/register_pago_venta', methods=['POST'])
def register_pago_venta():
    try:
        # Obtener los datos del formulario
        pedido_codigo = request.form['numero-orden']
        cliente_id = request.form['razon-social']
        metodo_pago = request.form['metodo-pago']
        metodo_codigo, tipo_metodo = metodo_pago.split('|', 1)
        monto_pedido = request.form['total']
        fecha_pago = request.form['fecha-pago']
        
        # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
        conn = connection()
        cursor = conn.cursor()
        cursor.execute("CALL sp_crear_pago_venta(%s, %s, %s, %s, %s, %s)", (pedido_codigo, cliente_id, metodo_codigo, tipo_metodo, monto_pedido, fecha_pago))
        conn.commit()
    
    except psycopg2.errors.RaiseException as e:
        # Manejo de excepciones en caso de fallo en la conexión
        flash('El monto del efectivo no es suficiente para realizar el pago.')
        return redirect(url_for('mostrar_error_venta', pedido_codigo=pedido_codigo, cliente_id=cliente_id))
    
    finally:
        # Asegúrate de cerrar el cursor y la conexión en el bloque finally para que se ejecuten sin importar si hubo una excepción o no
        cursor.close()
        conn.close()

    # Si todo fue exitoso, rediriges al usuario a otra página
    return redirect(url_for('update_estatus', pedido_codigo=pedido_codigo, cliente_id=cliente_id))

# Definición de la ruta '/ver_pedido_venta_pagada/<int:pedido_codigo>/<int:cliente_id>'
@app.route('/ver_pedido_venta_pagada/<int:pedido_codigo>/<int:cliente_id>', methods=['GET'])
def ver_pedido_venta_pagada(pedido_codigo, cliente_id):
    # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'ver_solicitud_venta' que retorna los datos de un pedido de venta
    cur.execute("SELECT * FROM ver_solicitud_venta(%s)", (pedido_codigo,))
    pedido = cur.fetchone() 
    cur.close()  
    cur = connection().cursor()
    
    # Ejecución de la función almacenada 'obtener_detalles_pedido_venta' que retorna los detalles de un pedido de venta
    cur.execute("SELECT * FROM obtener_detalles_pedido_venta(%s)", (pedido_codigo,))
    detalles = cur.fetchall()
    cur.close()
    connection().close()  
    
    # Ejecución de la función almacenada 'obtener_metodos_pago_venta' que retorna los métodos de pago de la venta
    cur.execute("SELECT * FROM obtener_pago_venta(%s, %s)", (pedido_codigo,cliente_id))
    pago = cur.fetchone()
    cur.close()
    connection().close()  
    
    # Renderización de la plantilla HTML para 'ver_pedido_venta', pasando los datos del pedido al template
    return render_template('Ventas/ver_pedido_venta_pagada.html', pedido=pedido, detalles=detalles, pago=pago)

# Definición de la ruta '/ver_pedido_venta/update_estatus/<int:pedido_codigo>/<int:cliente_id>'
@app.route('/ver_pedido_venta/update_estatus/<int:pedido_codigo>/<int:cliente_id>')
def update_estatus_venta(pedido_codigo, cliente_id):
    # Establecimiento de la conexión y creación de un cursor para ejecutar consultas
    cur = connection().cursor()

    # Ejecución de la función almacenada 'update_estatus_pedido_venta' que actualiza el estatus de un pedido de venta
    cur.execute("CALL update_estatus_pedido_venta(%s,%s)", (pedido_codigo,cliente_id))
    # Commit de los cambios
    cur.connection.commit()
    
    cur.close()
    connection().close() 
    
    return redirect(url_for('lista_pedidos_venta'))

if __name__ == '__main__': 
    app.run(debug=True) 