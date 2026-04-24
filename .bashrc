# TOR Traffic curl
alias bcurl='proxychains4 curl -sSL -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8" -H "Accept-Language: en-US,en;q=0.9" -H "Accept-Encoding: br, gzip, deflate" -H "Connection: keep-alive" -H "Upgrade-Insecure-Requests: 1" -H "Sec-Fetch-Site: none" -H "Sec-Fetch-Mode: navigate" -H "Sec-Fetch-User: ?1" -H "Sec-Fetch-Dest: document" --compressed'

# Backs up a file by copying to a <filename>.bak (Usage: Bak <filename>)
bak() {
    # Assign arguments to readable variables
    local FILE="$1"
    local DEST="${2:-.}" # Defaults to '.' if the second argument is missing

    # Check if the file exists before trying to copy
    if [[ -f "$FILE" ]]; then
        # Extract just the filename if a path was provided in $1
        local FILENAME=$(basename "$FILE")
        cp "$FILE" "$DEST/$FILENAME.bak"
        echo "Created: $DEST/$FILENAME.bak"
    else
        echo "Error: File '$FILE' not found."
        return 1
    fi
}


# Splits a pdf into chunks
pdfsplit() {
    # Usage check: need at least 3 args (pages, 1+ inputs, 1 output)
    if [ "$#" -lt 3 ]; then
        echo "Usage: pdfsplit <pages_per_file> <input_file(s)> <output_directory_or_path>"
        return 1
    fi

    local pages_per_split=$1
    shift # Remove the page count from the argument list

    # Extract the last argument as the output destination
    # This works even if wildcards expanded the middle arguments
    local args=("$@")
    local output_dest="${args[${#args[@]}-1]}"

    # Remove the last argument from the processing list
    unset 'args[${#args[@]}-1]'

    # Ensure output directory exists if it's a directory path
    if [[ "$output_dest" == */ ]] || [ -d "$output_dest" ]; then
        mkdir -p "$output_dest"
    fi

    # Loop through all input files (handles wildcards automatically)
    for input_file in "${args[@]}"; do
        if [ ! -f "$input_file" ]; then
            echo "Skipping '$input_file': Not a valid file."
            continue
        fi

        local filename=$(basename -- "$input_file")
        local name="${filename%.*}"
        local total_pages=$(qpdf --show-npages "$input_file" 2>/dev/null)

        if [ -z "$total_pages" ]; then
            echo "Error: Could not read page count for $input_file."
            continue
        fi

        echo "Processing $filename ($total_pages pages)..."

        local start=1
        local part=1
        while [ "$start" -le "$total_pages" ]; do
            local end=$((start + pages_per_split - 1))
            [ "$end" -gt "$total_pages" ] && end=$total_pages

            # Construct output path
            local out_name="${name}_part${part}.pdf"
            local final_out_path="$output_dest"

            # If output_dest is a directory, append filename.
            # If it's a file path prefix, it will prepend it.
            if [ -d "$output_dest" ]; then
                final_out_path="${output_dest%/}/$out_name"
            else
                final_out_path="${output_dest}_${name}_part${part}.pdf"
            fi

            qpdf "$input_file" --pages . "$start-$end" -- "$final_out_path"

            start=$((end + 1))
            part=$((part + 1))
        done
    done
    echo "Done."
}
