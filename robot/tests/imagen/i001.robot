*** Settings ***
Resource   ../../resources/imagen.robot

*** Test Cases ***
I001 Crear una imagen
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
    Enfocar Boton Añadir Imagen
    Capture Page Screenshot    paso-04.png
    Dar Click En Boton Añadir Imagen

    # Paso 5
    Seleccionar Archivo Imagen    ${NOMBRE IMAGEN}.${EXTENSION IMAGEN}
    Capture Page Screenshot    paso-05.png

    # Paso 6
    Seleccionar Nombre Producto    ${NOMBRE PRODUCTO}
    Capture Page Screenshot    paso-06.png

    # Paso 10
    Enforcar Boton Grabar
    Capture Page Screenshot    paso-07.png
    Dar Click En Boton Grabar

    Set Selenium Speed    0s

    # Resultados esperados
    Wait Until Location Is        ${URL IMAGEN ABSOLUTA}/
    Mensaje Exitoso Con Nombre Imagen Debe Estar Visible    ${NOMBRE IMAGEN}
    ${numero fila imagen}=    Buscar Numero Fila Imagen    ${NOMBRE IMAGEN}    ${NOMBRE PRODUCTO}
    Fila Debe Contener Imagen    ${numero fila imagen}    ${NOMBRE IMAGEN}    ${NOMBRE PRODUCTO}
    Resaltar Fila Numero    ${numero fila imagen}
    Sleep    ${DELAY}
    Tomar Captura Resultado Prueba

    [Teardown]    Close Browser
