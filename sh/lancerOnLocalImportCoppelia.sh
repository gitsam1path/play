COPPELIA_DIRECTORY=/home/af719005/workspace/recep/csv/
APP_CONFIG=../java/mce/conf/application.conf
DIST_UNZIPPED=../java/mce/target/universal/stage/lib/*
XMS=512m
XMX=512m

/usr/lib/jvm/jdk1.7/bin/java -DapplyEvolutions.default=true -Dome.directory=$OME_DIRECTORY -Dconfig.file=$APP_CONFIG -Xms$XMS -Xmx$XMX -cp "$DIST_UNZIPPED" batch.coppelia.CoppeliaBatchApp .

