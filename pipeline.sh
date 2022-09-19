#!/usr/bin/env bash

# -------------------------------------------------------------------------------- #
# Description                                                                      #
# -------------------------------------------------------------------------------- #
# This script will locate and process all relevant files within the given git      #
# repository. Errors will be stored and a final exit status used to show if a      #
# failure occured during the processing.                                           #
# -------------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------- #
# Configure the shell.                                                             #
# -------------------------------------------------------------------------------- #

set -Eeuo pipefail

# -------------------------------------------------------------------------------- #
# Global Variables                                                                 #
# -------------------------------------------------------------------------------- #
# GEM_NAME - The name of the Ruby Gem to install.                                  #
# INSTALL_COMMAND - The command to execute to do the install.                      #
# TEST_COMMAND - The command to execute to perform the test.                       #
# TEST_FLAGS - The flags to password to the test command.                          #
# FILE_TYPE_SEARCH_PATTERN - The pattern used to match file types.                 #
# FILE_NAME_SEARCH_PATTERN - The pattern used to match file names.                 #
# EXIT_VALUE - Used to store the script exit value - adjusted by the fail().       #
# CURRENT_STAGE - The current stage used for the reporting output.                 #
# -------------------------------------------------------------------------------- #

GEM_NAME='github-linguist'
INSTALL_COMMAND="gem install --quiet ${GEM_NAME}"

TEST_COMMAND='github-linguist'
TEST_FLAGS='--breakdown'
#FILE_TYPE_SEARCH_PATTERN='unused'
#FILE_NAME_SEARCH_PATTERN='unused'

EXIT_VALUE=0
CURRENT_STAGE=0

# -------------------------------------------------------------------------------- #
# Install Prerequisites                                                            #
# -------------------------------------------------------------------------------- #
# Install the required tooling.                                                    #
# -------------------------------------------------------------------------------- #

function install_prerequisites
{
    stage "Install Prerequisites"

    if ! command -v ${TEST_COMMAND} &> /dev/null
    then
        if errors=$( ${INSTALL_COMMAND} 2>&1 ); then
            success "${INSTALL_COMMAND}"
        else
            fail "${INSTALL_COMMAND}" "${errors}"
            exit $EXIT_VALUE
        fi
    else
        success "${TEST_COMMAND} is alredy installed"
    fi
}

# -------------------------------------------------------------------------------- #
# Get Version Information                                                          #
# -------------------------------------------------------------------------------- #
# Get the current version of the required tool.                                    #
# -------------------------------------------------------------------------------- #

function get_version_information
{
    VERSION=$(gem list | grep "^${GEM_NAME} " | sed 's/[^0-9.]*\([0-9.]*\).*/\1/')
    BANNER="Run ${TEST_COMMAND} (v${VERSION})"
}

# -------------------------------------------------------------------------------- #
# Scan Files                                                                       #
# -------------------------------------------------------------------------------- #
# Locate all of the relevant files within the repo and process compatible ones.    #
# -------------------------------------------------------------------------------- #

function scan_files()
{
    $TEST_COMMAND $TEST_FLAGS
}

# -------------------------------------------------------------------------------- #
# Handle Parameters                                                                #
# -------------------------------------------------------------------------------- #
# Handle any parameters from the pipeline.                                         #
# -------------------------------------------------------------------------------- #

function handle_parameters
{
    stage "Parameters"
}

# -------------------------------------------------------------------------------- #
# Success                                                                          #
# -------------------------------------------------------------------------------- #
# Show the user that the processing of a specific file was successful.             #
# -------------------------------------------------------------------------------- #

function success()
{
    local message="${1:-}"

    if [[ -n "${message}" ]]; then
        printf ' [  %s%sOK%s  ] %s\n' "${bold}" "${success}" "${normal}" "${message}"
    fi
}

# -------------------------------------------------------------------------------- #
# Fail                                                                             #
# -------------------------------------------------------------------------------- #
# Show the user that the processing of a specific file failed and adjust the       #
# EXIT_VALUE to record this.                                                       #
# -------------------------------------------------------------------------------- #

function fail()
{
    local message="${1:-}"
    local errors="${2:-}"

    if [[ -n "${message}" ]]; then
        printf ' [ %s%sFAIL%s ] %s\n' "${bold}" "${error}" "${normal}" "${message}"
    fi

    if [[ -n "${errors}" ]]; then
        echo
        mapfile -t error_array <<< "${errors}"
        for err in "${error_array[@]}"
        do
            echo -e "          ${err}"
        done
        echo
    fi

    EXIT_VALUE=1
}

# -------------------------------------------------------------------------------- #
# Draw Line                                                                        #
# -------------------------------------------------------------------------------- #
# Draw a line on the screen. Part of the report generation.                        #
# -------------------------------------------------------------------------------- #

function draw_line
{
    printf '%*s\n' "${screen_width}" '' | tr ' ' -
}

# -------------------------------------------------------------------------------- #
# Align Right                                                                      #
# -------------------------------------------------------------------------------- #
# Draw text alined to the right hand side of the screen.                           #
# -------------------------------------------------------------------------------- #

function align_right()
{
    local message="${1:-}"
    local offset="${2:-2}"
    local width=$screen_width

    local textsize=${#message}
    local left_line='-' left_width=$(( width - (textsize + offset + 2) ))
    local right_line='-' right_width=${offset}

    while ((${#left_line} < left_width)); do left_line+="$left_line"; done
    while ((${#right_line} < right_width)); do right_line+="$right_line"; done

    printf '%s %s %s\n' "${left_line:0:left_width}" "${1}" "${right_line:0:right_width}"
}

# -------------------------------------------------------------------------------- #
# Stage                                                                            #
# -------------------------------------------------------------------------------- #
# Set the current stage number and display the message.                            #
# -------------------------------------------------------------------------------- #

function stage()
{
    message=${1:-}

    CURRENT_STAGE=$((CURRENT_STAGE + 1))

    align_right "Stage ${CURRENT_STAGE} - ${message}"
}

# -------------------------------------------------------------------------------- #
# Draw the report footer on the screen. Part of the report generation.             #
# -------------------------------------------------------------------------------- #

function footer
{
    stage 'Complete'
}

# -------------------------------------------------------------------------------- #
# Setup                                                                            #
# -------------------------------------------------------------------------------- #
# Handle any custom setup that is required.                                        #
# -------------------------------------------------------------------------------- #

function setup
{
    export TERM=xterm

    screen_width=98
    bold="$(tput bold)"
    normal="$(tput sgr0)"
    error="$(tput setaf 1)"
    success="$(tput setaf 2)"
}

# -------------------------------------------------------------------------------- #
# Main()                                                                           #
# -------------------------------------------------------------------------------- #
# This is the actual 'script' and the functions/sub routines are called in order.  #
# -------------------------------------------------------------------------------- #

setup
#handle_parameters
install_prerequisites
get_version_information
stage "${BANNER}"
scan_files
footer

exit $EXIT_VALUE

# -------------------------------------------------------------------------------- #
# End of Script                                                                    #
# -------------------------------------------------------------------------------- #
# This is the end - nothing more to see here.                                      #
# -------------------------------------------------------------------------------- #
