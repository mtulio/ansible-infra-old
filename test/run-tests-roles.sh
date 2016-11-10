#!/bin/bash

# Retrieve roles dir paths from ansible.cfg and test it

ROLES_PATH=$(grep roles_path ansible.cfg |awk -F'=' '{print$2}')

for R_PATH in $(echo $ROLES_PATH |tr ':' ' ')
do
  echo -e "\n"
  echo    "##########################################################"
  echo    "##########################################################"
  echo -e "\t###>> Testing roles path = [$R_PATH] <<###"

  ROLES=$(ls $R_PATH)
  NOT_TESTED_ROLES=()
  exit_code=0

  for ROLE in ${ROLES[@]}; do
    test $ROLE == "external" && continue;
    test_file="$R_PATH/$ROLE/test.yml"
    if [ -f $test_file ]; then
      echo -e "\n> Testing role: $R_PATH/$ROLE"
      ansible-playbook -i test/inventory $R_PATH/$ROLE/test.yml --syntax-check
      let "exit_code += $?"
      ansible-playbook -i test/inventory $R_PATH/$ROLE/test.yml --connection=local
      let "exit_code += $?"
    else
      NOT_TESTED_ROLES+=($R_PATH/$ROLE)
    fi
  done
  NOT_TESTED_ROLES_STRING=$(IFS=', '; echo "${NOT_TESTED_ROLES[*]}")
  echo -e "> No test configured for roles: $NOT_TESTED_ROLES_STRING \n"
done

exit $exit_code
