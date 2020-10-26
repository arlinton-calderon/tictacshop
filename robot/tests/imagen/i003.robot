*** Settings ***
Resource   ../../resources/imagen.robot

*** Test Cases ***
P003 Modificar una imagen
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
    ${numero fila imagen}=    Buscar Numero Fila Imagen    ${NOMBRE IMAGEN}
    ...    ${NOMBRE PRODUCTO}
    Enfocar Enlace Nombre Imagen    ${numero fila imagen}
    Capture Page Screenshot    paso-06.png
    Dar Click En Enlace Nombre Imagen    ${numero fila imagen}
    Pagina Modificar Imagen Debe Estar Abierta

    # Paso 7
    Seleccionar Archivo Imagen    ${NOMBRE IMAGEN MODIFICADO}.${EXTENSION IMAGEN}
    Capture Page Screenshot    paso-07.png

    # Paso 8
    Enforcar Boton Grabar
    Capture Page Screenshot    paso-10.png
    Dar Click En Boton Grabar

    Set Selenium Speed    0s

    # Resultados esperados
    Wait Until Location Contains    ${URL IMAGEN ABSOLUTA}/?q=
    Mensaje Exitoso Con Nombre Imagen Debe Estar Visible     ${NOMBRE IMAGEN MODIFICADO}
    ${numero fila imagen}=    Buscar Numero Fila Imagen    ${NOMBRE IMAGEN MODIFICADO}
    ...    ${NOMBRE PRODUCTO}
    Fila Debe Contener Imagen    ${numero fila imagen}    ${NOMBRE IMAGEN MODIFICADO}
    ...    ${NOMBRE PRODUCTO}
    Resaltar Fila Numero    ${numero fila imagen}
    Sleep    ${DELAY}
    Tomar Captura Resultado Prueba

    [Teardown]    Close Browser
