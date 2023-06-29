#!/bin/sh
###----------rrlist.sh-------------------------
#export drgocid=""
#drgrtlist=$(oci network drg-route-table list --all --drg-id $drgocid) 
drgrtlist=$(oci network drg-route-table list --all --drg-id $1) 
drgrtlistcur=$(echo $drgrtlist | jq .data | jq -r '.[] | ."id"')
for drgrt in $drgrtlistcur; do oci network drg-route-table get --drg-route-table-id $drgrt --query "data.[\"display-name\"]" && oci network drg-route-rule list --all --drg-route-table-id $drgrt --output table; done
###-----------------------------------
