# challenge

Automation Challenge:

Los ejercicios han sido desarrollados con Robot Framework.

REQUISITOS:
1. Instalar Python de https://www.python.org/downloads/release/python-3912/. En la instalación asegurarse darle check al ADD PYTHON TO PATH. Para validar si se instaló bien ejecutar python --version
2. Abrir Powershell ISE como privilegios de admnistrador y abrir el archivo download_chromedriver, ejecutarlo; este permitirá descargar el chromedriver y agregarlo al path. Si existiera algún issue con esta ejecución, descargarlo de https://chromedriver.chromium.org/downloads y colocarlo dentro de la carpeta del proyecto.
3. Abrir un cmd con ubicación del proyecto para instalar las librerías con el comando: pip install -r requirements.txt

EJECUCIÓN TESTS:
- Scenarios -> web -> Cart.robot
- Scenarios -> api -> Pet.robot

* Dentro del cmd, ejecutar las pruebas de UI con el comando(el comando contiene un espacio y (.) al final del tag): 
	python -m robot --log ui.html -i add_cart .
* Ejecutar las pruebas de API con el comando: 
	python -m robot --log api.html -i api .
* Los reportes de los tests los encontrarás en la carpeta con el nombre ui.html y api.html.

