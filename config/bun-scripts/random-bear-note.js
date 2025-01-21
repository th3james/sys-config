#!/usr/bin/env bun

import { Database } from 'bun:sqlite';
import { spawn } from 'child_process';

const DB_PATH = "/Users/jamcox01/Library/Group Containers/9K33E3U3T4.net.shinyfrog.bear/Application Data/database.sqlite";

function getRandomNoteId(db) {
  const query = `
    SELECT ZUNIQUEIDENTIFIER 
    FROM zsfnote 
    WHERE ztrashed == 0 AND zarchived == 0 
    ORDER BY RANDOM() 
    LIMIT 1;
  `;
  
  const result = db.query(query).get();
  return result?.ZUNIQUEIDENTIFIER;
}

function buildNoteUri(noteId) {
  return `bear://x-callback-url/open-note?id=${noteId}`;
}

function openNote(noteId) {
  const uri = buildNoteUri(noteId);
  spawn('open', [uri]);
}

function listNoteIds(db) {
  const query = `
    SELECT ZUNIQUEIDENTIFIER 
    FROM zsfnote 
    WHERE ztrashed == 0 AND zarchived == 0;
  `;
  
  return db.query(query).all().map(row => row.ZUNIQUEIDENTIFIER);
}

// Main execution
try {
  const db = new Database(DB_PATH);
  const randomNoteId = getRandomNoteId(db);
  
  if (!randomNoteId) {
    console.error("No notes found in Bear database");
    process.exit(1);
  }
  
  openNote(randomNoteId);
  db.close();
} catch (error) {
  console.error("Error accessing Bear database:", error);
  process.exit(1);
}
