#!/bin/sh
###--rrlist.sh--
export drgrtid=$1
export region=$2
export drgname=$3

drgrtobj=$(oci network drg-route-table get --drg-route-table-id $drgrtid --region $region)
drgrtname=$(echo $drgrtobj | jq -r '.data | ."display-name"')
rm -f rrules-$drgname-$drgrtid.json
rm -f rrules-$drgname-$drgrtid.csv 
oci network drg-route-rule list --all --drg-route-table-id $drgrtid --region $region >> rrules-$drgname-$drgrtid.json
cat rrules-$drgname-$drgrtid.json | jq -r '.data[] | ["'"$drgname"'", "'"$drgrtname"'", ."id", ."destination", ."destination-type", ."next-hop-drg-attachment-id", ."is-blackhole", ."is-conflict", ."route-provenance", ."route-type", ."attributes"]| @csv ' >> rrules-$drgname-$drgrtid.csv
rm -f rrules-$drgname-$drgrtname-$drgrtid.json
