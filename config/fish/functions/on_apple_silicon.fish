function on_apple_silicon
  set -l system_arch_name (uname -m)
  if string match -q "x86_64" $system_arch_name 
    return 1
  else
    return 0
  end
end
