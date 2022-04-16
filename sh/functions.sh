#!/bin/bash

# Pass a .pls (playlist) file to this function and it'll copy the contents
# out of multiple dirs, add the files here and prepend numbers to the names
function mover() {
  # Print only lines with "File" and remove any
  # special chars and bits we don't need...
  MOVER_SONGPATHS=$(awk '/File/ { print $0 }' $1 \
    | sed 's/^File[^/]*=file:\/\///' \
    | sed 's/%20/ /g' \
    | sed 's/%5B/[/g' \
    | sed 's/%5D/]/g'
  )

  # Create a string of commands that look like:
  # 'cp "<full-path>" "<number> - <file-name>"; cp "<full-path>" "<number> - <file-name>"; [...]'
  MOVER_CP_COMMAND=$(echo "$MOVER_SONGPATHS" | awk '{FS = "/"; print "cp \"" $0 "\" \"" NR " - " $NF "\";"}')

  # Then evaluate the output using `bash -c "{}"`
  bash -c "$MOVER_CP_COMMAND"
}
