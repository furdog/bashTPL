#!/bin/bash

cd ${BASH_TEMPLATE_ROOT_PATH}

# Recursively insert other modules, if needed.
awk/MODULE.awk "$1"

# Insert section at the beginning of the default file.
if [ ! -z "${BASHTPL_DEFAULT_SECTION_FILE+x}" ]; then
	echo "@SECTION:"${BASHTPL_DEFAULT_SECTION_FILE} >                     \
	     ${BASH_TEMPLATE_PROJECT_PATH}/build/build.tmp
fi

# Perform necessary macro substitutions in the module file.
awk/INCLUDE.awk "$1" >> ${BASH_TEMPLATE_PROJECT_PATH}/build/build.tmp

awk/ENV.awk -i inplace ${BASH_TEMPLATE_PROJECT_PATH}/build/build.tmp

# Generate section files for the module file.
awk/SECTION.awk -v sections_dir=${BASH_TEMPLATE_PROJECT_PATH}/build/sections  \
				${BASH_TEMPLATE_PROJECT_PATH}/build/build.tmp

# Remove unnecessary/residual entries.
sed -i '/@MODULE:/d' ${BASH_TEMPLATE_PROJECT_PATH}/build/build.tmp
sed -i '/@SECTION:/d' ${BASH_TEMPLATE_PROJECT_PATH}/build/build.tmp
