#!/usr/bin/awk -f

# This script extracts the contents of each section into separate files,
# appending to them if sections are repeated

# Regular expression to detect the beginning of a section
/^@SECTION:/ {
	# Extract the section name
	section_name = substr($0, 10)
	next
}

# If the current line is not the beginning of a new section
{
	# If there is an active section, append the line to the corresponding file
	if (section_name) {
		print $0 >> sections_dir "/" section_name
	}
}
