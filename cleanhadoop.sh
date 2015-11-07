#!/bin/bash -p

#clean the directories and pacakges when installing cloudera-manager. if you have old versions of cloudera-manager you have to clean 
#to get a good install. 
#a good install=startup and the components work correctly. can get valid cloudera manager install but the components have permission errors in random places

stopProcesses() {
  echo "stopping all java and python processes...if there is no other messages then there are no current java or python processes running"
  output=$(pgrep python)
  for pid in $output; do
    echo "killing python pid:$pid";
    kill -9 $pid
  done

 output=$(pgrep java)
 for pid in $output; do
  echo "killing java pid: $pid";
  kill -9 $pid
 done

}

cleanCloudera(){
  echo "running the cloudera uninstall instructions"

  if [ -e /usr/share/cmf/uninstall-cloudera-manager.sh ] 
  then
     echo "running the cloudera-manager.sh uninstall program"
     /usr/share/cmf/uninstall-cloudera-manager.sh
  else
     echo "the /usr/share/cmf/uninstall-cloudera-manager.sh program is not installed"
  fi
  if [ -d /usr/share/cmf  ]; then 
    echo "removing /usr/share/cmf"
    rm -rf /usr/share/cmf
  fi
  if [  -d /var/cache/yum/cloudera* ]; then
    echo "removong /var/cache/yum/cloudera"
    rm -rf /var/cache/yum/cloudera
  fi
  if [ -d /opt/cloudera ]; then
    echo "removing /opt/cloudera"
    rm -rf /opt/cloudera
  fi
}

# if we see this as output, we want to keep it: jdk.x86_64                         2000:1.6.0_31-fcs                 @cloudera-manager
cleanYum() {
  echo "cleaning any leftover cloudera packages still installed"
  var="$( yum list installed | grep cloudera)"
  echo "${var}"
  //parse and remove each of these packages... easier to just hard code this...
  yum -y remove cloudera-manager\*

}


cleanDirs(){
arrHadoopComponents=(
  "hadoop"
  "hadoop-hdfs"
  "hadoop-yarn"
  "hadoop-mapreduce"
  "hadoop-httpfs"
  "hadoop-kms"
  "hdfs"
  "yarn"
  "pig"
  "mapred"
  "hive"
  "hive-hcatalog"
  "hive-webhcat"
  "sqoop"
  "sqoop2"
  "impala"
  "spark"
  "hbase"
  "hbase-solr"
  "sentry"
  "oozie"
  "zookeeper"
  "solr"
  "pig"
  "pyspark"
  "mahout"
  "llama"
  "llamaadmin"
  "flume"
  "flume-ng"
  "zookeeper"
  "cloudera-scm"
  "cloudera-scm-agent"
  "cloudera-scm-server"
  "postgres"
  "cloudera"
  "cloudera-manager-installer"
  "hue"
  "postgres"
  "avro"
  "beeline"
  "whirr"
  "kite"
  "statestord"
)
 
  for comp in ${arrHadoopComponents[*]}
  do
    #remove /var/lib/alternatives
     echo "removing /var/lib/alternatives/$comp""*"
     rm -f /var/lib/alternatives/$comp*
     rm -f /usr/bin/$comp*     
     rm -rf /etc/alternatives/$comp*
    
    if [ -d /var/lib/$comp ]; then
       echo "removing /var/lib/$comp"
       rm -rf /var/lib/$comp*
    fi
    if [ -d /var/run/$comp ] ;then
       echo "removing /var/riun/$comp"
       rm -rf /var/run/$comp*
    fi
    if [ -d /usr/lib/$comp ] ;then
       echo "removing /usr/lib/$comp"
       rm -rf /usr/lib/$comp*
    fi
    if [ -d /etc/$comp ] ; then
      echo "removing /etc/$comp"
      rm -rf /etc/$comp*
    fi
    if [ -e /usr/bin/$comp ]; then
      echo "removing /usr/bin/$comp"
      rm -rf /usr/bin/$comp*
    fi
    if [ -d /var/log/$comp ]; then
       echo "removing /var/log/$comp"
       rm -rf /var/log/$comp*
    fi
    echo "checking for user $comp"
    var=$(id $comp)
    if [[ $var==uid* ]] ;then
       echo "deleting user:$comp"
       userdel $comp
    fi
  done

}


cleanPackages(){
  yum -y remove postgres\*
}

stopProcesses
cleanCloudera
cleanYum
cleanDirs
cleanPackages
