#!/bin/bash

############################
# Import HARPE Local
############################

APP_CONFIG=../java/mce/conf/application.conf
DIST_UNZIPPED=../java/mce/target/universal/stage/lib/*
LOG_CONFIG=../java/mce/conf/logger.xml
XMS=512m
XMX=512m

java -Dlogger.file=$LOG_CONFIG -Dconfig.file=$APP_CONFIG -Xms$XMS -Xmx$XMX -cp "$DIST_UNZIPPED" batch.ImportHarpeBatchApp .
