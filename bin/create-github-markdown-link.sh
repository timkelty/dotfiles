#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create GitHub Markdown Link
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔗
# @raycast.argument1 { "type": "text", "placeholder": "Github Issues Link…" }

# Documentation:
# @raycast.author Tim Kelty
# @raycast.authorURL https://github.com/timkelty

#!/bin/bash

url="${1}"
issue="$(echo $(basename $url) | sed 's/^\([0-9]*\).*/\1/')"

# Filter out potential hash/query string
issue=${issue//[[:alpha:]]/X}

if ! [[ $url == http* ]] || ! [ "$issue" -eq "$issue" ] 2> /dev/null
then
    echo "Invalid URL" >&2; exit 1
fi

link="[#${issue}](${url})"

echo "${link}" | pbcopy
echo "Markdown link copied to clipboard."
