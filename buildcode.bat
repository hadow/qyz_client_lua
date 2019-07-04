cd /d %~dp0\scripts

set INPUT_DIR=..\scripts
set OUT_DIR=..\..\dist\android\scripts

if exist %OUT_DIR% rd /s /q %OUT_DIR%
mkdir %OUT_DIR%

xcopy /e /r *.lua %OUT_DIR%\

cd /d %~dp0\luajit

@echo off
setlocal enabledelayedexpansion
for /f "delims=" %%i in ('dir /b /a-d /s ..\scripts') do (
set s=%%i 
echo %~dp0scripts
echo %%i

luajit -b %%i %OUT_DIR%\!s:%~dp0scripts\=!
echo %OUT_DIR%\!s:%~dp0scripts\=!)

cd %OUT_DIR%

pause
