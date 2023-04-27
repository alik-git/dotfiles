### Functions ###

# Go up x number of directories
u(){
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
    do
      d=$d/..
    done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}
	
# Search command line history for x
hs(){
    search_term=$1
    history | grep $search_term
}

# Start thefuck
# eval $(thefuck --alias)


# Open a text file with gedit in the background, independent of the terminal session
fopen(){
    if [ -z "$1" ]; then
        echo "Usage: fopen /path/to/file.txt"
        return 1
    fi
    nohup gedit "$1" > /dev/null 2>&1 &
}

