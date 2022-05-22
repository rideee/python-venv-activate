# Python Virtual Environment Activator

Simple Bash script which detects virtual environment and sources it in subshell.

This script detects if project is managed by poetry and if that is true,
it is running poetry shell, otherwise script creating subshell and source
activate script.
