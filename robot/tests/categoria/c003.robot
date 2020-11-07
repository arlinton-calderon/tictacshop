*** Setting ***
Resource    ../../resources/general.robot

*** Test Cases ***
C003 Modificar una categoria.
    #paso1
    Aplicacion Debe Estar En Ejecucion

    Configurar Directorio Capturas

    #paso1
    Abrir Navegador
    Ir A Pagina Login
    Sleep    ${DELAY}
    Take Screenshot    pasoC003-1.jpg
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC003-1.png
    #paso2
    input text  name:username   ${USUARIO}
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC003-2.png
    #paso3
    input text  name:password   ${CONTRASEÑA}
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC003-3.png
    #paso4 
    Click Element   xpath=//*[@id="login-form"]/div[3]/input 
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC003-4.png
    #paso5 
    Click Element   xpath=//*[@id="content-main"]/div[2]/table/tbody/tr[1]/th/a
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC003-5.png
    #paso6
    input text  name:q   Camaras
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC003-6.png
    #paso7
    Click Element  xpath=//*[@id="changelist-search"]/div/input[2]
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC003-7.png
    #paso8
    input text  name:form-0-name  Camaras Modificada   clear=True 
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC003-8.png
    #paso9
    Click Element   xpath=//*[@id="changelist-form"]/p/input
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC003-9.png


    [Teardown]  close browser

*** Keywords ***
