#!/bin/sh
# Minimalist script to convert .kismet SQLite files into WiGLE.net compatible
# CSV Logs
kismetdb_to_wiglecsv --in $1 --out $1.csv
