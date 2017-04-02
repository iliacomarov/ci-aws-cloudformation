#!/usr/bin/env bash

export KeyName=$(curl -H "X-Vault-Token:$VAULT_TOKEN" "$VAULT_ADDR/v1/secret/cloudformation" | jq -r '.data' | jq -r '.KeyName')
