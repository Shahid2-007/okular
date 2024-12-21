#!/bin/bash

# Directory containing Okular metadata
METADATA_DIR="$HOME/.local/share/okular/docdata"

# Find the most recently modified metadata file
LAST_METADATA_FILE=$(ls -t "$METADATA_DIR"/*xml 2>/dev/null | head -n 1)

# Extract the file path from the metadata
if [ -n "$LAST_METADATA_FILE" ]; then
    # Look for the `URL:` key in the YAML file
    FILE_PATH=$(grep -Po '(?<=url=).*' "$LAST_METADATA_FILE" | sed 's/[">]//g')

    # Check if the file path exists
    if [ -f "$FILE_PATH" ]; then
        okular "$FILE_PATH"
    else
        okular && echo "File not found:$FILE_PATH"
    fi
else
    echo "No recently accessed files found in Okular's metadata."
fi
