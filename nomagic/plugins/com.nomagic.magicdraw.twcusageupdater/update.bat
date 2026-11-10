@echo off

::
:: Opens modeling tool bin folder
::
cd ..\..\bin\

::
:: Sets PROPERTIES_FILE property by modeling tool
::
if exist magicdraw.properties (
	set PROPERTIES_FILE=magicdraw.properties
)

if exist cameoea.properties (
	set PROPERTIES_FILE=cameoea.properties
)

if exist cbm.properties (
	set PROPERTIES_FILE=cbm.properties
)

if exist csm.properties (
	set  PROPERTIES_FILE=csm.properties
)

if exist msa.properties (
	set  PROPERTIES_FILE=msa.properties
)

if exist mcse.properties (
	set  PROPERTIES_FILE=mcse.properties
)

if exist msosa.properties (
	set  PROPERTIES_FILE=msosa.properties
)

::
:: Returns to updater directory for further execution
::
cd ..\plugins\com.nomagic.magicdraw.twcusageupdater\

::
:: Reads JAVA_HOME path from properties file and creates full path to java executable.
:: Reads CLASSPATH value from properties files
::
@echo off
For /F "tokens=1* delims==" %%A IN (../../bin/%PROPERTIES_FILE%) DO (
    IF "%%A"=="JAVA_HOME" set fullPath=%%B
    IF "%%A"=="CLASSPATH" set MD_CLASSPATH=%%B
)

set MD_CLASSPATH=%MD_CLASSPATH:\:=;%
set MD_CLASSPATH=%MD_CLASSPATH:lib/=../../lib/%

::
:: Creates class path for launching modeling tool.
::
set CLASS_PATH=%MD_CLASSPATH%;^
twcusageupdater.jar;twcusageupdater_api.jar ^
-Desi.system.config=..\..\data\application.conf ^
-Dcom.nomagic.magicdraw.commandline.action=com.nomagic.magicdraw.twcusageupdater.UpdateProjectUsageCommandLineAction ^
com.nomagic.magicdraw.commandline.CommandLineActionLauncher

:: If fullPath does not contain : it means it is a relative path, not a full path. Append it to installation directory.
if "%fullPath::=%" == "%fullPath%" (
    set fullPath=../../%fullPath%
)
set fullPath=%fullPath:\:=:%
set fullPath=%fullPath:\\=/%
echo Java path is %fullPath%

::
:: Launches modeling tool and executes command line action.
::
"%fullPath%/bin/java" -Xmx4000M -Xss1024K -cp %CLASS_PATH% %*