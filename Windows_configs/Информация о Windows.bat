@echo off
SetLocal EnableExtensions

call :GetSystemVersion "OSVer" "Core" "Build" "Family" "EnvironCore"

echo Версия ОС:      %OSVer%
echo Рязрядность ОС: %Core%
echo Сборка:         %Build%
echo Семейство:      %Family%
echo Разрядность среды запуска Batch: %EnvironCore%

pause
Exit /B

:GetSystemVersion [OSVersion] [OSCore] [OSBuild] [OSFamily] [EnvironmentCore]
:: Определить версию ОС
:: %1-исх.Переменная для хранения названия ОС
:: %2-исх.Переменная для хранения разрядности ОС
:: %3-исх.Переменная для хранения версии сборки ОС
:: %4-исх.Переменная, идентифицирующая семейство ОС (9x, NT, Vista)
:: %5-исх.Переменная, идентифицирующая разрядность среды, из-под которой запущен скрипт
  Set "xOS=x64"& If "%PROCESSOR_ARCHITECTURE%"=="x86" If Not Defined PROCESSOR_ARCHITEW6432 Set "xOS=x32"
  set "%~2=%xOS%"
  set "%~5=x32"& if "%xOS%"=="x64" echo "%PROGRAMFILES%" |>nul find "x86" || set "%~5=x64"
  set "_key=HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion"
  For /f "tokens=2*" %%a In ('Reg.exe query "%_key%" /v "CurrentBuildNumber"^|Find "CurrentBuildNumber"') do set "%~3=%%~b"
  For /f "tokens=2*" %%a In ('Reg.exe query "%_key%" /v "CurrentVersion"^|Find "CurrentVersion"') do set "_ver=%%~b"
  For /f "tokens=2*" %%a In ('Reg.exe query "%_key%" /v "ProductName"^|Find "ProductName"') do set "%~1=%%~b"
  if "%_ver:~0,1%"=="6" (set "%~4=Vista") else (set "%~4=NT")
Exit /B