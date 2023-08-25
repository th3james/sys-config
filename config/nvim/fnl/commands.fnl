(local local-tools (require :local_tools))

(vim.api.nvim_create_user_command :ShowTools
                                  (fn []
                                    (each [k v (pairs local-tools)]
                                      (print k " : " (v))))
                                  {})

(vim.api.nvim_create_user_command :CopyFileAsMarkdown
                                  (fn []
                                    (let [file_path (vim.fn.expand "%")
                                          file_lines (vim.fn.readfile file_path)
                                          escaped_file_lines []]
                                      (each [_ line (ipairs file_lines)]
                                        (let [escaped_line (string.gsub line
                                                                        "\\"
                                                                        "\\\\")]
                                          (table.insert escaped_file_lines
                                                        escaped_line)))
                                      (let [file_content (table.concat escaped_file_lines
                                                                       "\n")
                                            result (string.format "%s\n```\n%s\n```"
                                                                  file_path
                                                                  file_content)
                                            command (string.format "echo '%s' | pbcopy"
                                                                   result)]
                                        (os.execute command))))
                                  {})
