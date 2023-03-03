# oci_drg_route_rules

#!/bin/sh
complist=$(oci iam compartment list --all --compartment-id-in-subtree true) 
complistcur=$(echo $complist | jq .data | jq -r '.[] | ."id"')
rm -f drglist.log
rm -f routes_rules.log
for compocid in $complistcur; do oci network drg list --compartment-id $compocid --all >> drglist.log ; done
drglistcur=$(cat drglist.log | jq .data | jq -r '.[] | ."id"')
for drg in $drglistcur; do oci network drg get --drg-id $drg --query "data.[\"display-name\"]" >> Routes_rules.log && ./rrlist.sh $drg >> routes_rules.log; done
