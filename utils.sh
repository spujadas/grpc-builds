#!/bin/bash

# check if environment variable is set
check_env_var() {
  VAR=$1
  if [[ -z ${!VAR} ]]; then
    echo "❌ ${VAR} is not set"
    exit 1
  else
    echo "${VAR} is set: ${!VAR}"
  fi
}
