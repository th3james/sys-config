function veex -d "exec in venv"
  if is_installed pipenv
    set -l venv_dir (pipenv --venv 2> /dev/null)
  end
  if not string length -q venv_dir
    set -l venv_dir ".venv"
  end

  source $venv_dir/bin/activate.fish
  $argv
end
