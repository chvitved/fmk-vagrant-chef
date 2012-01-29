@echo off
if exist %1 goto uninstallIt
echo #
echo # Missing argument
echo #
goto end
:uninstallIt
%~dp0javaservice /file:%1 /remove
echo #
echo # Service removed
echo #
:end
