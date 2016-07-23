@echo off
chcp 1251 >nul
cd /d %~dp0
if exist %windir%\SysWOW64 (set SetAcl="%~dp0SetACL64.exe") || (set SetAcl="%~dp0SetACL32.exe")
call :IsAdmin
echo.============================================================
echo.   Управление пунктом "Персонализация" в контекстном меню
echo.============================================================
echo.
echo.[1] Установить расширенный вид
echo.[2] Установить вид по умолчанию (Windows 10)
echo.
choice /M "Выберите параметр:" /N /C 12
IF ERRORLEVEL 2 goto :Restore
IF ERRORLEVEL 1 goto :Custom
:Custom
echo.
chcp 866 >nul
for /f "Delims== Skip=2 Tokens=2 UseBackQ" %%i in (`wmic Group Where SID^="S-1-5-32-544" Get Name /Value`) Do Set Admins=%%i
%SetAcl% -on "HKCR\DesktopBackground\Shell\Personalize" -ot reg -actn setowner -ownr "n:S-1-5-32-544;s:y" -rec yes -ignoreerr -silent
%SetAcl% -on "HKCR\DesktopBackground\Shell\Personalize" -ot reg -actn ace -ace "n:%Admins%;p:full" -rec yes -ignoreerr -silent
REG DELETE "HKCR\DesktopBackground\Shell\Personalize" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize" /v "MUIVerb" /t REG_EXPAND_SZ /d "@%%systemroot%%\system32\themecpl.dll,-10" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize" /v "Icon" /t REG_SZ /d "themecpl.dll" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize" /v "Position" /t REG_SZ /d "Bottom" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize" /v "SubCommands" /t REG_SZ /d "" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize" /v "HideInSafeMode" /t REG_SZ /d "" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0a.theme" /v "MUIVerb" /t REG_EXPAND_SZ /d "@%%systemroot%%\system32\themecpl.dll,-7" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0a.theme" /v "ControlPanelName" /t REG_SZ /d "Microsoft.Personalization" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0a.theme" /v "Icon" /t REG_SZ /d "themecpl.dll" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0a.theme\command" /v "DelegateExecute" /t REG_SZ /d "{06622D85-6856-4460-8DE1-A81921B41C4B}" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0b.background" /v "Icon" /t REG_SZ /d "imageres.dll,-110" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0b.background" /v "MUIVerb" /t REG_EXPAND_SZ /d "@%%systemroot%%\system32\themecpl.dll,-40" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0b.background\command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL desk.cpl,,@desktop" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0c.fonsize" /v "MUIVerb" /t REG_EXPAND_SZ /d "@%%systemroot%%\system32\display.dll,-535" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0c.fonsize" /v "ControlPanelName" /t REG_SZ /d "Microsoft.Display" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0c.fonsize" /v "Icon" /t REG_SZ /d "display.dll,-1" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0c.fonsize\command" /v "DelegateExecute" /t REG_SZ /d "{06622D85-6856-4460-8DE1-A81921B41C4B}" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0d.color" /v "Icon" /t REG_SZ /d "themecpl.dll" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0d.color" /v "MUIVerb" /t REG_EXPAND_SZ /d "@%%systemroot%%\system32\themecpl.dll,-8" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0d.color\command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL desk.cpl,Advanced,@Advanced" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0e.icons" /v "Icon" /t REG_SZ /d "desk.cpl" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0e.icons" /v "MUIVerb" /t REG_EXPAND_SZ /d "@%%systemroot%%\system32\themecpl.dll,-79" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0e.icons" /v "CommandFlags" /t REG_DWORD /d "32" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0e.icons\command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL desk.cpl,,0" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0f.pointers" /v "Icon" /t REG_SZ /d "main.cpl" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0f.pointers" /v "MUIVerb" /t REG_EXPAND_SZ /d "@%%systemroot%%\system32\themecpl.dll,-80" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0f.pointers\command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL main.cpl,,1" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0g.sounds" /v "Icon" /t REG_SZ /d "SndVol.exe,-101" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0g.sounds" /v "MUIVerb" /t REG_EXPAND_SZ /d "@%%systemroot%%\system32\mmsys.cpl,-303" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0g.sounds\command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL mmsys.cpl,,2" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0h.screensaver" /v "Icon" /t REG_SZ /d "PhotoScreensaver.scr" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0h.screensaver" /v "MUIVerb" /t REG_EXPAND_SZ /d "@%%systemroot%%\system32\desk.cpl,-1242" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0h.screensaver\command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL desk.cpl,,1" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0i.resolution" /v "CommandFlags" /t REG_DWORD /d "32" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0i.resolution" /v "Icon" /t REG_SZ /d "display.dll,-1" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0i.resolution" /v "MUIVerb" /t REG_EXPAND_SZ /d "@%%systemroot%%\system32\display.dll,-300" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0i.resolution\command" /ve /t REG_SZ /d "rundll32.exe shell32.dll,Control_RunDLL desk.cpl" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0j.personalization" /v "Icon" /t REG_EXPAND_SZ /d "%%systemroot%%\system32\themecpl.dll,-1" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0j.personalization" /v "MUIVerb" /t REG_EXPAND_SZ /d "@%%systemroot%%\system32\themecpl.dll,-4" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0j.personalization" /v "CommandFlags" /t REG_DWORD /d "32" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0j.personalization" /v "SettingsURI" /t REG_SZ /d "ms-settings:personalization-background" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\shell\0j.personalization\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f
TIMEOUT /T 5 >nul
goto :eof

:Restore
echo.
chcp 866 >nul
for /f "Delims== Skip=2 Tokens=2 UseBackQ" %%i in (`wmic Group Where SID^="S-1-5-32-544" Get Name /Value`) Do Set Admins=%%i
%SetAcl% -on "HKCR\DesktopBackground\Shell\Personalize" -ot reg -actn setowner -ownr "n:S-1-5-32-544;s:y" -rec yes -ignoreerr -silent
%SetAcl% -on "HKCR\DesktopBackground\Shell\Personalize" -ot reg -actn ace -ace "n:%Admins%;p:full" -rec yes -ignoreerr -silent
REG DELETE "HKCR\DesktopBackground\Shell\Personalize" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize" /ve /t REG_EXPAND_SZ /d "@%%systemroot%%\system32\themecpl.dll,-10" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize" /v "HideInSafeMode" /t REG_SZ /d "" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize" /v "Icon" /t REG_EXPAND_SZ /d "%%systemroot%%\system32\themecpl.dll,-1" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize" /v "Position" /t REG_SZ /d "Bottom" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize" /v "SettingsURI" /t REG_SZ /d "ms-settings:personalization-background" /f
REG ADD "HKCR\DesktopBackground\Shell\Personalize\command" /v "DelegateExecute" /t REG_SZ /d "{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}" /f
TIMEOUT /T 5 >nul
goto :eof

:IsAdmin
REG QUERY "HKU\S-1-5-19\Environment"
IF NOT %ERRORLEVEL% EQU 0 (
   Cls & Echo.
   echo.============================================================
   echo.     Сценарий требует запуска с правами Администратора.
   echo.============================================================
   TIMEOUT /T 5 >nul & Exit
)
Cls
goto :eof
