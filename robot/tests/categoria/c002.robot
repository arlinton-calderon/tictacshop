*** Setting ***
Resource    ../../resources/general.robot

*** Test Cases ***
C002 Guardar marca sin nombre
    Aplicacion Debe Estar En Ejecucion

    Configurar Directorio Capturas

    #paso1
    Abrir Navegador
    Ir A Pagina Login
    Sleep    ${DELAY}
    Take Screenshot    pasoC002-1.jpg
    #paso2
    input text  name:username   ${USUARIO}
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC002-2.png
    #paso3
    input text  name:password   ${CONTRASEÑA}
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC002-3.png
    #paso4 
    Click Element   xpath=//*[@id="login-form"]/div[3]/input 
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC002-4.png
    #paso5 
    Click Element   xpath=//*[@id="content-main"]/div[2]/table/tbody/tr[1]/td[1]/a
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC002-5.png
    
    #paso6
    Click Element   xpath=//*[@id="category_form"]/div/div/input[1]
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC002-6.png

    [Teardown]  close browser
*** Keywords ***

