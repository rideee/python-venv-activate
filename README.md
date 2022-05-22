# Python Virtual Environment Activator

Simple Bash script which detects virtual environment and sources it in subshell.

This script detects if project is managed by poetry and if that is true,
it is running poetry shell, otherwise script creating subshell and source
activate script.

## Usage

### Directly in project

You can copy this script directly to your python project (root folder),
give the correct permission to execute,
and simply run the script.
<code>
  $ cd your-python-project
  $ curl -o venv-activate.sh  <https://raw.githubusercontent.com/rideee/python-venv-activate/main/venv-activate.sh> && chmodu+x venv-activate.sh
  $ ./venv-activate.sh
</code>
