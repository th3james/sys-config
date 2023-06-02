(fn trim_whitespace [str]
  "Remove whitespace from the beginning and end of a string."
  (str:gsub "^%s*(.-)%s*$" "%1"))

{: trim_whitespace}
