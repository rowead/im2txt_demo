#!/usr/bin/env bash
while [ $# -gt 0 ]; do
  case "$1" in
    --file=*)
      FILE="${1#*=}"
      ;;
    --url=*)
      URL="${1#*=}"
      ;;
    *)
      printf "***************************\n"
      printf "* Error: Invalid argument.*\n"
      printf "***************************\n"
      exit 1
  esac
  shift
done

if [ ! -z "$FILE" ]; then
  hash=$(printf '%s' $FILE | md5sum | cut -d ' ' -f 1)
  cp $FILE imgs/tmp/${hash}
fi

if [ ! -z "$URL" ]; then
  hash=$(printf '%s' $URL | md5sum | cut -d ' ' -f 1)
  curl -s $URL  > imgs/tmp/${hash}
fi
docker run -i --rm=true -v $(pwd):/root --name=im2txt_demo im2txt_demo ./process_image.sh ${hash}