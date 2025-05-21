#!/usr/bin/awk -f

{
	# Check for occurrence of @MODULE:path
	if (match($0, /@MODULE:([a-zA-Z0-9_\/]+)/, arr)) {
		# Extract the path from the match
		path = arr[1]

		# Check if file already included
		check_cmd = "grep -Fxq \"" path "\" include.lst"
		if (system(check_cmd) == 0) {
			# Already included, skip
			$0 = substr($0, 1, RSTART-1) substr($0, RSTART+RLENGTH)
			next
		}

		# Mark as included
		system("echo \"" path "\" >> include.lst")

		# Output service info to stdout
		system("echo Attempting to include module: " path " >&2")

		# Call bash script with the path parameter
		system("bash mksub.sh "                                       \
			ENVIRON["BASH_TEMPLATE_PROJECT_PATH"] "/"             \
			ENVIRON["BASHTPL_DEFAULT_MODULE_DIR"] "/" path "/"    \
			ENVIRON["BASHTPL_DEFAULT_MODULE_FILE"])

		# Proceed to next line
		next
	}
	
	# We don't write anything to the file, only call the script.
}
