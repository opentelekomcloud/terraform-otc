#!/bin/bash

if [ $# -lt 2 ]; then
    echo "usage: $0 <action> <credentialsfile>"
    exit 1
fi

ACTION=$1
CREDENTIALS=$2

while read line; do
    username=$(echo ${line} | cut -f1 -d:)
    password=$(echo ${line} | cut -f2 -d:)
    domain=$(echo ${line} | cut -f3 -d:)
    terraform ${ACTION} -var="username=${username}" -var="password=${password}" -var="domain_name=${domain}" -state="${username}-${domain}.state"
done < ${CREDENTIALS}
