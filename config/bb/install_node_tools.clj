#!/usr/bin/env bb
(ns install-node-tools
  (:require
    [babashka.process :refer [shell]]))


(defn npm-installed?
  []
  (zero? (:exit (shell "which npm"))))


(defn install-packages
  [package-names]
  (let [result (shell (str "npm install -g " package-names))]
    (if (zero? (:exit result))
      (println (str "Successfully installed " package-names))
      (do
        (println "Error installing package:" (:err result))
        (println "Please check your npm setup.")))))


(defn main
  []
  (if (npm-installed?)
    (install-packages "eslint_d typescript-language-server")
    (println "npm not available.")))


(main)
