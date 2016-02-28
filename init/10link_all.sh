#!/bin/bash

# links all files in the source directory with the corresponding files in the root directory.


linkAll() {
  while [ "$1" ]; do
    TARGET=$(echo $1 | sed "s@$SOURCE_DIR@@")
    if [ -d "$1" ]; then
      if [ -n "$TARGET" ]; then
        mkdir -p "$TARGET"
      fi
    else
      $(ln -s -f $1 ${TARGET})
    fi
    shift
  done
}


SOURCE_DIR=$1
if [ -z "${SOURCE_DIR}" ]; then
  SOURCE_DIR="${AINIT}/fs"
fi

if [ -d ${SOURCE_DIR} ]; then
  linkAll $(find ${SOURCE_DIR})
  echo "linking was finished successfully."
fi