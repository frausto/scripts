#!/bin/bash

function revert() {
	local grep="$1"
	for sha in `git rev-list --all --grep $grep`
	do
		echo "reverting: $sha" 
		`git revert -n $sha`
		echo "reverted!" 
	done	
}
 
while getopts ":g:" opt; do
  case $opt in
    g)
      echo "REVERITNG COMMITS WITH: $OPTARG"
			revert $OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

