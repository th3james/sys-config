(local local-tools (require :local_tools))

(vim.api.nvim_create_user_command :ShowTools
                                  (fn []
                                    (each [k v (pairs local-tools)]
                                      (print k " : " (v))))
                                  {})
