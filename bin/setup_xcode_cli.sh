#!/bin/bash

# See http://apple.stackexchange.com/questions/107307/how-can-i-install-the-command-line-tools-completely-from-the-command-line

echo "Checking Xcode CLI tools"
# Only run if the tools are not installed yet
# To check that try to print the SDK path
xcode-select -p &> /dev/null
if [ $? -ne 0 ]; then
  echo "Xcode CLI tools not found. Installing them..."
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
  PROD=$(softwareupdate -l |
    grep "\*.*Command Line" |
    tail -n 1 | sed 's/^[^C]* //')
    echo "Prod: ${PROD}"
  softwareupdate -i "$PROD" --verbose;
else
  echo "Xcode CLI tools OK"
fi
