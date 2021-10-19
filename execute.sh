#!/usr/bin/env bash

## configure python runtime
pyspark_python=python
echo "pyspark python - $pyspark_python"

## remove first argument
execution=$1
echo "execution type - $execution"

shift 1
echo $@

## set up command
if [ $execution == 'pyspark' ]; then
  sudo su -c "PYSPARK_PYTHON=$pyspark_python /opt/aws-glue-libs-3.0/bin/gluepyspark"
elif [ $execution == 'spark-submit' ]; then
  sudo su -c "PYSPARK_PYTHON=$pyspark_python /opt/aws-glue-libs-3.0/bin/gluesparksubmit $@"
elif [ $execution == 'pytest' ]; then
  sudo su -c "PYSPARK_PYTHON=$pyspark_python /opt/aws-glue-libs-3.0/bin/gluepytest $@"
else
  echo "unsupported execution type - $execution"
  exit 1
fi