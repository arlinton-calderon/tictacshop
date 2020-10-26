*** Settings ***
Resource   ../../resources/producto.robot

*** Test Cases ***
P001 Crear un producto
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
    Enfocar Boton Añadir Producto
    Capture Page Screenshot    paso-04.png
    Dar Click En Boton Añadir Producto

    # Paso 5
    Ingresar Nombre Producto    ${NOMBRE PRODUCTO}
    Capture Page Screenshot    paso-05.png

    # Paso 6
    Seleccionar Nombre Marca    ${NOMBRE MARCA}
    Capture Page Screenshot    paso-06.png

    # Paso 7
    Seleccionar Nombres Categorias    ${NOMBRE CATEGORIA}
    Capture Page Screenshot    paso-07.png

    # Paso 8
    Ingresar Precio Producto    ${PRECIO PRODUCTO}
    Capture Page Screenshot    paso-08.png

    # Paso 9
    Ingresar Descripcion Producto    ${DESCRIPCION PRODUCTO}
    Capture Page Screenshot    paso-09.png

    # Paso 10
    Enforcar Boton Grabar
    Capture Page Screenshot    paso-10.png
    Dar Click En Boton Grabar

    Set Selenium Speed    0s

    # Resultados esperados
    Wait Until Location Is        ${URL PRODUCTO ABSOLUTA}/
    Mensaje Exitoso Con Nombre Producto Debe Estar Visible    ${NOMBRE PRODUCTO}
    ${numero fila producto}=    Buscar Numero Fila Producto    ${NOMBRE PRODUCTO}    ${NOMBRE MARCA}    ${PRECIO PRODUCTO}
    Fila Debe Contener Producto    ${numero fila producto}    ${NOMBRE PRODUCTO}    ${NOMBRE MARCA}    ${PRECIO PRODUCTO}
    Resaltar Fila Numero    ${numero fila producto}
    Sleep    ${DELAY}
    Tomar Captura Resultado Prueba

    [Teardown]    Close Browser
