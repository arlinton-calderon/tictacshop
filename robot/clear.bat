@echo off

if not exist %CD%\results\%1 goto :EOF

del /q "%CD%\results\%1\*"

for /D %%p in ("%CD%\results\%1\*.*") do (
    rmdir "%%p" /s /q
)