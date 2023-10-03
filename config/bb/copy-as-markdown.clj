#!/usr/bin/env bb
(require '[babashka.cli :as cli])


(let [file-path (first (:args (cli/parse-args *command-line-args*)))
      file-content (slurp file-path)]
  (println
    (str
      file-path
      "\n```\n"
      file-content
      "\n```")))
