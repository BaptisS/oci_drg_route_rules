#!/bin/sh
###--drgrtlist.sh--
export drg=$1
export region=$2
drgobj=$(oci network drg get --drg-id $drg --region $region)
drgname=$(echo $drgobj | jq -r '.data | ."display-name"')
rm -f rrules-*.csv
drgrtlist=$(oci network drg-route-table list --all --drg-id $drg --region $region --query 'data[?!contains("display-name",'"'Auto'"')]') 
drgrtlistcur=$(echo $drgrtlist | jq -r '.[] | ."id"')

for drgrtid in $drgrtlistcur; do echo "Enumerating Route Rules in" $region $drgname $drgrtid && ./rrlist.sh $drgrtid $region $drgname; done
cat rrules-*.csv >> drgrtrules-$drgname-$region.csv
