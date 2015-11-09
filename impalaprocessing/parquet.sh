#!/bin/bash -p



impala-shell -p -q "create table testdata100chars_parquet like testdata100chars stored as parquetfile;"

