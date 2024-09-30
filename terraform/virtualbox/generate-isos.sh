#!/bin/bash

# Determine if the script is running on Windows or Linux
if [[ "$(uname)" == *"NT"* ]]; then
  # Running on Windows
  path_option="pwd -W"
else
  # Running on Linux
  path_option="pwd"
fi

# Find all files ending with _cloudinit.cfg in the current directory
for config in *_cloudinit.cfg; do
  # Check if there are matching files
  if [[ -f "$config" ]]; then
    # Generate the ISO filename by replacing .cfg with .iso
    iso="${config%.cfg}.iso"
    
    # Extract the name to look for corresponding .env file
    name="${config%%_cloudinit.cfg}"

    # Check if the corresponding .env file exists
    env_file="${name}.env"
    if [[ -f "$env_file" ]]; then
      echo "Found environment file: ${env_file}"

      # Create a backup of the cloud-init file
      cp "$config" "${config}.bak"
      echo "Backup created: ${config}.bak"

      # Replace placeholders in the cloud-init file with values from .env
      while IFS='=' read -r key value; do
        # Escape special characters in the value for sed
        escaped_value=$(printf '%s\n' "$value" | sed -e 's/[\/&]/\\&/g')

        # Replace all occurrences of the placeholder in the cloud-init config
        sed -i "s|\${$key}|$escaped_value|g" "$config"
      done < "$env_file"
      
      echo "Placeholders replaced in ${config}."
    else
      echo "No environment file found for ${name}. Skipping value replacement."
    fi

    echo "Creating ISO for ${config}..."

    # Run docker to generate the ISO
    docker run --rm -v "$($path_option):/workspace" cloud-localds-runner "${iso}" "${config}"

    echo "ISO created: ${iso}"
  else
    echo "No cloud-init config files found."
  fi
done

echo "All ISOs created successfully (if any config files were found)."
