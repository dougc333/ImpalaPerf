#!/bin/bash -p


impala-shell -p -q " select count(*) from blkdev.table100chars, blkdev.table100chars1 where blkdev.table100chars.col1 = blkdev.table100chars1.col2;" | tee join.output

