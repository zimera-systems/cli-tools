#!/usr/bin/fish

set origdir (pwd)
set sumuptodate 0
set sumupdated 0
set listupdated

echo 

if test -n "$argv"
  set startdir (string sub -s 1 -l 1 $argv)
  if test $startdir != "/"
    and test $startdir != "~"
    echo
    echo "+---------------------------------"
    echo "| >> Using relative dir $argv"
    echo "+---------------------------------"
    echo
    set dir (string join "" $origdir "/" $argv)
  else
    echo
    echo "+---------------------------------"
    echo "| >> Using absolut dir $argv"
    echo "+---------------------------------"
    echo
    set dir $argv
  end
else
  set dir $origdir
end

echo ">> Processing $dir <<"
echo

for f in "$dir"/*
  echo
  echo "+-----------------------------------------"
	echo "| Check $f"
  echo "+-----------------------------------------"
	if test -d "$f"
		if test -d "$f/.git"
			cd "$f"
            set oldIFS "$IFS"
            set IFS ""
            set OUTPUT (git pull)
            set repo (basename $f)
            if [ "$OUTPUT" = "Already up to date." ]
                set sumuptodate (math $sumuptodate + 1)
                echo "=> $repo is up-to-date"
            else
                set sumupdated (math $sumupdated + 1)
                echo $OUTPUT
                set listupdated $listupdated $repo
            end
            set IFS "$oldIFS"
		else
      echo
      echo "+-------------------------------------------"
			echo "| >> $f is not a git repository, aborting"
      echo "+-------------------------------------------"
      echo
    end
	else
		echo "skip $f - not a directory"
    end
    echo ">> Finish checking $repo"
end

echo
echo "+--------------------------------------------"
echo "| Report"
echo "+--------------------------------------------"
echo "| Sum of up to date repo(s) = $sumuptodate" 
echo "| Sum of updated repo(s) = $sumupdated"
echo "| List of updated repo(s) = "
for i in $listupdated
    echo "| - $i"
end
echo "+--------------------------------------------"
echo
