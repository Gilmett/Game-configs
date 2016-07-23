@echo off
cls
 
echo Apps
echo.
echo press any key to continue...

pause > NUL

echo
echo.

PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%~dp0.\Delete default Metro Apps.ps1""' -Verb RunAs}"

echo You deleted apps...
echo.
pause