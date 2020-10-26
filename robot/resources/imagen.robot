*** Settings ***
Resource    general.robot

*** Variables ***
### URLs
${URL IMAGEN RELATIVA}                 ${URL ADMIN RELATIVA}/products/productimage
${URL IMAGEN ABSOLUTA}                 ${URL ADMIN ABSOLUTA}/products/productimage
${URL AÑADIR IMAGEN RELATIVA}          ${URL IMAGEN RELATIVA}/add
${URL AÑADIR IMAGEN ABSOLUTA}          ${URL IMAGEN ABSOLUTA}/add

### Titulos
${TITULO AÑADIR IMAGEN}                Añadir imagen | ${TITULO ADMIN}
${TITULO MODIFICAR IMAGEN}             Modificar imagen | ${TITULO ADMIN}

### Localizadores
# Lista Imagenes
${CSS LINK ADMIN IMAGENES}             a[href="${URL IMAGEN RELATIVA}/"]
${CSS LINK AÑADIR IMAGEN}              ul.object-tools>li>a[href="${URL AÑADIR IMAGEN RELATIVA}/"]
${CSS LINK MODIFICAR IMAGEN}           a[href^="${URL IMAGEN RELATIVA}/"][href*="/change/"]
${CSS CELL NOMBRE IMAGEN}              th.field-image_name
${CSS CELL NOMBRE PRODUCTO}            td.field-product
# Formulario Registro Imagen
${CSS INPUT ARCHIVO IMAGEN}            input#id_image
${CSS SELECT NOMBRE PRODUCTO}          select#id_product

### Datos de prueba
# Originales
${EXTENSION IMAGEN}                    webp
${NOMBRE IMAGEN}                       camara1
${NOMBRE PRODUCTO}                     Cámara compacta
# Modificados
${NOMBRE IMAGEN MODIFICADO}            camara2

*** Keywords ***
Enfocar Enlace Imagenes
    Set Focus To Element    css:${CSS LINK ADMIN IMAGENES}

Dar Click En Enlace Imagenes
    Click Link    css:${CSS LINK ADMIN IMAGENES}
    Wait Until Location Is    ${URL IMAGEN ABSOLUTA}/

Enfocar Boton Añadir Imagen
    Set Focus To Element    css:${CSS LINK AÑADIR IMAGEN}

Dar Click En Boton Añadir Imagen
    Click Link    css:${CSS LINK AÑADIR IMAGEN}
    Wait Until Location Contains    ${URL AÑADIR IMAGEN ABSOLUTA}

Seleccionar Archivo Imagen
    [Arguments]    ${nombre imagen}
    Set Focus To Element    css:${CSS INPUT ARCHIVO IMAGEN}
    Choose File    css:${CSS INPUT ARCHIVO IMAGEN}    ${CURDIR}${/}${nombre imagen}

Seleccionar Nombre Producto
    [Arguments]    ${nombre producto}
    Select From List By Label    css:${CSS SELECT NOMBRE PRODUCTO}    ${nombre producto}

Mensaje Exitoso Con Nombre Imagen Debe Estar Visible
    [Arguments]    ${nombre imagen}
    Element Should Contain    css:${CSS DIV MENSAJE EXITOSO}    ${nombre imagen}

Dar Click En Boton Buscar
    general.Dar Click En Boton Buscar
    Location Should Contain    ${URL IMAGEN ABSOLUTA}/?q=

Pagina Modificar Imagen Debe Estar Abierta
    Location Should Contain    ${URL IMAGEN ABSOLUTA}
    Title Should Be    ${TITULO MODIFICAR IMAGEN}

Buscar Numero Fila Imagen
    [Arguments]    ${nombre imagen}    ${nombre producto}

    ${filtro fila imagen}=    Create Dictionary    ${CSS CELL NOMBRE IMAGEN}=${nombre imagen}
    ...    ${CSS CELL NOMBRE PRODUCTO}=${nombre producto}

    ${numero fila imagen}=    Buscar Numero Fila    ${CSS TABLE TABLA RESULTADO}    ${filtro fila imagen}

    [Return]    ${numero fila imagen}

Generar CSS Enlace Nombre Imagen
    [Arguments]    ${numero fila}
    [Return]    ${CSS ROW FILA RESULTADO}:nth-of-type(${numero fila})>${CSS CELL NOMBRE IMAGEN}>${CSS LINK MODIFICAR IMAGEN}

Fila Debe Contener Imagen
    [Arguments]    ${numero fila}    ${nombre imagen}    ${nombre producto}
    ${css fila imagen}=       Set Variable    ${CSS ROW FILA RESULTADO}:nth-of-type(${numero fila})
    Element Should Contain    css:${css fila imagen}>${CSS CELL NOMBRE IMAGEN}>${CSS LINK MODIFICAR IMAGEN}    ${NOMBRE IMAGEN}
    Element Should Contain    css:${css fila imagen}>${CSS CELL NOMBRE PRODUCTO}    ${NOMBRE PRODUCTO}

Enfocar Enlace Nombre Imagen
    [Arguments]    ${numero fila}
    ${css enlace nombre imagen}=    Generar CSS Enlace Nombre Imagen    ${numero fila}
    Set Focus To Element    css:${css enlace nombre imagen}

Dar Click En Enlace Nombre Imagen
    [Arguments]    ${numero fila}
    ${css enlace nombre imagen}=    Generar CSS Enlace Nombre Imagen    ${numero fila}
    Click Link    css:${css enlace nombre imagen}
