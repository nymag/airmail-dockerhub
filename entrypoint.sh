#!/bin/sh

set -e

# Respect AWS_DEFAULT_REGION if specified
[ -n "$AWS_DEFAULT_REGION" ] || export AWS_DEFAULT_REGION=us-east-1

# Respect AWS_DEFAULT_OUTPUT if specified
[ -n "$AWS_ACCESS_KEY_ID" ] || export AWS_DEFAULT_OUTPUT=json

# Require env vars to be set
if [ -z "$AWS_ACCESS_KEY_ID" ] || [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo "Need to set env vars for AWS: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html"
  exit 1
else
  sh -c "airmail $*"
fi
