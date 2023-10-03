(local local-tools (require :local_tools))

(vim.api.nvim_create_user_command :ShowTools
                                  (fn []
                                    (each [k v (pairs local-tools)]
                                      (print k " : " (v))))
                                  {})

(vim.api.nvim_create_user_command :CopyFileAsMarkdown
                                  (fn []
                                    (let [file_path (vim.fn.expand "%")
                                          command (string.format "copy-as-markdown.clj '%s' | pbcopy"
                                                                 file_path)]
                                      (os.execute command)))
                                  {})
