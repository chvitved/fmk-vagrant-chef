@echo off

SET HOST=localhost

set PARAMS=%*

:LOOP
if "%1" == "-host" (
SET HOST=%2
GOTO RUN
)

if "%1" == "--host" (
SET HOST=%2
GOTO RUN
)

if "%1" == "" (
GOTO RUN
)

SHIFT
GOTO LOOP


:RUN

SET LAUNCHER_INSTALL_DIR=%~d0%~p0..
SET LAUNCHER_REPOSITORY_DIR=%LAUNCHER_INSTALL_DIR%\repository

set TRIFORK_INSTALL_DIR=%LAUNCHER_REPOSITORY_DIR%\system\%HOST%

xcopy %TRIFORK_INSTALL_DIR%\client-launcher\lib\*.* %LAUNCHER_INSTALL_DIR%\lib /D /E /Y

set PATH=%TRIFORK_INSTALL_DIR%\bin;%PATH%

java -Dtrifork.client.config.dir=%TRIFORK_INSTALL_DIR%\client-config -Dlauncher.install.dir=%LAUNCHER_INSTALL_DIR% -Dlauncher.repository.dir=%LAUNCHER_REPOSITORY_DIR% -Dtrifork.install.dir=%TRIFORK_INSTALL_DIR% -Dtrifork.domain.dir=%TRIFORK_INSTALL_DIR% -Djava.ext.dirs=%TRIFORK_INSTALL_DIR%\lib\ext;%TRIFORK_INSTALL_DIR%\lib -Djava.endorsed.dirs=%TRIFORK_INSTALL_DIR%\lib\endorsed -jar %LAUNCHER_INSTALL_DIR%\lib\ClientLauncher.jar %PARAMS%
%TRIFORK_INSTALL_DIR%/runclient.bat
