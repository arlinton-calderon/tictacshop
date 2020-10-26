*** Setting ***
Resource    ../../resources/general.robot

*** Variables ***

*** Test Cases ***
L003 Dar click en el botón “Iniciar sesión” sin escribir ninguna palabra en el campo de texto “Contraseña”.
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
    Click Element   xpath=//*[@id="login-form"]/div[3]/input
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    close browser

*** Keywords ***