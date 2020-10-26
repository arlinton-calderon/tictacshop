*** Settings ***
Library    OperatingSystem
Library    Process
Library    Screenshot    screenshot_module=wxPython
Library    SeleniumLibrary
Library    Collections
Library    RequestsLibrary

*** Variables ***
# Configuraciones
${HOST}                             localhost
${PORT}                             8000
${SERVER}                           http://${HOST}:${PORT}
${BROWSER}                          Chrome
${SHORT DELAY}                      .15s
${DELAY}                            .30s
${LONG DELAY}                       1s
${DRIVER PATH}                      ${CURDIR}/chromedriver.exe
${DIRECTORIO CAPTURAS}              ${OUTPUTDIR}/capturas

### URLs
${URL ADMIN RELATIVA}               /admin
${URL ADMIN ABSOLUTA}               ${SERVER}${URL ADMIN RELATIVA}
${URL ADMIN LOGIN ABSOLUTA}         ${URL ADMIN ABSOLUTA}/login

### Titulos
${TITULO ADMIN}                     Administración de Tic-Tac Shop
${TITULO LOGIN}                     Iniciar sesión | ${TITULO ADMIN}
${TITULO ADMIN INICIO}              Módulo Administrativo | ${TITULO ADMIN}

### Localizadores
# Formulario Inicio Sesión
${CSS INPUT NOMBRE USUARIO}         input#id_username
${CSS INPUT CONTRASEÑA}             input#id_password
${CSS BUTTON INICIAR SESION}        input[type="submit"][value="Iniciar sesión"]
# Lista Entidad
${CSS INPUT BUSQUEDA}               input#searchbar
${CSS BUTTON BUSCAR}                input[type="submit"][value="Buscar"]
${CSS DIV MENSAJE EXITOSO}          ul.messagelist>li.success
${CSS DIV MENSAJE ERROR}            p.errornote
${CSS LIST LISTA ERRORES}           ul.errorlist
${CSS TABLE TABLA RESULTADO}        div.results>table#result_list
${CSS ROW FILA RESULTADO}           ${CSS TABLE TABLA RESULTADO}>tbody>tr
# Formulario Entidad
${CSS BUTTON GRABAR}                input[type="submit"][value="Grabar"]
${CSS LINK ELIMINAR}                p.deletelink-box>a.deletelink[href*="/delete/"]
${CSS BUTTON CONFIRMAR ELIMINAR}    input[type="submit"][value="Sí, estoy seguro"]

### Datos de prueba globales
${USUARIO}                          admin@tictacshop.com
${CONTRASEÑA}                       clave_administrativa

*** Keywords ***
Aplicacion Debe Estar En Ejecucion
    Create Session    localhost    ${URL ADMIN ABSOLUTA}    max_retries=0
    ${estado}    ${respuesta}    Run Keyword And Ignore Error    GET Request    localhost    /
    ${esta en ejecucuon}=    Evaluate    '${estado}' == 'PASS' or type($respuesta).__name__ == 'Response' and $respuesta.status_code == 200
    Should Be True    ${esta en ejecucuon}    La aplicación no se encuentra en ejecución

Configurar Directorio Capturas
    Create Directory    ${DIRECTORIO CAPTURAS}
    SeleniumLibrary.Set Screenshot Directory    ${DIRECTORIO CAPTURAS}
    Screenshot.Set Screenshot Directory    ${DIRECTORIO CAPTURAS}

Abrir Navegador
    File Should Exist    ${DRIVER PATH}    No se encontró el driver "${DRIVER PATH}"
    Create Webdriver    ${BROWSER}    executable_path=${DRIVER PATH}
    Go To    about:blank
    Maximize Browser Window

Ir A Pagina Login
    Go To    ${URL ADMIN LOGIN ABSOLUTA}

Pagina Login Debe Estar Abierta
    Location Should Contain    ${URL ADMIN LOGIN ABSOLUTA}
    Title Should Be    ${TITULO LOGIN}

Ingresar Nombre Usuario
    [Arguments]    ${username}
    Input Text    css:${CSS INPUT NOMBRE USUARIO}    ${username}

Ingresar Contraseña
    [Arguments]    ${password}
    Input Text    css:${CSS INPUT CONTRASEÑA}    ${password}

Enforcar Boton Iniciar Sesion
    Set Focus To Element    css:${CSS BUTTON INICIAR SESION}

Dar Click En Boton Iniciar Sesion
    Click Button    css:${CSS BUTTON INICIAR SESION}

Ingresar Como Administrador
    Pagina Login Debe Estar Abierta
    Ingresar Nombre Usuario    ${USUARIO}
    Ingresar Contraseña        ${CONTRASEÑA}
    Dar Click En Boton Iniciar Sesion
    Pagina Administración Debe Estar Abierta

