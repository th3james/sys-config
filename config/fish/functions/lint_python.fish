function lint_python -d "Lint a python file or directory of files" -a py_file
  if is_installed black
    black $py_file
  else
    echo "No black, skipping"
  end
  if is_installed isort
    isort $py_file
  else
    echo "No isort, skipping"
  end
  if is_installed flake8
    flake8 $py_file
  else
    echo "No flake8, skipping"
  end
  if is_installed mypy
    mypy $py_file
  else
    echo "No mypy, skipping"
  end
end
