*** Setting ***
Resource    ../../resources/general.robot

*** Variables ***

*** Test Cases ***
L004 Intentar ingresar como usuario administrativo escribiendo datos inválidos.
    Aplicacion Debe Estar En Ejecucion

    Configurar Directorio Capturas

    Abrir Navegador
    Ir A Pagina Login
    Sleep    ${DELAY}
    Take Screenshot    Part

    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    input text  name:username   Messi10@gmail.com
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    input text  name:password   10
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    Click Element   xpath=//*[@id="login-form"]/div[3]/input
    sleep   ${LONG DELAY}
    Capture Page Screenshot     Part_{index}.png
    sleep   ${LONG DELAY}
    close browser

*** Keywords ***