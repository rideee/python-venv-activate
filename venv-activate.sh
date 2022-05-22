#!/usr/bin/env bash

# This script detects if project is managed by poetry and if so,
# it is running poetry shell, otherwise script creates a subshell and sources
# the 'activate' script.
#
# Made by Michal Katnik (github.com/rideee)
#
# Exit codes meaning:
#   0   No errors.
#   1   Script 'activate' not found.
#   2   Internal command problem.
#   3   VIRTUAL_ENV is already set.

working_dir="$(dirname "$0")"
is_poetry_managed=false

# if --get-me option.
if [[ $1 == '--get-me' ]]; then
    if [[ -n $2 ]]; then
        working_dir=$2
    else
        working_dir='.'
    fi

    if [[ -n $3 ]]; then
        file_name="$3"
    else
        file_name='venv-activate.sh'
    fi

    curl -o "$working_dir/$file_name" \
        https://raw.githubusercontent.com/rideee/python-venv-activate/main/venv-activate.sh ||
        exit 2

    chmod u+x "$working_dir/$file_name" || exit 2

    exit 0
fi

# Change current working directory to $1 if is not empty.
if [[ -n $1 ]]; then
    working_dir=$1
fi

# Check if project is managed by poetry.
if [[ -e "${working_dir}/poetry.lock" ]] ||
    [[ -e "${working_dir}/pyproject.toml" ]]; then
    is_poetry_managed=true
fi

# If $VIRTUAL_ENV is not set,
# run poetry shell if project is managed by poetry and poetry is in $PATH,
# otherwise srouce virtual env if exist.
if [[ -z "$VIRTUAL_ENV" ]]; then
    if $is_poetry_managed && type poetry >&/dev/null; then
        cd "$working_dir" >&/dev/null || exit 2
        poetry shell || exit 2
        cd - >&/dev/null || exit 2
    else
        activate_location=$(find "$working_dir" -name 'activate')
        if [[ -n "$activate_location" ]]; then
            echo -e "Python virtual environment detected.\n${activate_location}"
            echo "Creating a subshell."
            bash -c ". ${activate_location}; $SHELL"
        else
            echo -e "Virtual env 'activate' file not found in '${working_dir}'." >&2
            exit 1
        fi
    fi
else
    echo -e "VIRTUAL_ENV is already set:\n$VIRTUAL_ENV" >&2
    exit 3
fi
