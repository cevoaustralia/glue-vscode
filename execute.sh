#!/usr/bin/env bash

## configure python runtime
if [ -z "$use_venv" ]; then
  pypsark_python=python
else
  pypsark_python=/root/venv/bin/python
fi
echo "pyspark python - $pypsark_python"

execution=$1
echo "execution - $execution"

## remove first argument
shift 1
echo $@

## set up command
if [ $execution == 'pyspark' ]; then
  sudo su -c "PYSPARK_PYTHON=$pypsark_python /home/aws-glue-libs/bin/gluepyspark"
elif [ $execution == 'spark-submit' ]; then
  sudo su -c "PYSPARK_PYTHON=$pypsark_python /home/aws-glue-libs/bin/gluesparksubmit $@"
elif [ $execution == 'pytest' ]; then
  sudo su -c "PYSPARK_PYTHON=$pypsark_python /home/aws-glue-libs/bin/gluepytest $@"
elif [ $execution == 'pytest2' ]; then
  sudo su -c "PYSPARK_PYTHON=$pypsark_python /home/aws-glue-libs/bin/gluepytest2 $@"
else
  echo "unsupported execution - $execution"
  exit 1
fi
