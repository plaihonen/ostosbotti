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

# TAGS
# TAG=main
# TAG=memberships
TAG=integration
TAG=MrGrp*

SHARED_FOLDER="~/robot_tests"
TEST_RESULTS="./test_results"
ADDL_PARAMS=" -W $(tput cols) -C on -d ${TEST_RESULTS}"

# RUN="robot ${ADDL_PARAMS} login_tests"
RUN="robot -i ${TAG} ${ADDL_PARAMS} . "

echo "robot cmd: ${RUN}"

rm -rf ${TEST_RESULTS}/*.png

# Login to test VM, and perform tests
ssh -p 10022 pietu@localhost "export DISPLAY=:0.0; \
  cd ${SHARED_FOLDER}; \
  ${RUN};" # \
  # sensible-browser ${TEST_RESULTS}/report.html"

# Display the test results in default web browser
sensible-browser ${TEST_RESULTS}/report.html

exit 0
