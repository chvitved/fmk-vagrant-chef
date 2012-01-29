@echo off
setlocal

if not defined TRIFORK_INSTALL_DIR (
	set TRIFORK_INSTALL_DIR=%~dp0..
)

if not defined JAVA_HOME (
  echo
  echo Warning: JAVA_HOME is unset. This often causes problems with high CPU usage. Please fix and restart.
  echo
)

set EASLIB=%TRIFORK_INSTALL_DIR%\lib
set PATH=%TRIFORK_INSTALL_DIR%\bin;%PATH%

if defined TRIFORK_CLASSPATH (
    set TRIFORK_CLASSPATH=%TRIFORK_CLASSPATH%;%EASLIB%/api.jar
) else (
    set TRIFORK_CLASSPATH=%EASLIB%/api.jar
)
set PREFIX=
set PROPS=        "-Dtrifork.install.dir=%TRIFORK_INSTALL_DIR%"
set PROPS=%PROPS% "-Dtrifork.domain.dir=%TRIFORK_DOMAIN_DIR%"
set PROPS=%PROPS% "-Djava.ext.dirs=%EASLIB%\ext;%TRIFORK_DOMAIN_DIR%\lib\share\ext;%JAVA_HOME%\lib\ext;%JAVA_HOME%\jre\lib\ext"
set PROPS=%PROPS% "-Djava.endorsed.dirs=%EASLIB%\endorsed;%TRIFORK_DOMAIN_DIR%\lib\share\endorsed"
set PROPS=%PROPS% "-DCTS_HOME=%CTS_HOME%"
set PROPS=%PROPS% "-Dtrifork.user.classpath=%TRIFORK_USER_CP%"
set PROPS=%PROPS% "-Denv.java.home=%JAVA_HOME%"
set PROPS=%PROPS% "-Dtrifork.node.name=%COMPUTERNAME%"
set BOOTCLASSPATH="%EASLIB%\boot.jar;%EASLIB%\jdkopt.jar"

if ["%TRIFORK_SECURITY_POLICY%"]==[""] goto NOSEC
set PROPS=%PROPS% "-Djava.security.policy=%TRIFORK_SECURITY_POLICY%"
goto SECEND
:NOSEC
set PROPS=%PROPS% "-Djava.security.policy=%EASLIB%\security\server.policy"
:SECEND

if ["%TRIFORK_SECURITY_AUTH_POLICY%"]==[""] goto NOSECAUTH
set PROPS=%PROPS% "-Djava.security.auth.policy=%TRIFORK_SECURITY_AUTH_POLICY%"
goto SECAUTHEND
:NOSECAUTH
set PROPS=%PROPS% "-Djava.security.auth.policy=%EASLIB%\security\server.auth.policy"
:SECAUTHEND

set JVMARGS=
set debug= -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8000
set DEBUGPROPS=
set SERVERSTART=false

:LOOP

shift

set arg1=%0
set arg2=%1

if [%arg1%]==[-vmargs] (
  set JVMARGS=%JVMARGS% %arg2%
  shift
) else if [%arg1%]==[-debug] (
  set DEBUGPROPS= %debug%
) else if [%arg1%]==[-server] (
  set TRIFORK_SERVER_NAME=%arg2%
  shift
) else if [%arg1%]==[-domain] (
  set TRIFORK_DOMAIN_NAME=%arg2%
  shift
) else if [%arg1%]==[-profile] (
  set PROPS=%PROPS% "-Dtrifork.p4.agent_name=%TRIFORK_DOMAIN_NAME%:Server=%TRIFORK_SERVER_NAME%"
  set PREFIX=%P4_INSTALL_DIR%\bin\profile.cmd
) else if [%arg1%]==[server] (
  set SERVERSTART=maybe
) else if [%arg1%]==[start] (
  if ["%SERVERSTART%"]==["maybe"] (
    set SERVERSTART=true
  )
) else if [%arg1%]==[-echo] (
  set PREFIX=echo
)

if not defined arg2 GOTO RUNIT

GOTO LOOP

:RUNIT

set PROPS=%PROPS% "-Dtrifork.domain.name=%TRIFORK_DOMAIN_NAME%"
set PROPS=%PROPS% "-Dtrifork.server.name=%TRIFORK_SERVER_NAME%"

if ["%SERVERSTART%"]==["true"] (
    cd /d %TRIFORK_DOMAIN_DIR%\logs\%TRIFORK_SERVER_NAME%
    set PROPS=%PROPS% "-Djava.awt.headless=true"
)

rem if not ["%JVMARGS%"]==[""] echo Using VM properties: %JVMARGS%

rem In order to keep the exit status intact, we must invoke java as the last step of the script.

%PREFIX% java "-Xbootclasspath/p:%BOOTCLASSPATH%" %DEBUGPROPS% %JVMARGS% %PROPS% -cp "%TRIFORK_CLASSPATH%;%EASLIB%\launcher.jar" com.trifork.eas.launcher.Launcher -jar "%EASLIB%\kernel.jar" %*

