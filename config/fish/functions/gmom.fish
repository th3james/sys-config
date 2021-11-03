function gmom -d "Returns git main or master"
  if git branch --list main | grep -qE "^[\* ] main\$"
      echo "main"
  else
      echo "master"
  end
end
