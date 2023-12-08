(fn trim_whitespace [str]
  "Remove whitespace from the beginning and end of a string."
  (str:gsub "^%s*(.-)%s*$" "%1"))

(fn print_table [tbl]
  "Print the contents of a table to the console."
  (each [k v (pairs tbl)]
    (print k ": " v)))

{: trim_whitespace : print_table}
