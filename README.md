### Instalación

TicTacShop requiere de [Python](https://www.python.org/downloads/release/python-380/) v3.8 para ejecutarse.

Para Windows.

```
cd tictacshop
python -m venv venv
.\venv\Scripts\activate
pip install -r requirements.txt
python manage.py migrate
```

Para Linux.

```
cd tictacshop
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python manage.py migrate
```


### Crear usuario administrativo

Es necesario crear un usuario administrativo (superuser) para acceder a la pagina de administración de la apliación.

```
python manage.py createsuperuser
```


### Ejecutar la aplicación

La aplicación se ejecuta en http://localhost:8000 por defecto.

```
python manage.py runserver
```
