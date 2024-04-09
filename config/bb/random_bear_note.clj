#!/usr/bin/env bb
(ns random-bear-note
  (:require
    [babashka.pods :as pods]
    [babashka.process :refer [shell]]))


(pods/load-pod 'org.babashka/go-sqlite3 "0.1.0")
(require '[pod.babashka.go-sqlite3 :as sqlite])


(def db-name
  "/Users/jamcox01/Library/Group Containers/9K33E3U3T4.net.shinyfrog.bear/Application Data/database.sqlite")


(defn random-note-id
  []
  (first (map :ZUNIQUEIDENTIFIER
              (sqlite/query db-name [(str "SELECT ZUNIQUEIDENTIFIER "
                                          "FROM zsfnote "
                                          "WHERE ztrashed == 0 AND zarchived == 0 "
                                          "ORDER BY RANDOM() LIMIT 1 "
                                          ";")]))))


(defn build-note-uri
  [note-id]
  (str "bear://x-callback-url/open-note?id=" note-id))


(defn open-note
  [note-id]
  (shell "open" (build-note-uri note-id)))


(defn list-note-ids
  []
  (map :ZUNIQUEIDENTIFIER
       (sqlite/query db-name ["SELECT ZUNIQUEIDENTIFIER FROM zsfnote WHERE ztrashed == 0 AND zarchived == 0;"])))


;; Run the script
(open-note (random-note-id))
