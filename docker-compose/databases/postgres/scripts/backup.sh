#!/bin/bash

set -e

DATE=$(date +%F)
BASE_DIR="/backups/$DATE"

mkdir -p "$BASE_DIR/basebackup"
mkdir -p "$BASE_DIR/dump"

export PGPASSWORD=$(cat /run/secrets/pg_password)

pg_basebackup \
  -U postgres \
  -D "$BASE_DIR/basebackup" \
  -Ft -Xs -P -z

pg_dumpall \
  -U postgres > "$BASE_DIR/dump/full.sql"

unset PGPASSWORD