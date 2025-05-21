#!/bin/bash

if [ -z "$1" ]; then
	echo "Error: input file is not specified"
	exit 1
fi

if [ ! -f "$1" ]; then
	echo "File $1 does not exist"
	exit 1
fi

export BASH_TEMPLATE_PROJECT_PATH=${PWD}
cd "$(dirname "$0")" || exit 1  # Go to script dir
export BASH_TEMPLATE_ROOT_PATH=${PWD}

if [ "$2" != "--continue" ]; then
	mkdir -p  ${BASH_TEMPLATE_PROJECT_PATH}/build
	rm    -rf ${BASH_TEMPLATE_PROJECT_PATH}/build/sections 2> /dev/null
	mkdir -p  ${BASH_TEMPLATE_PROJECT_PATH}/build/sections
fi

#Попередньо виконаємо необхідні операції до користувацького файлу
./mksub.sh "$1"
