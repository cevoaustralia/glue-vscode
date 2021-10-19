#!/usr/bin/env bash

## remove first argument
execution=$1
echo "execution type - $execution"

shift 1
echo $@

## set up command
if [ $execution == 'pyspark' ]; then
  sudo su -c "$GLUE_HOME/bin/gluepyspark"
elif [ $execution == 'spark-submit' ]; then
  sudo su -c "$GLUE_HOME/bin/gluesparksubmit $@"
elif [ $execution == 'pytest' ]; then
  sudo su -c "$GLUE_HOME/bin/gluepytest $@"
else
  echo "unsupported execution type - $execution"
  exit 1
fi