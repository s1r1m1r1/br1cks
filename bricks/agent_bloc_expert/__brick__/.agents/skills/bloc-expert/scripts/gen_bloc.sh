#!/bin/bash

# Скрипт для генерации блока через bloc_9
# Использование: ./gen_bloc.sh <name> [output_dir]

NAME=$1
OUTPUT_DIR=${2:-.}

if [ -z "$NAME" ]; then
  echo "Usage: ./gen_bloc.sh <name> [output_dir]"
  exit 1
fi

echo "Generating bloc $NAME in $OUTPUT_DIR..."

mason make bloc_9 --name "$NAME" -o "$OUTPUT_DIR"

echo "Running build_runner..."
dart run build_runner build --delete-conflicting-outputs
