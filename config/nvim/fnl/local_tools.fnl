(local find_local (require :find_local))

(fn eslint []
  (find_local.get_npx_path :eslint))

(fn black []
  (find_local.get_venv_path :black))

(fn mypy []
  (find_local.get_venv_path :mypy))

{: eslint : black : mypy}
