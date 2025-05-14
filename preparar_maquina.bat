@echo off
:: Executar como administrador

@echo off
echo =================================================
echo 1. Ativando o Administrador local...
net user administrador /active:yes
echo.
echo 2. Defina a senha para o Administrador local:
set /p "senha=Digite a nova senha para Administrador: "
net user administrador "%senha%"
echo.
echo Senha para o Administrador local definida com sucesso.

echo =================================================
echo 2. Definindo o Proxy (ex: 192.168.0.1:8080)...
set proxy=ip_proxy:porta_proxy
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d %proxy% /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoDetect /t REG_DWORD /d 0 /f
echo.

echo =================================================
echo 3. Instalando programas...

:: Instalação silenciosa do AnyDesk
echo Instalando AnyDesk...
start /wait "" "%~dp0anydesk.exe" --install "C:\Program Files\AnyDesk" --silent

:: Instalação silenciosa do UltraVNC
echo Instalando UltraVNC...
start /wait "" "%~dp0ultravnc_setup.exe" /silent /loadinf="%~dp0config.inf"

:: Instalação silenciosa do Google Chrome
echo Instalando Google Chrome...
start /wait "" "%~dp0googlechromesetup.exe" /s

:: Instalação silenciosa do WinRAR
echo Instalando WinRAR...
start /wait "" "%~dp0winrarsetup.exe" /s

:: Instalação do Office 2013 (64 bits)
echo Instalando Office 2013...
start /wait "" "%~dp0Office\setup.exe" /adminfile "%~dp0Office\config.msp"

echo =================================================
echo Finalizado. Reinicie o sistema.
pause
