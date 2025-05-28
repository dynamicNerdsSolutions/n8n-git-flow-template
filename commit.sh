#!/bin/bash
## Parameters are:
# -m: Commit message
# -p: Push to remote repository (default: false)

#get parameters by name
message=""
push=false

while [ $# -gt 0 ]; do
  case "$1" in
    --message*|-m*)
      if [[ "$1" != *=* ]]; then shift; fi # Value is next arg if no `=`
      message="${1#*=}"
      ;;
    --push*|-p*)
      if [[ "$1" != *=* ]]; then shift; fi
      push="${1#*=}"
      ;;
    --help|-h)
      printf "Usage: $0 -m \"Commit message\" -p \"Push to remote repository\"\n"
      exit 0
      ;;
    *)
      >&2 printf "Error: Invalid argument\n"
      exit 1
      ;;
  esac
  shift
done

#enforce commit message
if [ -z "$message" ]; then
    echo "Commit message is empty, please provide a message with -m parameter"
    exit 1
fi

source .env
docker exec -it $DOCKER_CONTAINER_NAME n8n export:workflow --backup --output=./files/backups


git add ./files/backups
git commit -m "$message"

if [ "$push" = true ]; then
    git push
fi
