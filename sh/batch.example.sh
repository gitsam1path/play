APP_CONFIG=${APPLI_PARAM}/application_dev.conf
DIST_UNZIPPED=${APPLI_COMP}/java/mce/lib/*
XMS=512m
XMX=512m

java -Dlogger.file=${APPLI_PARAM}/logger.xml -Dconfig.file=$APP_CONFIG -Xms$XMS -Xmx$XMX -cp "$DIST_UNZIPPED" batch.CoppeliaBatchApp .
