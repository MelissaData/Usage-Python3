#!/bin/bash

# Runs the Melissa Usage Cloud API Python 3 sample.
#
# This script runs UsagePython3.py with python3, passing along the license.
# The Usage API reports the status and usage of the license sent in the
# request; it can only check that license.
#
# Overall flow:
#   1. Parse the command-line options below.
#   2. Resolve the license (--license, then a prompt, then the MD_LICENSE environment variable).
#   3. Run UsagePython3.py with the license.
#
# Options:
#   --license   License string to check. If omitted, the script prompts for it; if the
#               prompt is left blank, it falls back to MD_LICENSE.
#
# UsagePython3.py is found relative to the current directory, so run the script from its own folder.
#
# Examples:
#   ./UsagePython3.sh
#   ./UsagePython3.sh --license "<your_license_string>"

######################### Constants ##########################

RED='\033[0;31m' #RED
NC='\033[0m' # No Color

######################### Parameters ##########################

license=""

# Read each --flag and its value. A flag with no value, or whose value starts with
# "-", is an error. Unrecognized options are ignored.
while [ $# -gt 0 ] ; do
  case $1 in
    --license)
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'license\'.${NC}\n"
            exit 1
        fi

        license="$2"
        shift
        ;;
  esac
  shift
done

########################## Main ############################
printf "\n===================== Melissa Usage Cloud API ========================\n"

# Get license (either from parameters or user input)
if [ -z "$license" ];
then
  printf "Please enter your license string: "
  read license
fi

# Check for License from Environment Variables
if [ -z "$license" ];
then
  license="$MD_LICENSE"
fi

if [ -z "$license" ];
then
  printf "\nLicense String is invalid!\n"
  exit 1
fi

# Run project
python3 UsagePython3.py --license "$license"
