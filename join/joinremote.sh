#!/bin/bash -p


impala-shell -p -q " select count(*) from blkdev.table100chars, blkdev.table100chars2 where blkdev.table100chars.col1 = blkdev.table100chars2.col2;" | tee joinremote.output

