(fn log-warning [msg]
  (vim.notify (.. "[th3james config] " msg) vim.log.levels.WARN))

{: log-warning}
