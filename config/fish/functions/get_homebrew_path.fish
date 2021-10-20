function get_homebrew_path
  if on_apple_silicon
    echo "/opt/homebrew/bin"
  else
    echo "/usr/local/sbin"
  end
end
