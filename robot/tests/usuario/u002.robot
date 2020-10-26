*** Setting ***
Resource    ../../resources/general.robot

*** Variables ***

*** Test Cases ***
U002 Dar click en el botón “Grabar” sin escribir ninguna palabra en los campos de texto del formulario de registro de usuario.
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
    Click Element   xpath=//*[@id="customuser_form"]/div/div/input[1]
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    close browser
 
*** Keywords ***