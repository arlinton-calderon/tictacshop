@echo off & setlocal enableextensions disabledelayedexpansion

if defined VIRTUAL_ENV goto :call-robot

call %CD%\venv\Scripts\activate.bat

:call-robot
robot --outputdir %CD%\results\%1 %CD%\tests\%1.robot

endlocal
