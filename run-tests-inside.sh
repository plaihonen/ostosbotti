#!/bin/bash
########################################################
#
# 	This script connects to the localVirtualBox VM,
# 	in order to launch test run there.
# 	VM is standard Linux installation with Chrome
# 	and Firefox installed.
# 	Naturally Robot Framework and Selenium2Library
# 	Must be installed there as well.
#
########################################################

cd /headless/tests

# TAGS
# TAG=main
# TAG=memberships
# TAG=integration
TAG=buy

# TEST_RESULTS="./test_results"
TEST_RESULTS="/headless/tests/test_results/${TESTER_NUM}"
ADDL_PARAMS=" -W $(tput cols) -C on -d ${TEST_RESULTS}"

# RUN="robot ${ADDL_PARAMS} login_tests"
RUN="robot -i ${TAG} ${ADDL_PARAMS} . "

echo "robot cmd: ${RUN}"

rm -rf ${TEST_RESULTS}/*
rm -rf core

${RUN}

# Display the test results in default web browser
# sensible-browser ${TEST_RESULTS}/report.html
# firefox test_results/report.html

# We need to add a "pid" type file for Jenkins to detect the run completion

exit 0