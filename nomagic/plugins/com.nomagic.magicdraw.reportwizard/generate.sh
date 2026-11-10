#!/bin/sh
# Add below code for fixing "Could not find or load main class com.nomagic.magicdraw.magicreport.CommandLine" of Mac OSX with Java 1.8
BASE=$(dirname "$0")
ARGS=""

if [ $# -gt 1 ]; then
  while [ $# -ge 1 ]; do
    case "$1" in
    -[a-z]*) ARGS="$ARGS $1" ;;
    *) ARGS="$ARGS \"$1\"" ;;
    esac
    shift
  done
fi

REQUIRED_JAVA_VERSION=11

if [ "$JAVA_HOME" ]; then
  JAVA_COMMAND=$JAVA_HOME/bin/java
else
  JAVA_COMMAND=java
fi

VERSION=$("$JAVA_COMMAND" -version 2>&1 | awk -F '"' '/version/ {print $2}')

if [ -n "$VERSION" ]; then
  if [[ $VERSION == "1."* ]]; then
    JAVA_VERSION=$(echo $VERSION | sed -e 's/1\.\([0-9]*\)\(.*\)/\1/; 1q')
  else
    JAVA_VERSION=$(echo $VERSION | sed -e 's/\([0-9]*\)\(.*\)/\1/; 1q')
  fi

  if [[ $REQUIRED_JAVA_VERSION == "1."* ]]; then
    REQUIRED_VERSION=$(echo $REQUIRED_JAVA_VERSION | sed -e 's/1\.\([0-9]*\)\(.*\)/\1/; 1q')
  else
    REQUIRED_VERSION=$(echo $REQUIRED_JAVA_VERSION | sed -e 's/\([0-9]*\)\(.*\)/\1/; 1q')
  fi

  if [ $JAVA_VERSION -eq $REQUIRED_VERSION ]; then
    CLASSPATH=./reportwizard_api.jar:./reportwizard.jar:./lib/magicreport.jar:./requiredlibs/*
    EXEC_COMMAND="cd \"$BASE\" && \"$JAVA_COMMAND\" -cp $CLASSPATH com.nomagic.magicdraw.magicreport.CommandLineStartupChecker $ARGS"
    echo $ARGS
    eval $EXEC_COMMAND

    if [ $? -eq 20 ]; then
      # Two levels of indirection are here to preserve dollar sign
      CLASSPATH=.:./requiredlibs/*
      MD_CLASS_PATH='$java.class.path'
      MD_CLASS_PATH_I='$MD_CLASS_PATH'
      VM_OPTIONS="-Xmx6000M -Dcom.nomagic.magicdraw.commandline.action=com.nomagic.magicdraw.magicreport.CommandLineAction -Desi.system.config=../../data/application.conf"
      EXEC_COMMAND="cd \"$BASE\" && exec \"$JAVA_COMMAND\" $VM_OPTIONS -cp $CLASSPATH com.nomagic.magicdraw.commandline.CommandLineActionLauncher $ARGS"
      eval $EXEC_COMMAND
    fi
  else
    echo "Required JVM version $REQUIRED_JAVA_VERSION is not found."
    echo "Your java version is $VERSION."
  fi
else
  echo "Cannot find java version, please check JAVA_HOME or set JAVA_COMMAND to define java path."
fi
