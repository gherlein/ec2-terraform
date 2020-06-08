terraform state pull | grep "public_ip\"" | awk '{print $2}' | awk '{gsub (/\"/,"")};1' |awk '{gsub(/,$/,"");print}'


