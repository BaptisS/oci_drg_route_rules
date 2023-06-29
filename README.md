# oci_drg_route_rules v2

```

#!/bin/sh
rm -f drgrtlist.sh
rm -f rrlist.sh
rm -f listdrgs.sh
wget https://raw.githubusercontent.com/BaptisS/oci_drg_route_rules/main/drgrtlist.sh
wget https://raw.githubusercontent.com/BaptisS/oci_drg_route_rules/main/listdrgs.sh
wget https://raw.githubusercontent.com/BaptisS/oci_drg_route_rules/main/rrlist.sh
chmod +x listdrgs.sh
chmod +x rrlist.sh
chmod +x drgrtlist.sh

rm -f drgrtrulesglobal.csv
regionslist=$(oci iam region list)
regions=$(echo $regionslist | jq -r '.data[] | ."name"')
for region in $regions; do echo "Enumerating DRG in region" $region &&  ./listdrgs.sh $region ; done
cat drgrtrulesregion-*.csv >> drgrtrulesglobal.csv
rm -f drgrtrulesregion-*.csv
echo drgrtrulesglobal.csv
pwd
```
