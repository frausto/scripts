#!/bin/bash

function mk_directory() {
	local option=`echo $1 | sed 's/[^/]*$//'`
	`mkdir -p $option`
}

mk_directory $1
touch $1
