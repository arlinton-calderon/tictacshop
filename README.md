### Instalación

TicTacShop requiere de [Python](https://www.python.org/downloads/release/python-380/) v3.8+ para ejecutarse.

Para Windows.

```
cd tictacshop
python3 -m venv venv
./venv/Source/activate
pip install -r requirements.txt
python tictacshop/manage.py migrate
```

Para Linux.

```
cd tictacshop
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python tictacshop/manage.py migrate
```


### Crear usuario administrativo

Es necesario crear un usuario administrativo (superuser) para acceder a la pagina de administración de la apliación.

```
python tictacshop/manage.py createsuperuser
```


### Ejecutar la aplicación

La aplicación se ejecuta en http://localhost:8000 por defecto.

```
python tictacshop/manage.py runserver
```
