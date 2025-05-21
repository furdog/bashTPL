#!/usr/bin/awk -f

# This macro replaces all occurrences of @INCLUDE:file with the contents of the file.
{
	while (match($0, /@INCLUDE:[^ \t\n]+/)) {
		include_directive = substr($0, RSTART, RLENGTH)
		filename = substr(include_directive, 10) # remove "@INCLUDE:"

		# If file doesn't exist
		#if (system("stat " filename " >/dev/null 2>&1") == 0) {
		#	break
		#}

		system("echo Attempting to include file: " filename " >&2")

		# Read the contents of the file    
		system("cat " ENVIRON["BASH_TEMPLATE_PROJECT_PATH"] "/"       \
			filename)

		# Replace the directive with an empty line
		$0 = substr($0, 1, RSTART-1) substr($0, RSTART+RLENGTH)
	}

	print
}
