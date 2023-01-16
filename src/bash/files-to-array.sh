#!/bin/bash

# create an array with all the filer/dir inside ~/myDir
arr=(~/dev/github/corbtastik/merlin/*)

# iterate through array using a counter
for ((i=0; i<10; i++)); do
    echo "- name: \"pacnw-3${i}\""
    echo "  src: \"https://storage.googleapis.com/corbs-foto/pacnw/pacnw-3${i}.jpg\""
    echo "  description: \"Pac NW 3${i}\""
done

for ((i=0; i<10; i++)); do
    echo "- name: \"pacnw-4${i}\""
    echo "  src: \"https://storage.googleapis.com/corbs-foto/pacnw/pacnw-4${i}.jpg\""
    echo "  description: \"Pac NW 4${i}\""
done

for ((i=0; i<10; i++)); do
    echo "- name: \"pacnw-5${i}\""
    echo "  src: \"https://storage.googleapis.com/corbs-foto/pacnw/pacnw-5${i}.jpg\""
    echo "  description: \"Pac NW 5${i}\""
done

for ((i=0; i<10; i++)); do
    echo "- name: \"pacnw-6${i}\""
    echo "  src: \"https://storage.googleapis.com/corbs-foto/pacnw/pacnw-6${i}.jpg\""
    echo "  description: \"Pac NW 6${i}\""
done

for ((i=0; i<10; i++)); do
    echo "- name: \"pacnw-7${i}\""
    echo "  src: \"https://storage.googleapis.com/corbs-foto/pacnw/pacnw-7${i}.jpg\""
    echo "  description: \"Pac NW 7${i}\""
done

