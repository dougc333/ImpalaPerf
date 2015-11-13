#!/bin/bash -p

export HADOOP_OPTS="-Dhio.nthreads=5 -Dhio.ngigs.to.read=10 -Dhio.ngigs.in.file=10 -Dhio.hdfs.uri=hdfs://<name-node> -Dhio.hdfs.file.name=test_file"
mvn exec:java -Dexec.mainClass=com.cloudera.HioBench