Ir A Pagina Administracion
    Go To    ${URL ADMIN ABSOLUTA}/

Pagina Administración Debe Estar Abierta
    Wait Until Location Is    ${URL ADMIN ABSOLUTA}/
    Wait Until Element Is Visible    id:content-main
    Title Should Be    ${TITULO ADMIN INICIO}

Enforcar Boton Grabar
    Set Focus To Element    css:${CSS BUTTON GRABAR}

Dar Click En Boton Grabar
    Click Button    css:${CSS BUTTON GRABAR}

Enforcar Enlace Eliminar
    Set Focus To Element    css:${CSS LINK ELIMINAR}

Dar Click En Enlace Eliminar
    Click Link    css:${CSS LINK ELIMINAR}

Enforcar Boton Confirmar Eliminar
    Set Focus To Element    css:${CSS BUTTON CONFIRMAR ELIMINAR}

Dar Click En Boton Confirmar Eliminar
    Click Button    css:${CSS BUTTON CONFIRMAR ELIMINAR}

Ingresar Texto Busqueda
    [Arguments]    ${texto busqueda}
    Input Text    css:${CSS INPUT BUSQUEDA}    ${texto busqueda}

Enforcar Boton Buscar
    Set Focus To Element    css:${CSS BUTTON BUSCAR}

Dar Click En Boton Buscar
    Click Button    css:${CSS BUTTON BUSCAR}

Tabla Resultados Debe Contener
    [Arguments]    ${filas}
    Page Should Contain Element    css:${CSS ROW FILA RESULTADO}    limit=${filas}

Buscar Numero Fila
    [Arguments]    ${seleccionador tabla}    ${filtro fila}
    
    ${datos filtro}=    Set Variable    let datosFiltro = new Map(); 
    FOR    ${seleccionador}    IN    @{filtro fila}
        ${texto esperado}=    Get From Dictionary    ${filtro fila}    ${seleccionador}
        ${datos filtro}=    Catenate    ${datos filtro}    datosFiltro.set('${seleccionador}', '${texto esperado}'); 
    END
    ${datos filtro}=    Catenate    ${datos filtro}    datosFiltro = Array.from(datosFiltro.entries()); 

    ${predicado fila}=    Catenate    fila => { 
    ...    const predicado = datoFiltro => { 
    ...        const [seleccionadorCelda, textoEsperado] = datoFiltro; 
    ...        const celda = fila.querySelector(seleccionadorCelda); 
    ...        return celda && celda.textContent.match(textoEsperado); 
    ...    }; 
    ...    for (const datoFiltro of datosFiltro) { 
    ...        if (!predicado(datoFiltro)) 
    ...            return false; 
    ...    } 
    ...    return true; 
    ...    } 

    ${numero fila}=    Execute Javascript    ${datos filtro} 
    ...    const tabla = window.document.querySelector('${seleccionador tabla}'); 
    ...    const filas = Array.from(tabla.querySelectorAll('tbody>tr')); 
    ...    return filas.findIndex(${predicado fila}) + 1;

    [Return]    ${numero fila}

Resaltar Fila Numero
    [Arguments]    ${numero fila}
    ${seleccionador fila}=    Set Variable    ${CSS ROW FILA RESULTADO}:nth-of-type(${numero fila})
    Añadir Contorno A Elemento        ${seleccionador fila}
    Scroll Element Into View      css:${seleccionador fila}
    Set Focus To Element                 css:${seleccionador fila}

Configurar Contorno Del Elemento
    [Arguments]    ${seleccionador elemento}    ${outilne}=    ${outline-offset}=
    Execute Javascript
    ...    const element = window.document.querySelector('${seleccionador elemento}'); 
    ...    element.style.setProperty('outline', '${outilne}'); 
    ...    element.style.setProperty('outline-offset', '${outline-offset}');

Añadir Contorno A Elemento
    [Arguments]    ${seleccionador elemento}
    Configurar Contorno Del Elemento    ${seleccionador elemento}
    ...    -webkit-focus-ring-color auto 1px
    ...    0px

Quitar Contorno Del Elemento
    [Arguments]    ${seleccionador elemento}
    Configurar Contorno Del Elemento    ${seleccionador elemento}

Mensaje Error Debe Estar Visible
    Page Should Contain Element        css:${CSS DIV MENSAJE ERROR}

Campo Debe Mostrar Mensaje Error
    [Arguments]    ${seleccionador campo}
    Page Should Contain Element        css:ul.errorlist + ${seleccionador campo}

Campo No Debe Mostrar Mensaje Error
    [Arguments]    ${seleccionador campo}
    Page Should Not Contain Element        css:ul.errorlist + ${seleccionador campo}

Tomar Captura Resultado Prueba
    Capture Page Screenshot    resultado-ejecucion.png
