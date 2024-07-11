from platform import python_version
from pyreportjasper import PyReportJasper
import webbrowser
import os

def mostrar_reporte(nombre_reporte,nombre_reporte_pdf,nombre_reporte_extension_pdf):
    REPORTS_DIR = os.path.join(os.path.abspath(os.path.dirname(__file__)),'reportes')
    REPORTS_PDF_DIR = os.path.join(os.path.abspath(os.path.dirname(__file__)),'reportes_pdf')
    input_file = os.path.join(REPORTS_DIR, nombre_reporte)
    output_file = os.path.join(REPORTS_PDF_DIR, nombre_reporte_pdf)

    try:
        conn = {
            'jdbc_driver':'org.postgresql.Driver',
            'jdbc_dir':'/venv/py3.8.18/lib/python3.8/site-packages/pyreportjasper/libs/jdbc', 
            'driver': 'postgres',
            'username': 'postgres',
            'password': 'admin1234*',
            'host': 'localhost',
            'database': 'minerucab',
            'schema': 'public',
            'port': '5432'
            }
        print("Conexión exitosa")
        pyreportjasper = PyReportJasper()
        pyreportjasper.config(
        input_file,
        output_file,
        db_connection=conn,
        output_formats=["pdf"],
        parameters={'python_version': python_version()},
        locale='en_US'
        )
        pyreportjasper.process_report()
        path = os.path.join(REPORTS_PDF_DIR, nombre_reporte_extension_pdf)
        webbrowser.open_new(path)
    except Exception as e:
        # Manejo de excepciones en caso de fallo en la conexión
        print("Ocurrió un error al conectar a la base de datos:")
