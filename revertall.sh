#!/bin/bash

function waitforfix {
	while read input; do
		if [ "${input}" == "revertall --continue" ]
		then
			break
		fi
		$input
	done
}

function revert() {
	local grep="$1"
	for sha in `git rev-list --all --grep $grep`
	do
		echo "reverting: $sha" 
		local result=`git revert --no-edit $sha 2>&1`
		if echo -e $result | grep -E '(error|fatal):'
		then
			git st
			echo -e "\nRevert Failed: could not revert $sha"
			echo "Please resolve conflicts, commit changes and type 'revertall --continue' to continue reverting"
			waitforfix
		else
			echo "reverted!" 
		fi
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

