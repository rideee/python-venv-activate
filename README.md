# Python Virtual Environment Activator

Simple Bash script which detects virtual environment and sources it in subshell.

This script detects if project is managed by poetry and if so,
it is running poetry shell, otherwise script creates a subshell and sources the
'activate' script.

## Usage

### Directly in project

You can copy this script directly to your python project (root folder),
give the correct permission to execute,
and simply run the script.
<pre>
  $ cd your-python-project
  $ curl -o venv-activate.sh https://raw.githubusercontent.com/rideee/python-venv-activate/main/venv-activate.sh && chmod u+x venv-activate.sh
  $ ./venv-activate.sh
</pre>

### Global installation

It is also possible to using this script globally. For example:
<pre>
  $ git clone https://github.com/rideee/python-venv-activate $HOME/.python-venv-activate
  $ ln -s $HOME/.python-venv-activate/venv-activate.sh $HOME/.local/bin/venv-activate
</pre>
Make sure that <code>$HOME/.local/bin</code> is in your <code>$PATH</code>.
Now we are able to use this script globally, example:
<pre>
  $ cd your-python-project
  $ venv-activate .
</pre>

When script is installed globally, you can easily get fresh copy from github
using <code>--get-me</code> option:
<pre>
  $ cd your-python-project
  $ venv-activate --get-me . venva.sh   # Path and file name are optional.
</pre>
