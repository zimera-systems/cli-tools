# zig-master-update.fish

This script is intended to update [Zig](https://ziglang.org) binary master version. Currently it
will update x86_64 Linux version only. I use this script to automatically update binary master
installation since Zig master is updated on a daily basis and I would like to live in the bleeding
edge, here is the script to do that automatically so that I don't need to do that boring repetitive task!.

## Prerequisites

1.  [Fish](https://fishshell.com).
2.  x86_64 Linux - any Linux distro.
3.  [jq - JSON command line processor](https://stedolan.github.io/jq/).
4.  [xz-utils](https://tukaani.org/xz/)
4.  Some utilities - usually installed by default in any Linux distro: `wget`, `grep`, and `tar`.

## How to setup 

Create a shell script which will be used to source the environment variables. Make note of this
directory. Later on, `/home/bpdp/software/zig-dev-tools` will be used as `prefixdir` in the script.
Let's say, put this content inside `$HOME/env/fish/zig-master`.

```
set -x PATH $PATH /home/bpdp/software/zig-dev-tools/zig-master
```

Put `zig-master-update.fish` inside `$HOME/bin` then chmod:

```
chmod +x $HOME/bin/zig-master-update.fish
```

Make some adjustments:

```
set masterdir "/home/bpdp/master/zig"
set prefixdir "/home/bpdp/software/zig-dev-tools"
```

`masterdir` is any directory which can be used to store all Zig binary files while `prefixdir` is any directory where we will install Zig. Change them to suit your environment. Those directories should exist prior to run
`zig-master-update.fish`.


Whenever you want to update Zig master binary, just run the script:

```
$ zig-master-update.fish
```

That's it!

## Run update

Anytime you want to update Zig master, just do this:

```
$ zig-master-update.fish
```

## Using Zig binary master

Anytime you want to use Zig master, just do this:

```
$ source ~/env/fish/zig/zig-master
```

Then you can use Zig as usual:

```
$ zig version
0.6.0+f23987db7
```


