#!/bin/bash

g++olymp() {
	local file="$1"
	shift
	local ext_opts="$@"
	local name=${file%.cpp}
	(
		set -vx
		g++ -std=gnu++14 -DDEBUG -DHOME -O2 -Wall -Wextra -Wno-unused-result $ext_opts "$name.cpp" -o "$name"
	)
}

g++olymp-loop() {
	local file="$1"
	shift
	local ext_opts="$@"
	local name=${file%.cpp}

	true
	while (( $? == 0 )) ; do
		if [[ "$name.cpp" -nt "$name" ]] ; then
			g++olymp "$name" $ext_opts
		fi
		if (( $? != 0 )) ; then
			return 1
		fi
		./"$name" && view "$name.out"
	done
	true
}
