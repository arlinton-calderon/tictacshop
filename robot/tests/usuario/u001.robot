*** Setting ***
Resource    ../../resources/general.robot

*** Variables ***

*** Test Cases ***
U001 Crear un usuario.
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
    Click Element   xpath=/html/body/div/div[2]/div/div[1]/div[1]/div[3]/table/tbody/tr/td[1]/a
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    input text  name:username   David10
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    input text  name:email  DavidGarantizar8@gmail.com
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    input text  name:password1  Crash1234
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    input text  name:password2  Crash1234
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    Click Element   xpath=//*[@id="customuser_form"]/div/div/input[1]
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    input text  name:first_name  David 
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    input text  name:last_name   Mejia
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    Click Element   xpath=//*[@id="id_user_permissions_add_all_link"]
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    Click Element   xpath=//*[@id="customuser_form"]/div/div/input[1]
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    close browser
 
*** Keywords ***