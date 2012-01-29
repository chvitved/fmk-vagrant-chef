@echo off
if exist %1 goto installIt
echo #
echo # Missing argument
echo #
goto end
:installIt
%~dp0javaservice-x64 -file:%1 -install
echo #
echo # Service installed
echo #
echo # To start the service type: net start TriforkServer
echo #
echo # To stop the service type: net stop TriforkServer
echo #
:end
