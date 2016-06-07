#!/bin/bash

#WIP
return 1

if ! bzr info >/dev/null 2>/dev/null ; then
	return 1
fi

echo -n "[Bazaar]${__prompt_sep}${__prompt_reset}TODO"
