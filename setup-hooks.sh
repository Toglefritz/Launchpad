#!/bin/sh
# Script to set up Git hooks

# Define the source and destination directories
HOOKS_DIR="githooks"
GIT_HOOKS_DIR=".git/hooks"

# Copy all hooks from the source directory to the destination directory
cp -r $HOOKS_DIR/* $GIT_HOOKS_DIR/

echo "Git hooks have been set up."