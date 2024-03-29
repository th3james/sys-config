(local utils (require :utils))
(local logging (require :logging))

(fn get-npx-path [executable-name]
  "Find the path of a local npm tool using npx."
  (let [npx-path (vim.fn.system (.. "npx which " executable-name))]
    (if (= npx-path "")
        (do
          (logging.log-warning (.. "Could not find " executable-name
                                   " in npx, falling back to global"))
          executable-name)
        (utils.trim_whitespace npx-path))))

(fn get-venv-path [executable-name]
  "Find the path of a local python tool using veex."
  (let [executable-path (vim.fn.system (.. "veex which " executable-name))]
    (if (= executable-path "")
        (do
          (logging.log-warning (.. "Could not find " executable-name
                                   " in virtual environment, will try system path"))
          executable-name)
        (utils.trim_whitespace executable-path))))

{:get_npx_path get-npx-path :get_venv_path get-venv-path}
