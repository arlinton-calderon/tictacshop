*** Settings ***
Resource   ../../resources/producto.robot

*** Test Cases ***
P002 Dar click en el botón “Grabar” sin escribir ninguna palabra en los campos de texto ni seleccionar alguna opción de los desplegables y listas del formulario de registro de producto
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
    Enforcar Boton Grabar
    Capture Page Screenshot    paso-05.png
    Dar Click En Boton Grabar

    Set Selenium Speed    0s

    # Resultados esperados
    Location Should Be                     ${URL AÑADIR PRODUCTO ABSOLUTA}/
    Mensaje Error Debe Estar Visible
    Campo Debe Mostrar Mensaje Error       div>${CSS INPUT NOMBRE PRODUCTO}
    Campo Debe Mostrar Mensaje Error       div>div.related-widget-wrapper>${CSS SELECT NOMBRE MARCA}
    Campo Debe Mostrar Mensaje Error       div>div.related-widget-wrapper>${CSS SELECT NOMBRE CATEGORIA}
    Campo Debe Mostrar Mensaje Error       div>${CSS INPUT PRECIO PRODUCTO}
    Campo No Debe Mostrar Mensaje Error    div>${CSS TEXTAREA DESCRIPCION PRODUCTO}
    Sleep                                  ${DELAY}
    Tomar Captura Resultado Prueba

    [Teardown]    Close Browser
