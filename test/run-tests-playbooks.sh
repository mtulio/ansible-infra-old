#!/bin/bash

# Retrieve playbooks to be tested, from list test/run-tests-playbooks.list run it

PLAYBOOK_LIST=test/run-tests-playbooks.list

echo "Retriving the list of playbooks to be tested from [$PLAYBOOK_LIST]."

for P_PATH in $(cat $PLAYBOOK_LIST)
do
  echo    "##########################################################"
  echo    "##########################################################"
  echo -e "\t###>> Testing playbook = [$P_PATH] <<###"

  exit_code=0

  if [ -f $P_PATH ]; then
      echo -e "\n> Testing playbook: $P_PATH"
      ansible-playbook -i test/inventory $P_PATH --syntax-check
      let "exit_code += $?"
      ansible-playbook -i test/inventory $P_PATH --connection=local
      let "exit_code += $?"
  else
      echo -e "> No test playbooks: $P_PATH [file not found]\n"
  fi

done

exit $exit_code
