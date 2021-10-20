function get_asdf_lib_path
  if on_apple_silicon
    echo "/opt/homebrew/opt"
  else
    echo "/usr/local/opt"
  end
end
