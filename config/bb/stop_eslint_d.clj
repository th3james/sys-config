#!/usr/bin/env bb
(ns stop-eslint-d
  (:require
    [babashka.process :as process]
    [clojure.string :as str]))


(defn print-processes
  [process-name]
  (let [command (str "procs " process-name)
        {:keys [out err exit]} (process/shell command {:out :string})]
    (if (zero? exit)
      (println out)
      (println "Error listing processes:" err))))


(defn get-process-ids
  [process-name]
  (let [command (str "procs --color disable --no-header --only pid " process-name)
        {:keys [out err exit]} (process/shell command {:out :string})]
    (if (zero? exit)
      (map str/trim (str/split out #"\n"))
      (println "Error listing processes:" err))))


(str/join  " " (get-process-ids 'eslint'))


(defn confirm
  [prompt]
  (println (str prompt " (y/n)"))
  (let [response (.toLowerCase (read-line))]
    (cond
      (= "y" response) true
      (= "n" response) false
      :else (do
              (println "Please enter 'y' or 'n'.")
              (recur prompt)))))


(let [process-name "eslint_d"
      kill-cmd (str "kill " (str/join  " " (get-process-ids process-name)))]
  (print-processes process-name)
  (if (confirm (str "Do you want to '" kill-cmd "'?"))
    (process/shell kill-cmd)
    (println "nvm then")))
