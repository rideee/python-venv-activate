#!/usr/bin/env bash

# This script detects if project is managed by poetry and if so,
# it is running poetry shell, otherwise script creates a subshell and sources
# the 'activate' script.
#
# Made by Michal Katnik (github.com/rideee)

cwd="$(dirname "$0")"
is_poetry_managed=false

# Change current working directory to $1 if is not empty.
if [[ -n $1 ]]; then
    cwd=$1
fi

# Check if project is managed by poetry.
if [[ -e "${cwd}/poetry.lock" ]] || [[ -e "${cwd}/pyproject.toml" ]]; then
    is_poetry_managed=true
fi

# If $VIRTUAL_ENV is not set,
# run poetry shell if project is managed by poetry and poetry is in $PATH,
# otherwise srouce virtual env if exist.
if [[ -z "$VIRTUAL_ENV" ]]; then
    if $is_poetry_managed && type poetry >&/dev/null; then
        cd "$cwd" >&/dev/null || exit 2
        poetry shell
        cd - >&/dev/null || exit 2
    else
        activate_location=$(find "$cwd" -name 'activate')
        if [[ -n "$activate_location" ]]; then
            echo -e "Python virtual environment detected.\n${activate_location}"
            echo -e "Creating a subshell."
            bash -c ". ${activate_location}; $SHELL"
        fi
    fi
fi
