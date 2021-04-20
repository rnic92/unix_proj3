#!/bin/bash
# Nicolas Rohr
# Project 1
# Version 1.2
# 24 Feb 2021

# recursive function to search tree branches
search_node (){
  # for all files in passed location
  for file in "$1"/*
  do
    tabs=$(( tabs + 2 ))
    line="<ul>"
    line=$(printf "%*s%s" $tabs '' "$line")
    echo "$line"
    if [ -d "$file" ] # directory
    then
      if [ -r "$file" ] # readable otherwise skip
      then
        # prefix used to make a nicer looking link
        prefix=$1
        prefix+='/'

        # machine dependant code
        if [ $machine == "Mac" ]; then
          filelink=$(greadlink -f "$file")
        else
          filelink=$(readlink -f "$file")
        fi

        # replace spaces for html printing
        filelink=$(echo $filelink | sed -e 's/ /%20/g')

        # create file name for html output
        filetag=${file#"$prefix"}
        line="<li><a href="$filelink">"$filetag"</a>"
        line=$(printf "%*s%s" $tabs '' "$line")
        echo "$line"

        #recursive tree search
        search_node "$file"
        line="</li>"
        line=$(printf "%*s%s" $tabs '' "$line")
        echo "$line"
      fi

    else # else not a directory
      # code follows same as above.
      if [ -r "$file" ]; then
        prefix=$1
        prefix+='/'
        if [ $machine == "Mac" ]; then
          filelink=$(greadlink -f "$file")
        else
          filelink=$(readlink -f "$file")
        fi
        # replace all spaces with html code %20 for space
        filelink=$(echo $filelink | sed -e 's/ /%20/g')
        filetag=${file#"$prefix"}
        line="<li><a href="$filelink">"$filetag"</a></li>"
        line=$(printf "%*s%s" $(( tabs + 2 )) '' "$line")
        echo "$line"

      fi
    fi
    echo "</ul>"
    tabs=$(( tabs - 2 ))
  done
}

start_file (){
  # header info for html file
  echo "<!DOCTYPE html>"
  echo "<html>"
  echo "<body>$nl"
  echo "<h1>$1</h1>$nl"
}

end_file () {
  # tial info for html file
  echo "$nl</body>$nl</html>"
}


######################
# Creates a tree directory
# inputs 2: root of directory to create, output file name
# outputs 1: output in html format
######################
# Constants
# nl is a new line character.  tabs is number of tabs.
# both are meant for readability
#####################
Rootdir=$1
Outfile=$2
nl='
'
tabs=2
# readlink and greadlink run slightly differently on mac and linux.
# This quick check figures out the system and posts a warning if there is an error with system
# brew install coreutils to access greadlink -f.  The linux equivalent of readlink -f
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    *)          machine="UNKNOWN:${unameOut}"
esac

if [ $machine != "Linux" ] && [ $machine != "Mac" ]
then
  echo "unknown machine setup. program may not work$nl"
# elif [ $machine == "Mac" ]
# then
  # echo "$nl$nl$nl Must have coreutils installed to run correctly on Mac $nl$nl$nl"
fi

# ensure 2 arguments passed
if [ $# == 2 ]
then
  start_file "Tree with root at $Rootdir" > $Outfile
  search_node $Rootdir >> $Outfile
  end_file >> $Outfile
else
  echo "Incorrect number of arguments supplied"
fi
