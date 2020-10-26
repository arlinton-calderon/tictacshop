*** Settings ***
Resource    general.robot

*** Variables ***
### URLs
${URL PRODUCTO RELATIVA}                 ${URL ADMIN RELATIVA}/products/product
${URL PRODUCTO ABSOLUTA}                 ${URL ADMIN ABSOLUTA}/products/product
${URL AÑADIR PRODUCTO RELATIVA}          ${URL PRODUCTO RELATIVA}/add
${URL AÑADIR PRODUCTO ABSOLUTA}          ${URL PRODUCTO ABSOLUTA}/add

### Titulos
${TITULO AÑADIR PRODUCTO}                Añadir producto | ${TITULO ADMIN}
${TITULO MODIFICAR PRODUCTO}             Modificar producto | ${TITULO ADMIN}

### Localizadores
# Lista Productos
${CSS LINK ADMIN PRODUCTOS}              a[href="${URL PRODUCTO RELATIVA}/"]
${CSS LINK AÑADIR PRODUCTO}              ul.object-tools>li>a[href="${URL AÑADIR PRODUCTO RELATIVA}/"]
${CSS LINK MODIFICAR PRODUCTO}           a[href^="${URL PRODUCTO RELATIVA}/"][href*="/change/"]
${CSS CELL NOMBRE PRODUCTO}              th.field-name
${CSS CELL NOMBRE MARCA}                 td.field-brand
${CSS CELL PRECIO PRODUCTO}              td.field-price
# Formulario Registro Producto
${CSS INPUT NOMBRE PRODUCTO}             input#id_name
${CSS SELECT NOMBRE MARCA}               select#id_brand
${CSS SELECT NOMBRE CATEGORIA}           select#id_categories
${CSS INPUT PRECIO PRODUCTO}             input#id_price
${CSS TEXTAREA DESCRIPCION PRODUCTO}     textarea#id_description

### Datos de prueba
# Originales
${NOMBRE PRODUCTO}                       Cámara compacta
${NOMBRE MARCA}                          Sony
${NOMBRE CATEGORIA}                      Cámaras
${PRECIO PRODUCTO}                       1299900
${DESCRIPCION PRODUCTO}                  Sin descripción
# Modificados
${NOMBRE PRODUCTO MODIFICADO}            Cámara compacta Modificado
${PRECIO PRODUCTO MODIFICADO}            1300000
${DESCRIPCION PRODUCTO MODIFICADA}       Sin descripción Modificada

*** Keywords ***
Enfocar Enlace Productos
    Set Focus To Element    css:${CSS LINK ADMIN PRODUCTOS}

Dar Click En Enlace Productos
    Click Link    css:${CSS LINK ADMIN PRODUCTOS}
    Wait Until Location Is    ${URL PRODUCTO ABSOLUTA}/

Enfocar Boton Añadir Producto
    Set Focus To Element    css:${CSS LINK AÑADIR PRODUCTO}

Dar Click En Boton Añadir Producto
    Click Link    css:${CSS LINK AÑADIR PRODUCTO}
    Wait Until Location Contains    ${URL AÑADIR PRODUCTO ABSOLUTA}

Ingresar Nombre Producto
    [Arguments]    ${nombre producto}
    Input Text    css:${CSS INPUT NOMBRE PRODUCTO}    ${nombre producto}

Seleccionar Nombre Marca
    [Arguments]    ${nombre marca}
    Select From List By Label    css:${CSS SELECT NOMBRE MARCA}    ${nombre marca}

Seleccionar Nombres Categorias
    [Arguments]    @{nombres categorias}
    Select From List By Label    css:${CSS SELECT NOMBRE CATEGORIA}    @{nombres categorias}

Ingresar Precio Producto
    [Arguments]    ${precio producto}
    Input Text    css:${CSS INPUT PRECIO PRODUCTO}    ${precio producto}

Ingresar Descripcion Producto
    [Arguments]    ${descripcion producto}
    Input Text    css:${CSS TEXTAREA DESCRIPCION PRODUCTO}    ${descripcion producto}

Mensaje Exitoso Con Nombre Producto Debe Estar Visible
    [Arguments]    ${nombre producto}
    Element Should Contain    css:${CSS DIV MENSAJE EXITOSO}    ${nombre producto}

Dar Click En Boton Buscar
    general.Dar Click En Boton Buscar
    Location Should Contain    ${URL PRODUCTO ABSOLUTA}/?q=

Pagina Modificar Producto Debe Estar Abierta
    Location Should Contain    ${URL PRODUCTO ABSOLUTA}
    Title Should Be    ${TITULO MODIFICAR PRODUCTO}

Buscar Numero Fila Producto
    [Arguments]    ${nombre producto}    ${nombre marca}    ${precio producto}

    ${filtro fila producto}=    Create Dictionary    ${CSS CELL NOMBRE PRODUCTO}=${nombre producto}
    ...    ${CSS CELL NOMBRE MARCA}=${nombre marca}
    ...    ${CSS CELL PRECIO PRODUCTO}=${precio producto}

    ${numero fila producto}=    Buscar Numero Fila    ${CSS TABLE TABLA RESULTADO}    ${filtro fila producto}

    [Return]    ${numero fila producto}

Generar CSS Enlace Nombre Producto
    [Arguments]    ${numero fila}
    [Return]    ${CSS ROW FILA RESULTADO}:nth-of-type(${numero fila})>${CSS CELL NOMBRE PRODUCTO}>${CSS LINK MODIFICAR PRODUCTO}

Fila Debe Contener Producto
    [Arguments]    ${numero fila}    ${nombre producto}    ${nombre marca}    ${precio producto}
    ${css fila producto}=     Set Variable    ${CSS ROW FILA RESULTADO}:nth-of-type(${numero fila})
    Element Should Contain    css:${css fila producto}>${CSS CELL NOMBRE PRODUCTO}>${CSS LINK MODIFICAR PRODUCTO}    ${NOMBRE PRODUCTO}
    Element Should Contain    css:${css fila producto}>${CSS CELL NOMBRE MARCA}    ${NOMBRE MARCA}
    Element Should Contain    css:${css fila producto}>${CSS CELL PRECIO PRODUCTO}    ${PRECIO PRODUCTO}

Enfocar Enlace Nombre Producto
    [Arguments]    ${numero fila}
    ${css enlace nombre producto}=    Generar CSS Enlace Nombre Producto    ${numero fila}
    Set Focus To Element    css:${css enlace nombre producto}

Dar Click En Enlace Nombre Producto
    [Arguments]    ${numero fila}
    ${css enlace nombre producto}=    Generar CSS Enlace Nombre Producto    ${numero fila}
    Click Link    css:${css enlace nombre producto}
