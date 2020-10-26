*** Setting ***
Resource    ../../resources/general.robot

*** Variables ***

*** Test Cases ***
U003 Modificar un usuario.
    Aplicacion Debe Estar En Ejecucion

    Configurar Directorio Capturas

    Abrir Navegador
    Ir A Pagina Login
    Sleep    ${DELAY}
    Take Screenshot    Part

    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    input text  name:username   ${USUARIO}
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    input text  name:password   ${CONTRASEÑA}
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    Click Element   xpath=//*[@id="login-form"]/div[3]/input
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    Click Element   xpath=//*[@id="content-main"]/div[3]/table/tbody/tr/td[2]/a
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    Click Element   xpath=//*[@id="result_list"]/tbody/tr[1]/th/a
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    input text  name:username  David123
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    input text  name:email  DavidGarantizar@gmail.com
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    Click Element   xpath=//*[@id="id_is_staff"]
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    Click Element   xpath=//*[@id="id_is_superuser"]
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    Click Element   xpath=//*[@id="id_user_permissions_remove_all_link"]
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    Click Element   xpath=//*[@id="customuser_form"]/div/div/input[1]
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    close browser
 
*** Keywords ***