#!/bin/bash
set -e

sleep 20
npm run migratedb
node run.js

exit 0