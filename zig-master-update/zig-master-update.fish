#!/usr/bin/fish

set masterdir "/home/bpdp/master/zig"
set prefixdir "/home/bpdp/software/zig-dev-tools"

cd $masterdir
rm index.json
echo
echo "Downloding version information..."
echo
wget https://ziglang.org/download/index.json
set currver (jq -r '.master.version' index.json)
set mastertarget (jq -r '.master."x86_64-linux".tarball' index.json)
echo "Current version: $currver"
echo "URL to tarball: $mastertarget"

set alreadydownloaded (ls -la | grep $currver)

if test -z $alreadydownloaded
  echo
  echo "Deleting old master (if exist)"
  echo
  for oldf in "$masterdir"/*
    set oldmaster (echo $oldf | grep "+")
    if test -z $oldmaster
      echo "$oldf is not old master, proceed to next"
    else
      echo "Deleting $oldf ..."
      rm $oldf
    end
  end
  echo "Downloading current master - version $currver"
  echo
  wget $mastertarget
  echo
else
  echo
  echo "Master has already been downloaded"
  echo
end

if test -d "$prefixdir/zig-linux-x86_64-$currver"
  echo "Current master has been installed"
  echo "Finish without installing master"
  echo 
else
  for f in "$prefixdir"/*
    set evalfile (echo $f | grep "+")
    if test -z $evalfile
      echo "$f is not old master - not deleted"
      echo
    else
      echo "old master exist - $f - deleted"
      rm -rf $f
    end
  end
  echo "Extracting and installing"
  echo
  cd $prefixdir
  rm zig-master
  tar -xvf "$masterdir/zig-linux-x86_64-$currver.tar.xz"
  ln -s zig-linux-x86_64-$currver zig-master
  echo "Finish."
end
