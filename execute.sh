#!/usr/bin/env bash

## configure python runtime
if [ "$version" == "1" ]; then
  pyspark_python=python
elif [ "$version" == "2" ]; then
  pyspark_python=/root/venv/bin/python
else
  echo "unsupported version - $version, only 1 or 2 is accepted"
  exit 1
fi
echo "pyspark python - $pyspark_python"

execution=$1
echo "execution type - $execution"

## remove first argument
shift 1
echo $@

## set up command
if [ $execution == 'pyspark' ]; then
  sudo su -c "PYSPARK_PYTHON=$pyspark_python /home/aws-glue-libs/bin/gluepyspark"
elif [ $execution == 'spark-submit' ]; then
  sudo su -c "PYSPARK_PYTHON=$pyspark_python /home/aws-glue-libs/bin/gluesparksubmit $@"
elif [ $execution == 'pytest' ]; then
  if [ $version == "1" ]; then
    sudo su -c "PYSPARK_PYTHON=$pyspark_python /home/aws-glue-libs/bin/gluepytest $@"
  else
    sudo su -c "PYSPARK_PYTHON=$pyspark_python /home/aws-glue-libs/bin/gluepytest2 $@"
  fi
else
  echo "unsupported execution type - $execution"
  exit 1
fi