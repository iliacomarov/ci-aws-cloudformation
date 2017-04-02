#!/usr/bin/env bash

export AMI=$(curl -H "X-Vault-Token:$VAULT_TOKEN" "$VAULT_ADDR/v1/secret/cloudformation" | jq -r '.data' | jq -r '.AMI')
export KeyName=$(curl -H "X-Vault-Token:$VAULT_TOKEN" "$VAULT_ADDR/v1/secret/cloudformation" | jq -r '.data' | jq -r '.KeyName')
export EBSVOLUMESIZE=$(curl -H "X-Vault-Token:$VAULT_TOKEN" "$VAULT_ADDR/v1/secret/cloudformation" | jq -r '.data' | jq -r '.EBSVOLUMESIZE')
export SB_IP=$(curl -H "X-Vault-Token:$VAULT_TOKEN" "$VAULT_ADDR/v1/secret/cloudformation" | jq -r '.data' | jq -r '.SBIP')
export DOCKER_HUB_AUTH=$(curl -H "X-Vault-Token:$VAULT_TOKEN" "$VAULT_ADDR/v1/secret/cloudformation" | jq -r '.data' | jq -r '.DOCKERHUBAUTH')
export DOCKER_HUB_EMAIL=$(curl -H "X-Vault-Token:$VAULT_TOKEN" "$VAULT_ADDR/v1/secret/cloudformation" | jq -r '.data' | jq -r '.DOCKERHUBEMAIL')
export AWS_KEY=$(curl -H "X-Vault-Token:$VAULT_TOKEN" "$VAULT_ADDR/v1/secret/cloudformation" | jq -r '.data' | jq -r '.AWSKEY')
export AWS_SECRET=$(curl -H "X-Vault-Token:$VAULT_TOKEN" "$VAULT_ADDR/v1/secret/cloudformation" | jq -r '.data' | jq -r '.AWSSECRET')
export PROJECT_INACTIVITY_TIMEOUT=$(curl -H "X-Vault-Token:$VAULT_TOKEN" "$VAULT_ADDR/v1/secret/cloudformation" | jq -r '.data' | jq -r '.PROJECTINACTIVITYTIMEOUT')
export PROJECT_DANGLING_TIMEOUT=$(curl -H "X-Vault-Token:$VAULT_TOKEN" "$VAULT_ADDR/v1/secret/cloudformation" | jq -r '.data' | jq -r '.PROJECTDANGLINGTIMEOUT')
export GITHUB_TOKEN=$(curl -H "X-Vault-Token:$VAULT_TOKEN" "$VAULT_ADDR/v1/secret/cloudformation" | jq -r '.data' | jq -r '.GITHUBTOKEN')
export DOCKSAL_CI_VERSION=$(curl -H "X-Vault-Token:$VAULT_TOKEN" "$VAULT_ADDR/v1/secret/cloudformation" | jq -r '.data' | jq -r '.DOCKSALCIVERSION') 
