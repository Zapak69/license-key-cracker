@echo off
%HOMEDRIVE%
::-------------------------SET THE KEYS FILE RIGHT HERE NOT ANYWHERE ELSE-------------------------
set "keyfile=encrypted.dll"
::REPLACE "encrypted.dll" with keys file
::-------------------------SET THE KEYS FILE UP HERE NOT ANYWHERE ELSE-------------------------
cd %~dp0
title Key Cracker
:menu
mode con cols=100 lines=25
cls
set /p "procId=Enter process id: "
echo.
mode con cols=30 lines=5
color a
cls
Call Button  10 1 "Crack" # Press
Getinput /m %Press% /h 70
if %errorlevel%==1 (goto crack)
goto menu

:crack
pssuspend.exe %procId% >nul
if %errorlevel% == "-1" goto error2
color f
mode con cols=50 lines=60
cls
echo.
if NOT exist "%temp%\%keyfile%" call :error
if exist "%temp%\%keyfile%" (
    echo.
    echo FOUND KEYS:
    echo.
    type %temp%\%keyfile%
    pssuspend.exe %procId% -r >nul
)
pause >nul
goto menu

:error
pssuspend.exe %procId% -r >nul
echo X=MsgBox("Cant crack the keys!", 0+16, "Key Cracker") >>%temp%\msg.vbs
start %temp%\msg.vbs
timeout /t 1 /nobreak >nul
del %temp%\msg.vbs
goto menu

:error2
pssuspend.exe %procId% -r >nul
echo X=MsgBox("ProcId doesnt exist!", 0+16, "Key Cracker") >>%temp%\msg.vbs
start %temp%\msg.vbs
timeout /t 1 /nobreak >nul
del %temp%\msg.vbs
goto menu