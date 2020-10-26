*** Settings ***
Resource   ../../resources/producto.robot

*** Test Cases ***
P003 Modificar un producto
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
    Enfocar Enlace Productos
    Capture Page Screenshot    paso-03.png
    Dar Click En Enlace Productos

    # Paso 4
    Ingresar Texto Busqueda    ${NOMBRE PRODUCTO}
    Capture Page Screenshot    paso-04.png

    # Paso 5
    Enforcar Boton Buscar
    Capture Page Screenshot    paso-05.png
    producto.Dar Click En Boton Buscar

    # Paso 6
    Tabla Resultados Debe Contener    filas=1
    ${numero fila producto}=    Buscar Numero Fila Producto    ${NOMBRE PRODUCTO}
    ...    ${NOMBRE MARCA}    ${PRECIO PRODUCTO}
    Enfocar Enlace Nombre Producto    ${numero fila producto}
    Capture Page Screenshot    paso-06.png
    Dar Click En Enlace Nombre Producto    ${numero fila producto}
    Pagina Modificar Producto Debe Estar Abierta

    # Paso 7
    Ingresar Nombre Producto    ${NOMBRE PRODUCTO MODIFICADO}
    Capture Page Screenshot    paso-07.png

    # Paso 8
    Ingresar Precio Producto    ${PRECIO PRODUCTO MODIFICADO}
    Capture Page Screenshot    paso-08.png

    # Paso 9
    Ingresar Descripcion Producto    ${DESCRIPCION PRODUCTO MODIFICADA}
    Capture Page Screenshot    paso-09.png

    # Paso 10
    Enforcar Boton Grabar
    Capture Page Screenshot    paso-10.png
    Dar Click En Boton Grabar

    Set Selenium Speed    0s

    # Resultados esperados
    Wait Until Location Contains    ${URL PRODUCTO ABSOLUTA}/?q=
    Mensaje Exitoso Con Nombre Producto Debe Estar Visible    ${NOMBRE PRODUCTO MODIFICADO}
    ${numero fila producto}=    Buscar Numero Fila Producto    ${NOMBRE PRODUCTO MODIFICADO}
    ...    ${NOMBRE MARCA}    ${PRECIO PRODUCTO MODIFICADO}
    Fila Debe Contener Producto    ${numero fila producto}    ${NOMBRE PRODUCTO MODIFICADO}
    ...    ${NOMBRE MARCA}    ${PRECIO PRODUCTO MODIFICADO}
    Resaltar Fila Numero    ${numero fila producto}
    Sleep    ${DELAY}
    Tomar Captura Resultado Prueba

    [Teardown]    Close Browser
