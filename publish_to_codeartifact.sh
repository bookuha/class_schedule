#!/bin/bash

# Help function to display usage information
usage() {
  echo "Usage: $0"
  echo ""
  echo "Required environment variables:"
  echo "  AWS_CODEARTIFACT_DOMAIN   CodeArtifact domain (e.g., class-schedule)"
  echo "  AWS_ACCOUNT_ID            AWS Account ID (e.g., 867344463750)"
  echo "  AWS_REGION                AWS region (e.g., eu-north-1)"
  echo "  AWS_CODEARTIFACT_REPO     CodeArtifact repository name (e.g., class_schedule)"
  echo ""
  echo "CODEARTIFACT_USER is optional."
  echo "Example:"
  echo "  AWS_CODEARTIFACT_DOMAIN=class-schedule AWS_ACCOUNT_ID=867344463750 \\"
  echo "  AWS_REGION=eu-north-1 AWS_CODEARTIFACT_REPO=class_schedule $0"
  exit 1
}

# Check if required environment variables are set
if [ -z "$AWS_CODEARTIFACT_DOMAIN" ] || [ -z "$AWS_ACCOUNT_ID" ] || [ -z "$AWS_REGION" ] || [ -z "$AWS_CODEARTIFACT_REPO" ]; then
  echo "Error: Missing required environment variables."
  usage
fi

# Get the authorization token from AWS CodeArtifact
CODEARTIFACT_AUTH_TOKEN=$(aws codeartifact get-authorization-token \
  --domain "$AWS_CODEARTIFACT_DOMAIN" \
  --domain-owner "$AWS_ACCOUNT_ID" \
  --region "$AWS_REGION" \
  --query authorizationToken \
  --output text)

export CODEARTIFACT_AUTH_TOKEN

# Check if the token was successfully retrieved
if [ -z "$CODEARTIFACT_AUTH_TOKEN" ]; then
  echo "Error: Unable to retrieve CodeArtifact authorization token."
  exit 1
fi

gradle publish