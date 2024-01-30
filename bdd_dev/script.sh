#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <field_name> <field_value>"
    exit 1
fi

field_name=$1
field_value=$2

# Calculate percentage
percentage=$(jq --argjson field_value "$field_value" --arg field_name "$field_name" \
  '.response.donneesEssentielles[] | select(.domainListDonneesEssentiellesMP.domainRecuperDEDeBase[$field_name] == $field_value) | .domainListDonneesEssentiellesMP.donneesDeBase.id' data.json | \
  wc -l | awk '{ printf "%.2f\n", ($1 / total) * 100 }' total=$(jq '.response.donneesEssentielles | length' data.json))

# Print the percentage
printf "Percentage of entries with '$field_name' equal to '$field_value': %.2f%%\n" "$percentage"

# List IDs with the specified condition
echo "IDs with '$field_name' equal to '$field_value':"
jq --argjson field_value "$field_value" --arg field_name "$field_name" \
  '.response.donneesEssentielles[] | select(.domainListDonneesEssentiellesMP.domainRecuperDEDeBase[$field_name] == $field_value) | .domainListDonneesEssentiellesMP.donneesDeBase.id' data.json
