#!/bin/bash -p



impala-shell -p -q "select count(*) from blkdev.testbigdata, blkdev.testbigdata1 where blkdev.testbigdata.id=blkdev.testbigdata1.id and blkdev.testbigdata.name='A' and blkdev.testbigdata1.age=20;" | tee join.txt
