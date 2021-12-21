#!/bin/bash

# Check for arguments
if [ "$1" = "--no-scripts" ]; then
  export NO_SCRIPTS=true
fi
if [ "$1" = "--no-sudo" ]; then
  export NO_SUDO=true
fi

# Check for vmware
if pgrep vmware-tools > /dev/null; then
  export IS_VM=true
fi

# Check for virtualbox
if pgrep VBoxService > /dev/null; then
  export IS_VM=true
fi

# See: http://stackoverflow.com/questions/394230/detect-the-os-from-a-bash-script
case $OSTYPE in
  linux*)
    export OS=linux
    ;;
  darwin*)
    export OS=macos
    ;;
  cygwin*)
    export OS=cygwin
    ;;
  msys*)
    export OS=msys
    ;;
  win*)
    export OS=win
    ;;
  freebsd*)
    export OS=freebsd
    ;;
esac