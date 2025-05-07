<Python>
* Assume Python package management is a trashfire and proceed with paranoia about environment isolation.
** Never depend on global installations
** pin all versions of libraries used
* Always use astral-sh/uv for package management.
** Use `uv run python` to run python commands
** Use `uv run main.py` to run python code
** Use `uvx toolname` to run python tools
** check pyproject.toml or uv.lock to identify tool versions
* Use ruff for linting and formatting:
** `uvx ruff check some_file.py` - print errors
** `uvx ruff format some_file.py` - fix formatting
* Use type hinting judiciously - always annotate function signatures which use primitive types, more complex types can be elided
** Use basedpyright for type checking (run it with `uv run basedpyright some_file.py`)
</Python>
