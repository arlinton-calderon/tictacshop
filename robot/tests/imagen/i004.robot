*** Settings ***
Resource   ../../resources/imagen.robot

*** Test Cases ***
I004 Eliminar una imagen
    Aplicacion Debe Estar En Ejecucion

    Configurar Directorio Capturas

    # Paso 1
    Abrir Navegador
    Sleep    ${DELAY}
    Take Screenshot    paso-01.jpg

    Set Selenium Speed    ${DELAY}

    # Paso 2
    Ir A Pagina Administracion
    Ingresar Como Administrador
    Sleep    ${DELAY}
    Take Screenshot    paso-02.jpg

    # Paso 3
    Enfocar Enlace Imagenes
    Capture Page Screenshot    paso-03.png
    Dar Click En Enlace Imagenes

    # Paso 4
    Ingresar Texto Busqueda    ${NOMBRE PRODUCTO}
    Capture Page Screenshot    paso-04.png

    # Paso 5
    Enforcar Boton Buscar
    Capture Page Screenshot    paso-05.png
    imagen.Dar Click En Boton Buscar

    # Paso 6
    Tabla Resultados Debe Contener    filas=1
    ${numero fila imagen}=    Buscar Numero Fila Imagen    ${NOMBRE IMAGEN MODIFICADO}
    ...    ${NOMBRE PRODUCTO}
    Enfocar Enlace Nombre Imagen    ${numero fila imagen}
    Capture Page Screenshot    paso-06.png
    Dar Click En Enlace Nombre Imagen    ${numero fila imagen}
    Pagina Modificar Imagen Debe Estar Abierta

    # Paso 7
    Enforcar Enlace Eliminar
    Capture Page Screenshot    paso-07.png
    Dar Click En Enlace Eliminar

    # Paso 8
    Enforcar Boton Confirmar Eliminar
    Capture Page Screenshot    paso-08.png
    Dar Click En Boton Confirmar Eliminar

    Set Selenium Speed    0s

    # Resultados esperados
    Location Should Contain    ${URL IMAGEN ABSOLUTA}/?q=
    Mensaje Exitoso Con Nombre Imagen Debe Estar Visible    ${NOMBRE IMAGEN MODIFICADO}
    Tabla Resultados Debe Contener    filas=0
    Sleep    ${DELAY}
    Tomar Captura Resultado Prueba

    [Teardown]    Close Browser
