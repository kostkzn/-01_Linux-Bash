#!/bin/bash
SCRIPT=$( basename "$0" )

def_help() {
   echo
   echo "Backup script usage:"
   echo 
   echo "    "$SCRIPT [SOURCE DIR PATH] [DESTINATION DIR PATH]""
   echo 
   echo "In case of adding new or deleting old files,"
   echo "the script adds entry to the log file indicating"
   echo "the time, type of operation and file name."  
   echo "Log file located in [destination_dir_path/log]"
   echo
}

def_backup() {
  local log="$2/log" 
  local source_files=$(ls -AR $1 | awk '/:$/&&f{s=$0;f=0} /:$/&&!f{sub(/:$/,"");s=$0;f=1;next}NF&&f{ print s"/"$0 }' | sed "s+$1/++g")
  local destin_files=$(ls -AR $2 | awk '/:$/&&f{s=$0;f=0} /:$/&&!f{sub(/:$/,"");s=$0;f=1;next}NF&&f{ print s"/"$0 }' | sed "s+$2/++g")

# Cheking directory hierarchy and for non-actual files

for file in $destin_files; do
    stamp=$(date '+%F %T |')
	if [[ $file != "log" ]]; then
      if [[ -z $(echo $source_files | grep "[ ]$file")  ]]; then  # if empty string
		rm -fr "$2/$file" && echo "$stamp   deleted | $file" >> $log
      fi
	  
	  if [[ -f $1/$file && -d $2/$file ]]; then 
		rm -fr "$2/$file" && echo "$stamp d deleted | $file" >> $log
      fi
    fi
  done

# Making new source subdirs in destination folder
	
for file in $source_files; do
# echo "$file"
	stamp=$(date '+%F %T |')
	if [[ -d $1/$file ]]; then 
	  if [[ -d $2/$file ]]; then
	    continue
      else
		mkdir "$2/$file" && echo "$stamp dir added | $file" >> $log
	  fi
	fi
  done

# Copying new files

for file in $source_files; do
  local stamp=$(date '+%F %T |')
	if [[ -f $2/$file ]]; then  # if FILE exists and is a regular file.
      cp -v --update "$1/$file" "$2/$file" 2>> $log | grep "\->" &>/dev/null && echo "$stamp up-2-date | $file" >> $log
    elif [[ -d $1/$file ]]; then 
	  continue
	else
      cp "$1/$file" "$2/$file" 2>> $log && echo "$stamp     added | $file" >> $log
    fi
done

echo "Done!"

}

source=$(echo $1 | sed "s+/$++g")
dest=$(echo $2 | sed "s+/$++g")

# Checking script options entry

if [[ $# -le 1 ]]; then
  def_help
fi

if [[ $# -eq 2 ]]; then
  ls $1 > /dev/null 2>&1
  if [[ $? -eq 0 ]]; then
    ls $2 > /dev/null  2>&1
    if [[ $? -eq 0 ]]; then
      def_backup $source $dest
    else
	  echo
      echo "Invalid DESTINATION directory!"
	  def_help
    fi
  else
	echo
    echo "Invalid SOURCE directory!"
	def_help
  fi
fi
