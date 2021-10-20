function is_installed -a executable_name
  set -l installed (which executable_name)
  string length -q -- $installed
end
