#!/bin/bash
curl -S --progress-bar "http://osmose.openstreetmap.fr/export/osmose-planet-latest.csv.bz2" > osmose-planet-latest.csv.bz2
gzip -d osmose-planet-latest.csv.bz2
mkdir data
while read line
do
    n=$line
    echo "csvgrep -c analyser -r \"$n\" osmose-planet-latest.csv  > data/$n.csv"
    eval "csvgrep -c analyser -r \"$n\" osmose-planet-latest.csv  > data/$n.csv"    
    python csv2shp.py $n.csv $n.shp
done < $1
#rm osmose-planet-latest.csv
