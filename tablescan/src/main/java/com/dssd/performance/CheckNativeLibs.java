package com.dssd.performance;

import java.net.URI;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;


public class CheckNativeLibs {

	
	public static void main(String []args){
		try{
			Configuration conf = new Configuration();
			//conf.setBoolean(DFSConfigKeys.DFS_CLIENT_READ_SHORTCIRCUIT_KEY, true);
			conf.set("fs.default.name", "hdfs://quickstart.cloudera:8020");
			
			FileSystem fs = FileSystem.get(conf);
			URI u =fs.getDefaultUri(conf);
			System.out.println(u.toString());
			fs.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
