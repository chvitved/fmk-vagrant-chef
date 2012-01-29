@echo off

if not defined TRIFORK_INSTALL_DIR (
	echo "Please set TRIFORK_INSTALL_DIR to the installation directory
of Trifork EAS"
	exit -1
)

if not defined TRIFORK_SERVER_DIR (
	echo "Please set TRIFORK_SERVER_DIR to the directory of Trifork EAS
server instance" 	
	exit -1
)

set PROPS=-Dtrifork.install.dir=%TRIFORK_INSTALL_DIR% -Dtrifork.server.dir=%TRIFORK_SERVER_DIR% 
set PROPS=%PROPS% -Dpython.home=%TRIFORK_INSTALL_DIR%\lib\jpython 
set PROPS=%PROPS% -Djava.ext.dirs=%TRIFORK_INSTALL_DIR%\lib\ext

set PROPS=%PROPS% -Djava.naming.factory.initial=com.sun.jndi.cosnaming.CNCtxFactory
set PROPS=%PROPS% -Dooc.orb.service.NameService=corbaloc::localhost:10000/NameService
set PROPS=%PROPS% -Djava.naming.corba.orb=
rem set PROPS=%PROPS% -Djava.naming.factory.url.pkgs=com.trifork.eas.naming

set PROPS=%PROPS% -Djavax.rmi.CORBA.StubClass=com.trifork.rmi.impl.StubImpl
set PROPS=%PROPS% -Djavax.rmi.CORBA.UtilClass=com.trifork.rmi.impl.UtilImpl
set PROPS=%PROPS% -Djavax.rmi.CORBA.PortableRemoteObjectClass=com.trifork.rmi.impl.PortableRemoteObjectImpl

set PROPS=%PROPS% -Djava.library.path=%TRIFORK_INSTALL_DIR%\bin

set PROPS=%PROPS% -Dorg.omg.CORBA.ORBClass=com.ooc.CORBA.ORB
set PROPS=%PROPS% -Dorg.omg.CORBA.ORBSingletonClass=com.ooc.CORBA.ORBSingleton

set PROPS=%PROPS% -Dtrifork.user.classpath=%TRIFORK_USER_CP%
set PROPS=%PROPS% -Dtrifork.jsp.classpath=%TRIFORK_USER_CP%

set PROPS=%PROPS% -Djava.security.auth.login.config=%TRIFORK_INSTALL_DIR%\jaas.config

set EASLIB=%TRIFORK_INSTALL_DIR%\lib

set ORBINIT=-Xbootclasspath:%EASLIB%\OB.jar;%JAVA_HOME%\jre\lib\rt.jar

if "%1" == "server" goto server
set SERVERFLAG=
goto run

:server
echo Using -server option
set SERVERFLAG=-server
set PROPS=%PROPS% -Dooc.orb.oa.conc_model=thread_pool
set PROPS=%PROPS% -Dooc.orb.oa.thread_pool=20
set PROPS=%PROPS% -Xms48M -Xmx64M 

:run
rem ----- NOTE: The java command must be the very last line of the cmd file to
rem             ensure that the exit value is returned to the caller
x:\products\jrockit-2.0\jrockit %SERVERFLAG% -Djava.security.policy==%EASLIB%\security\server.policy %ORBINIT% %PROPS% -jar %EASLIB%\tools.jar %*
