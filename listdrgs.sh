#!/bin/sh
### listdrgs.sh
export region=$1
rm -f drgrtrulesregion-$region.csv
oci search resource structured-search --query-text "query drg resources" --region $region > drgs-$region.log
drgocids=$(cat drgs-$region.log | jq -r '.data.items[] | ."identifier"')
for drgid in $drgocids; do echo "Enumerating DRG Route Tables in" $region $drgid && ./drgrtlist.sh $drgid $region; done
cat drgrtrules-*.csv >> drgrtrulesregion-$region.csv
filepath=$(pwd)
echo Report : $filepath/drgrtrulesregion-$region.csv
rm -f drgrtrules-*.csv
