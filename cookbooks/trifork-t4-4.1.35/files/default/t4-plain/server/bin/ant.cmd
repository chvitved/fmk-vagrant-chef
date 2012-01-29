@echo off
@setlocal
set ANT_HOME=%TRIFORK_INSTALL_DIR%\ant
rem set LOCALCLASSPATH=%TRIFORK_INSTALL_DIR%\lib\jdtCompilerAdapter.jar:%TRIFORK_INSTALL_DIR%\lib\jdtcore.jar
rem unset CLASSPATH

set CLASSPATH=%TRIFORK_INSTALL_DIR%\lib\jdtCompilerAdapter.jar;%TRIFORK_INSTALL_DIR%\lib\jdtcore.jar;%CLASSPATH%

call "%TRIFORK_INSTALL_DIR%\ant\bin\ant.bat" %* -find
