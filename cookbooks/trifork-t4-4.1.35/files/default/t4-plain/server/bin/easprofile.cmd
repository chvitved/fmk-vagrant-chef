@echo off

if not defined trifork.install.dir (
	echo "Please set trifork.install.dir to the installation directory
of Trifork EAS"
	exit -1
)

if not defined trifork.server.dir (
	echo "Please set trifork.server.dir to the directory of Trifork EAS
server instance" 	
	exit -1
)

set PROPS=-Dtrifork.install.dir=%TRIFORK_INSTALL_DIR% -Dtrifork.server.dir=%TRIFORK_SERVER_DIR% 
set PROPS=%PROPS% -Dpython.home=%TRIFORK_INSTALL_DIR%\lib\jpython 
set PROPS=%PROPS% -Djava.ext.dirs=%TRIFORK_INSTALL_DIR%\lib\ext

set PROPS=%PROPS% -Djava.naming.factory.initial=com.trifork.eas.naming.ExternalCosNamingContextFactory
set PROPS=%PROPS% -Dooc.orb.service.NameService=corbaloc::localhost:10000/NameService
set PROPS=%PROPS% -Djava.naming.corba.orb=
rem set PROPS=%PROPS% -Djava.naming.factory.url.pkgs=com.trifork.eas.naming

set PROPS=%PROPS% -Djavax.rmi.CORBA.StubClass=com.trifork.rmi.impl.StubImpl
set PROPS=%PROPS% -Djavax.rmi.CORBA.UtilClass=com.trifork.rmi.impl.UtilImpl
set PROPS=%PROPS% -Djavax.rmi.CORBA.PortableRemoteObjectClass=com.trifork.rmi.impl.PortableRemoteObjectImpl

set EOS_PRODUCT_ROOT=c:
rem set PROPS=%PROPS% -Djava.library.path=%TRIFORK_INSTALL_DIR%\bin;%EOS_PRODUCT_ROOT%\OptimizeIt-4.0.2\OptimizeIt40\lib

set PROPS=%PROPS% -Dorg.omg.CORBA.ORBClass=com.ooc.CORBA.ORB
set PROPS=%PROPS% -Dorg.omg.CORBA.ORBSingletonClass=com.ooc.CORBA.ORBSingleton

set PROPS=%PROPS% -Dtrifork.user.classpath=%TRIFORK_USER_CP%
set PROPS=%PROPS% -Dtrifork.jsp.classpath=%TRIFORK_USER_CP%

set PROPS=%PROPS% -Djava.security.auth.login.config=%TRIFORK_INSTALL_DIR%\jaas.config

set EASLIB=%TRIFORK_INSTALL_DIR%\lib

set ORBINIT=-Xbootclasspath/p:%EASLIB%\OB.jar;%EASLIB%\OBNaming.jar

set PATH=%PATH%;%EOS_PRODUCT_ROOT%\OptimizeIt-4.0.2\OptimizeIt40\lib
set EAS_PROFILE_CLASSPATH=%EOS_PRODUCT_ROOT%\OptimizeIt-4.0.2\OptimizeIt40\lib\optit.jar;%EASLIB%\tools.jar


if "%1" == "server" goto server
set SERVERFLAG=
goto run

:server
set PROPS=%PROPS% -Dooc.orb.oa.conc_model=thread_pool
set PROPS=%PROPS% -Dooc.orb.oa.thread_pool=20
set PROPS=%PROPS% -Xms64M -Xmx128M
set PROPS=%PROPS% -Dooc.naming.port=10000

:run
rem ----- NOTE: The java command must be the very last line of the cmd file to
rem             ensure that the exit value is returned to the caller

java -cp %EAS_PROFILE_CLASSPATH%  -DOPTITDIR=%EOS_PRODUCT_ROOT%\OptimizeIt-4.0.2 -Djava.security.policy==%EASLIB%\security\server.policy %ORBINIT% %PROPS% -DAUDIT=jni -Xrunoii intuitive.audit.Audit com.trifork.eas.tools.cmd.Main %*

