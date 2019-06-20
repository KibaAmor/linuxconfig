#!/bin/bash

echo "python gdb.COMPLETE_EXPRESSION = gdb.COMPLETE_SYMBOL" > ~/.gdbinit
cat gdb-dashboard-0.6.0 stl-views-1.0.3.gdb >> ~/.gdbinit
