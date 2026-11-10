#!/bin/sh
ARGS=""

if [ $# -gt 1 ]; then
	while [ $# -ge 1 ]; do
		case "$1" in
			-[a-z]*) ARGS="$ARGS $1" ;;
			*)
			if [ ! -f "$1" ]
			then
				ARGS="$ARGS \"$1\""
			elif [ `echo $1 | cut -c1-1` = "/" ]
			then
				ARGS="$ARGS \"$1\""
			else
				ARGS="$ARGS \"`pwd`/$1\""
			fi
			;;
		esac
		shift
	done
fi

PROPERTIES_FILE=""

if [ -e ../../bin/magicdraw.properties ]; then
      PROPERTIES_FILE=../../bin/magicdraw.properties
fi

if [ -f ../../bin/cameoea.properties ]; then
      PROPERTIES_FILE=../../bin/cameoea.properties
fi

if [ -f ../../bin/cbm.properties  ]; then
      PROPERTIES_FILE=../../bin/cbm.properties
fi

if [ -f ../../bin/csm.properties ]; then
      PROPERTIES_FILE=../../bin/csm.properties
fi

if [ -f ../../bin/msa.properties ]; then
      PROPERTIES_FILE=../../bin/msa.properties
fi

if [ -f ../../bin/mcse.properties ]; then
      PROPERTIES_FILE=../../bin/mcse.properties
fi

if [ -f ../../bin/msosa.properties ]; then
      PROPERTIES_FILE=../../bin/msosa.properties
fi

#
# VM options.
#
VM_OPTIONS="-Xmx1900M -Xss1024K"

#
# Reads CLASSPATH path from properties file
#
MD_CLASSPATH=`grep "CLASSPATH" $PROPERTIES_FILE | cut -d'=' -f 2`

#
# Class path used to launch modeling tool.
#
CLASS_PATH="$MD_CLASSPATH -Desi.system.config=../../data/application.conf   -Dcom.nomagic.magicdraw.commandline.action=com.nomagic.magicdraw.twcusageupdater.UpdateProjectUsageCommandLineAction com.nomagic.magicdraw.commandline.CommandLineActionLauncher"

#
# Reads JAVA_HOME path from properties file and creates full path to java executable.
#
fullPath=`grep "JAVA_HOME" $PROPERTIES_FILE | cut -d'=' -f 2`

# If it is empty in properties file, uses jre in installation directory (should only happen on Mac).
if [ -z "$fullPath" ]
  then
    fullPath=../../`ls ../.. | grep 'jre'`/mac/Contents/Home/jre
fi
echo Java path is $fullPath

#
# Java command to launch modeling tool.
#
EXEC_COMMAND="exec $fullPath/bin/java $VM_OPTIONS -cp $CLASS_PATH $ARGS"

cd ../..
eval $EXEC_COMMAND
