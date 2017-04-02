#!/usr/bin/env bash

set -x

touch ./parameters.json
cat <<EOF > ./parameters.json
[
  {
    "ParameterKey": "KeyName",
    "ParameterValue": "$KeyName"
  }, 
    {
    "ParameterKey": "AMI",
    "ParameterValue": "$AMI"
  },
  {
    "ParameterKey": "SBIP",
    "ParameterValue": {$SB_IP"
  },
    {
    "ParameterKey": "INSTANCETYPE",
    "ParameterValue": "t2.micro"
  },
    {
    "ParameterKey": "EBSVOLUMESIZE",
    "ParameterValue": "8"
  },
  {
    "ParameterKey": "DOCKERHUBAUTH",
    "ParameterValue": "$DOCKER_HUB_AUTH"
  },
  {
    "ParameterKey": "DOCKERHUBEMAIL",
    "ParameterValue": "$DOCKER_HUB_EMAIL"
  },
  {
    "ParameterKey": "AWSKEY",
    "ParameterValue": "$AWS_KEY"
  },
  {
    "ParameterKey": "AWSSECRET",
    "ParameterValue": "$AWS_SECRET"
  },
  {
    "ParameterKey": "PROJECTINACTIVITYTIMEOUT",
    "ParameterValue": "$PROJECT_INACTIVITY_TIMEOUT"
  },
  {
    "ParameterKey": "PROJECTDANGLINTIMEOUT",
    "ParameterValue": "$PROJECT_DANGLING_TIMEOUT"
  },
  {
    "ParameterKey": "GITHUBTOKEN",
    "ParameterValue": "$GITHUB_TOKEN"
  },
  {
    "ParameterKey": "DOCKSALCIVERSION",
    "ParameterValue": "$DOCKSAL_CI_VERSION"
  }
]
EOF
