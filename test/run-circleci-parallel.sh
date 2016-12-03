#!/bin/bash

# Script based on CircleCI DOC https://circleci.com/docs/parallel-manual-setup/#manual-balancing
# Run parallel scripts with prefix test/run-test-*.sh

echo "CIRCLE_NODE_TOTAL=[$CIRCLE_NODE_TOTAL]"
echo "CIRCLE_NODE_INDEX=[$CIRCLE_NODE_INDEX]"
echo "pwd=[$PWD]"
echo "ARGS=[$@]"

test_script=$(find -name 'run-test-*.sh' | sort | awk "NR % ${CIRCLE_NODE_TOTAL} == ${CIRCLE_NODE_INDEX}")

if [ -z "$test_script" ]
then
    echo "[$0] More parallelism than tests scripts."
    echo "[$0] The follow script will be ignored [$test_script]";
else
    echo "[$0] Running parallel scripts: [$test_script]"
    #bash $test_script
fi
