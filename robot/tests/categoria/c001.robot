*** Setting ***
Resource    ../../resources/general.robot

*** Test Cases ***
C001 Crear una marca.
    Aplicacion Debe Estar En Ejecucion

    Configurar Directorio Capturas

    #paso1
    Abrir Navegador
    Ir A Pagina Login
    Sleep    ${DELAY}
    Take Screenshot    pasoC001-1.jpg
    #paso2
    input text  name:username   ${USUARIO}
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC001-3.png
    #paso3
    input text  name:password   ${CONTRASEÑA}
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC001-4.png
    #paso4 
    Click Element   xpath=//*[@id="login-form"]/div[3]/input 
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC001-5.png
    #paso5 
    Click Element   xpath=//*[@id="content-main"]/div[2]/table/tbody/tr[1]/td[1]/a
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC001-6.png
    #paso6
    input text  name:name   CAMARAS
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC001-7.png
    #paso7
    Click Element   xpath=//*[@id="category_form"]/div/div/input[1]
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC001-8.png
    
    close browser
*** Keywords ***

