#!/usr/bin/bash

if [ $# -lt 1 ]; then
  dir=`pwd`
  origDir=`pwd`
else
  dir=$1
  origDir=`pwd`
  echo 
  echo "Not in current dir, change into $dir and will be back after finish"
  echo 
  cd $dir
fi

sumuptodate=0
sumupdated=0
declare -a listupdated
counter=0

for f in "$dir"/*; do
  echo ">> Checking $f ... "
  if [ -d "$f" ]; then
    if [ -d "$f/.git" ]; then
      cd "$f"
      OUTPUT="$(git pull)"
      repo=$(basename $f)
      if [ "${OUTPUT}" == "Already up to date." ]; then
        ((sumuptodate++))
        echo "$repo is up-to-date, $sumuptodate repo(s) up-to-date until now"
      else
        ((sumupdated++))
        echo "${OUTPUT}"
        listupdated[counter]=$repo
      fi
    else
      echo "$f is not a git repository, aborting"
    fi
  else
    echo "skip $f - not a directory"
  fi
  echo ">> Finish checking $repo"
  ((counter++))
done

echo
echo "Report"
echo "---------------------------------------------"
echo "Sum of up to date repo(s) = $sumuptodate" 
echo "Sum of updated repo(s) = $sumupdated"
echo "List of updated repo(s) = "
for i in "${listupdated[@]}"
do
    echo "    - $i"
done
echo
echo "Back to original dir $origDir"
cd $origDir

