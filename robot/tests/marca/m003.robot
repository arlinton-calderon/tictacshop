*** Setting ***
Resource    ../../resources/general.robot

*** Test Cases ***
M003 Modificar una marca.
    Aplicacion Debe Estar En Ejecucion

    Configurar Directorio Capturas

    #paso1
    Abrir Navegador
    Ir A Pagina Login
    Sleep    ${DELAY}
    Take Screenshot    pasoM003-1.jpg
    #paso2
    input text  name:username   ${USUARIO}
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoM003-2.png
    #paso3
    input text  name:password   ${CONTRASEÑA}
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoM003-3.png
    #paso4 
    Click Element   xpath=//*[@id="login-form"]/div[3]/input 
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoM003-4.png
    #paso5 
    Click Element   xpath=//*[@id="content-main"]/div[2]/table/tbody/tr[3]/th/a
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoM003-5.png
    #paso6
    input text  name:q   sony  
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoM003-6.png
    #paso7
    Click Element  xpath=//*[@id="changelist-search"]/div/input[2]
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoM003-7.png
    #paso8
    Click Element  xpath=//*[@id="id_form-0-name"]
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoM003-8.png
    #paso9
    input text  name:form-0-name  SONY MODIFICADO   clear=True 
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoM003-9.png
    #paso10
    Click Element   xpath=//*[@id="changelist-form"]/p/input
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoM003-10.png


    [Teardown]  close browser

*** Keywords ***
