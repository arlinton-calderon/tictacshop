*** Setting ***
Resource    ../../resources/general.robot

*** Test Cases ***
M001 Crear una marca.
    Aplicacion Debe Estar En Ejecucion

    Configurar Directorio Capturas

    #paso1
    Abrir Navegador
    Ir A Pagina Login
    Sleep    ${DELAY}
    Take Screenshot    pasoM001-1.jpg
    #paso2
    input text  name:username   ${USUARIO}
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoM001-2.png
    #paso3
    input text  name:password   ${CONTRASEÑA}
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoM001-3.png
    #paso4 
    Click Element   xpath=//*[@id="login-form"]/div[3]/input 
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoM001-4.png
    #paso5 
    Click Element   xpath=//*[@id="content-main"]/div[2]/table/tbody/tr[3]/td[1]/a
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoM001-5.png
    #paso6
    input text  name:name   Sony
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoM001-6.png
    #paso7
    Click Element   xpath=//*[@id="brand_form"]/div/div/input[1]
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoM001-7.png

    [Teardown]  close browser
*** Keywords ***

