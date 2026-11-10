@echo off
setlocal ENABLEDELAYEDEXPANSION

echo %*

set REQUIRED_JAVA_VERSION=11

if "%JAVA_HOME%" == "" (
    set JAVA_PATH=java
) else (
    set JAVA_PATH=%JAVA_HOME%\bin\java
)
REM set JAVA_PATH=C:/Program Files/AdoptOpenJDK/jdk-8.0.232.09-openj9/jre/bin/java.exe

for /F tokens^=2-5^ delims^=^" %%j in ('"%JAVA_PATH%" -fullversion 2^>^&1') do set "VERSION=%%j%%k%%l"

if defined VERSION (
	GOTO checkjava
) else (
	echo Cannot find java version, please check JAVA_HOME or set JAVA_PATH to define java path.
	GOTO:EOF
)

:checkjava
REM Short version
for /F "delims=.-_ tokens=1-2" %%v in ("%VERSION%") do (
  if /I "%%v" EQU "1" (
    set JAVA_VERSION=%%w
  ) else (
    set JAVA_VERSION=%%v
  )
)

for /F "delims=.-_ tokens=1-2" %%v in ("%REQUIRED_JAVA_VERSION%") do (
  if /I "%%v" EQU "1" (
    set REQUIRED_VERSION=%%w
  ) else (
    set REQUIRED_VERSION=%%v
  )
)

if %JAVA_VERSION% equ %REQUIRED_VERSION% (
	GOTO run
) else (
	GOTO notsupportjava
)

:notsupportjava
echo Required JVM version %REQUIRED_JAVA_VERSION% is not found.
echo Your java version is %VERSION%.
GOTO:EOF

:run
set CLASSPATH=.;./reportwizard_api.jar;./reportwizard.jar;./lib/magicreport.jar;./requiredlibs/*
cd /D "%~dp0"
"%JAVA_PATH%" com.nomagic.magicdraw.magicreport.CommandLineStartupChecker %*

if %ERRORLEVEL% equ 20 (
	echo Starting MagicDraw ...
	set CLASSPATH=.;./requiredlibs/*
	set MAIN_CLASS=com.nomagic.magicdraw.commandline.CommandLineActionLauncher
	set CONSOLE=false
	set MAC_JAVA_ARGS="-Xdock:name=MagicDraw"  -Xdock:icon=bin/app.icns -Dapple.laf.useScreenMenuBar=true
	cd /D "%~dp0"
	"%JAVA_PATH%" -Xmx6000M -Dcom.nomagic.magicdraw.commandline.action=com.nomagic.magicdraw.magicreport.CommandLineAction -Desi.system.config=../../data/application.conf com.nomagic.magicdraw.commandline.CommandLineActionLauncher %*
)
