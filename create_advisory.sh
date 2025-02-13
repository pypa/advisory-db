#!/usr/bin/env bash
# Generate a starter record for a given project name.
# Usage: create_advisory.sh [package_name]

# Function to get the current date in the required format
get_current_date() {
  date -u +"%Y-%m-%dT%H:%M:%SZ"
}

# Check if the package name is provided as a CLI argument
if [ -n "$1" ]; then
  package_name="$1"
else
  read -r -p "Enter the package name: " package_name
fi

# Prompt the user for other inputs
read -r -p "Enter the summary: " summary
read -r -p "Enter the evidence URL: " evidence_url

# Generate the id and modified date
id="PYSEC-0000-$package_name.yaml"
modified=$(get_current_date)
ecosystem="PyPI"
purl="pkg:pypi/$package_name"

# Create a subdirectory for the package
mkdir -p "vulns/$package_name"

# Create the YAML file
cat <<EOL > "vulns/$package_name/$id"
# TODO: Fill in the details below, and remove any comments prior to committing.
# See https://ossf.github.io/osv-schema/ for format and field descriptions.
id: $id
modified: $modified
summary: $summary
details: |
affected:
- package:
    ecosystem: $ecosystem
    name: $package_name
    purl: $purl
  # versions:
  # - "0.1.0"
  # - "0.1.1"
references:
- type: EVIDENCE
  url: $evidence_url
# - type: WEB
#   url: https://
# credits:
# - type: REPORTER
#   name: 
# - type: COORDINATOR
#   name: 
EOL

echo "YAML file created at vulns/$package_name/$id and is ready for editing."
