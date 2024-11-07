#!/bin/bash

# GraphMiner: A Bash script to extract GraphQL queries and mutations from JavaScript files using waymore and httpx.

# Exit immediately if a command exits with a non-zero status
set -e

# Function to check if a command exists
check_command() {
    local cmd=$1
    local install_instructions=$2
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: '$cmd' is not installed or not in PATH."
        echo "Installation instructions: $install_instructions"
        MISSING_TOOLS=1
    fi
}

# Initialize missing tools flag
MISSING_TOOLS=0

# Check for required tools with installation instructions
echo "Checking for required tools..."

check_command "waymore" "Refer to https://github.com/Xnl-h4ck3r/waymore for installation instructions."
check_command "httpx" "Refer to https://github.com/projectdiscovery/httpx for installation instructions."
check_command "grep" "It should be pre-installed on most Unix-like systems."
check_command "sed" "It should be pre-installed on most Unix-like systems."
check_command "bc" "Install it using your package manager, e.g., 'sudo apt-get install bc' on Debian-based systems."

# If any tools are missing, exit the script
if [ "$MISSING_TOOLS" -eq 1 ]; then
    echo "Please install the missing tools and ensure they are in your PATH."
    exit 1
fi

echo "All required tools are installed."

# Prompt the user for the domain
read -p "Enter the domain: " DOMAIN

# Validate input
if [ -z "$DOMAIN" ]; then
    echo "Error: No domain provided."
    exit 1
fi

# Define output directories
WAYMORE_OUTPUT_DIR="./graphminer_waymore_results"
HTTPX_OUTPUT_DIR="./graphminer_httpx_results"
JS_RESPONSES_DIR="./graphminer_js_responses"

# Create necessary directories
mkdir -p "$WAYMORE_OUTPUT_DIR" "$HTTPX_OUTPUT_DIR" "$JS_RESPONSES_DIR"

# Run waymore to retrieve JS URLs and responses
echo "[*] Running waymore to retrieve JS URLs and responses..."
waymore -i "$DOMAIN" -mode B -oU "$WAYMORE_OUTPUT_DIR/urls.txt" -oR "$JS_RESPONSES_DIR"
echo "[+] waymore completed."

# Extract JS URLs from waymore's output
echo "[*] Extracting JS URLs..."
grep -Ei '\.js(\?.*)?$' "$WAYMORE_OUTPUT_DIR/urls.txt" > "$WAYMORE_OUTPUT_DIR/js_urls.txt"
JS_URLS_COUNT=$(wc -l < "$WAYMORE_OUTPUT_DIR/js_urls.txt")
echo "[+] Found $JS_URLS_COUNT JS URLs."

# Exit if no JS URLs are found
if [ "$JS_URLS_COUNT" -eq 0 ]; then
    echo "No JS URLs found. Exiting."
    exit 0
fi

# Use httpx to extract mutations and queries from JS responses
echo "[*] Running httpx to extract mutations and queries..."
HTTPX_EXTRACTED_FILE="$HTTPX_OUTPUT_DIR/extracted_matches.txt"
httpx -l "$WAYMORE_OUTPUT_DIR/js_urls.txt" \
      -mr "mutation [A-Za-z_]+\(" \
      -mr "query [A-Za-z_]+" \
      -silent > "$HTTPX_EXTRACTED_FILE"
echo "[+] httpx extraction completed."

# Process the extracted matches to separate mutations and queries
echo "[*] Processing extracted matches..."
# Extract mutations
grep -oE "mutation [A-Za-z_]+\(" "$HTTPX_EXTRACTED_FILE" | sed 's/mutation \([A-Za-z_]\+\)(.*/\1/' > "$HTTPX_OUTPUT_DIR/mutations.txt"

# Extract queries
grep -oE "query [A-Za-z_]+" "$HTTPX_EXTRACTED_FILE" | sed 's/query //' | sort | uniq > "$HTTPX_OUTPUT_DIR/queries.txt"

echo "[+] Mutations and queries extracted."

# Display summary
MUTATIONS_COUNT=$(wc -l < "$HTTPX_OUTPUT_DIR/mutations.txt")
QUERIES_COUNT=$(wc -l < "$HTTPX_OUTPUT_DIR/queries.txt")

echo "----------------------------------------"
echo "Summary:"
echo "Total JS URLs processed: $JS_URLS_COUNT"
echo "Total Mutations Extracted: $MUTATIONS_COUNT"
echo "Total Queries Extracted: $QUERIES_COUNT"
echo "----------------------------------------"
echo "[*] Extraction completed successfully."
echo "Results are saved in the following directories:"
echo " - JS Responses: $JS_RESPONSES_DIR"
echo " - Waymore URLs: $WAYMORE_OUTPUT_DIR"
echo " - Httpx Results: $HTTPX_OUTPUT_DIR"
