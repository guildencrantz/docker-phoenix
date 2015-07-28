#!/bin/sh

source ~/.bashrc

$HBASE_HOME/bin/hbase regionserver start &
exec $HBASE_HOME/bin/hbase master start 2>&1 | tee $HBASE_HOME/logs/hbase-master.log

# vim: set ts=2 sw=2 sts=2 ai et :
