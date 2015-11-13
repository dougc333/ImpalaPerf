#!/bin/bash -p

#valid on CDH installation only; make sure to update path
arr=( $(locate hadoop-hdfs-tests.jar) )
echo "installing " ${arr[@]}
mvn install:install-file -Dfile=${arr[@]} -DgroupId=org.apache.hadoop -DartifactId=hadoop-hdfs-tests -Dversion=2.7.1 -Dpackaging=jar

#
#mvn install:install-file -Dfile=/opt/cloudera/parcels/CDH-5.4.7-1.cdh5.4.7.p0.3/lib/hadoop-hdfs/hadoop-hdfs-tests.jar -DgroupId=org.apache.hadoop -DartifactId=hadoop-hdfs-tests -Dversion=2.7.1 -Dpackaging=jar
#
