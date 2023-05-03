function lint_python -d "Lint a python file or directory of files" -a py_file
  if is_installed black
    black $py_file
  else
    echo "No black, skipping"
  end
  if is_installed ruff
    ruff $py_file
  else
    echo "No ruff, skipping"
  end
  if is_installed mypy
    mypy $py_file
  else
    echo "No mypy, skipping"
  end
end
