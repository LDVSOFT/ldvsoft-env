#!/bin/bash

if [ ! -f /etc/debian_chroot ] ; then
	return 1
fi
echo -n "${__prompt_clr_standout}[chroot $(< /etc/debian_chroot)]"
