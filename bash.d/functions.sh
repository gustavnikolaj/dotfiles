function zonefile() {
    if [ $1 ]
    then
        dig +nocmd +noall +answer axfr @ns01.one.com "$1" | grep -vE "(SOA|NS)" | pbcopy
        echo "Copied to clipboard"
    else
        echo "Invalid domain."
    fi
}

function onegit() {
    git clone git.one.com:/git/${1}.git $2
}

function p() {
    if [ -z $1 ]; then
        cd ~/Projects
    else
        local projects="`find ~/Projects/ -mindepth 1 -maxdepth 1 -type d -exec basename {} \;`"
        for arg in $@
        do
            local projects="`echo "$projects" | grep "$arg"`"
        done
        cd ~/Projects/`echo "$projects" | head -n 1`
    fi
}


# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$@"
}

# Emulate OSX's open on Linux
if [ `uname` == 'Linux' ] ; then
    function open() {
        if [ $* > 0 ] ; then
            xdg-open $@ &>/dev/null
        else
            xdg-open . &>/dev/null
        fi
    }
fi

# Use Git’s colored diff when available
hash git &>/dev/null
if [ $? -eq 0 ]; then
	function diff() {
		git diff --no-index --color-words "$@"
	}
fi

# Create a data URL from a file
function dataurl() {
	local mimeType=$(file --mime-type "$1" | cut -d ' ' -f2)
	if [[ $mimeType == text/* ]]; then
		mimeType="${mimeType};charset=utf-8"
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
	local port="${1:-8000}"
	sleep 1 && open "http://localhost:${port}/" &
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

# Start a PHP server from a directory, optionally specifying the port
# (Requires PHP 5.4.0+.)
function phpserver() {
	local port="${1:-4000}"
	local ip=$(ipconfig getifaddr en1)
	sleep 1 && open "http://${ip}:${port}/" &
	php -S "${ip}:${port}"
}

# Get gzipped file size
function gz() {
	echo "orig size (bytes): "
	cat "$1" | wc -c
	echo "gzipped size (bytes): "
	gzip -c "$1" | wc -c
}

# Test if HTTP compression (RFC 2616 + SDCH) is enabled for a given URL.
# Send a fake UA string for sites that sniff it instead of using the Accept-Encoding header. (Looking at you, ajax.googleapis.com!)
function httpcompression() {
	encoding="$(curl -LIs -H 'User-Agent: Mozilla/5 Gecko' -H 'Accept-Encoding: gzip,deflate,compress,sdch' "$1" | grep '^Content-Encoding:')" && echo "$1 is encoded using ${encoding#* }" || echo "$1 is not using any encoding"
}

# Gzip-enabled `curl`
function gurl() {
	curl -sH "Accept-Encoding: gzip" "$@" | gunzip
}

# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
function json() {
	if [ -t 0 ]; then # argument
		python -mjson.tool <<< "$*" | pygmentize -l javascript
	else # pipe
		python -mjson.tool | pygmentize -l javascript
	fi
}

# All the dig info
function digga() {
	dig +nocmd "$1" any +multiline +noall +answer
}

# Escape UTF-8 characters into their 3-byte format
function escape() {
	printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
	echo # newline
}

# Decode \x{ABCD}-style Unicode escape sequences
function unidecode() {
	perl -e "binmode(STDOUT, ':utf8'); print \"$@\""
	echo # newline
}

# Get a character’s Unicode code point
function codepoint() {
	perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))"
	echo # newline
}

# Add note to Notes.app (OS X 10.8)
# Usage: `note 'foo'` or `echo 'foo' | note`
function note() {
	local text
	if [ -t 0 ]; then # argument
		text="$1"
	else # pipe
		text=$(cat)
	fi
	body=$(echo "$text" | sed -E 's|$|<br>|g')
	osascript >/dev/null <<EOF
tell application "Notes"
	tell account "iCloud"
		tell folder "Notes"
			make new note with properties {name:"$text", body:"$body"}
		end tell
	end tell
end tell
EOF
}
