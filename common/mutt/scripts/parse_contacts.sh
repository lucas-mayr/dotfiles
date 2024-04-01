awk -F ',' '{ printf ("%s \t %s\n"), $31, $1 }' $1 > $2/contacts
