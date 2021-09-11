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
