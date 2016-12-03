#!/bin/bash

# Script based on CircleCI DOC https://circleci.com/docs/parallel-manual-setup/#manual-balancing
# Run parallel scripts with prefix test/run-test-*.sh

echo "CIRCLE_NODE_TOTAL=[$CIRCLE_NODE_TOTAL]"
echo "CIRCLE_NODE_INDEX=[$CIRCLE_NODE_INDEX]"

testfiles=$(find ./test -name 'run-test-*.sh' | sort | awk "NR % ${CIRCLE_NODE_TOTAL} == ${CIRCLE_NODE_INDEX}")

if [ -z "$testfiles" ]
then
    echo "[$0] Parallel ERROR: more parallelism than tests scripts. "
    echo "[$0] The follow script will be ignored [$testfiles]";
    exit 1;
else
    echo "[$0] Balancing parallel scripts: [$testfiles]"
    test-runner $testfiles
fi
