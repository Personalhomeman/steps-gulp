#!/usr/bin/env bash

function debug_echo {
	local msg="$1"
	if [[ "${is_debug}" == "yes" ]] ; then
		echo "${msg}"
	fi
}

debug_echo
debug_echo "==> Start"

if [ ! -z "${workdir}" ] ; then
  debug_echo "==> Switching to working directory: ${workdir}"
  cd "${workdir}"
  if [ $? -ne 0 ] ; then
    echo " [!] Failed to switch to working directory: ${workdir}"
    exit 1
  fi
fi

command -v gulp >/dev/null 2>&1 || {
    echo "===> gulp is not installed, installing now..."
     npm install -g gulp

     if [ $? -ge 1 ]; then
        echo "Failed to install gulp using npm"
        exit 1;
     fi
}

debug_echo "command: $command"
debug_echo "args: $args"
debug_echo "is_debug: $is_debug"

debug_echo "===> Running 'gulp $command $args'"

gulp ${command} ${args}
