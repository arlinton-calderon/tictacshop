*** Setting ***
Resource    ../../resources/general.robot

*** Test Cases ***
C004 Eliminar una categoria.
    Aplicacion Debe Estar En Ejecucion

    Configurar Directorio Capturas

    #paso1
    Abrir Navegador
    Ir A Pagina Login
    Sleep    ${DELAY}
    Take Screenshot    pasoC004-1.jpg
    #paso2
    input text  name:username   ${USUARIO}
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC004-2.png
    #paso3
    input text  name:password   ${CONTRASEÑA}
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC004-3.png
    #paso4 
    Click Element   xpath=//*[@id="login-form"]/div[3]/input 
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC004-4.png
    #paso5 
    Click Element   xpath=//*[@id="content-main"]/div[2]/table/tbody/tr[1]/td[2]/a
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC004-5.png
    #paso6
    Click Element   xpath=//*[@id="result_list"]/tbody/tr/td[1]/input
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC004-6.png
    #paso7
    Select From List By Label   xpath=//*[@id="changelist-form"]/div[2]/label/select  Eliminar categorias seleccionado/s 
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC004-7.png
    #paso8
    Click Element   xpath=//*[@id="changelist-form"]/div[2]/button
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC004-8.png
    #paso9
    Click Element   xpath=//*[@id="content"]/form/div/input[4]
    sleep   ${LONG DELAY}
    Capture Page Screenshot    pasoC004-9.png
    [Teardown]  close browser
*** Keywords ***