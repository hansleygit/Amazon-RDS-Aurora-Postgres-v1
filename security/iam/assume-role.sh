#!/bin/bash
#This script assumes the role  IAM_DBUSER_ROLE

IAM_DBUSER_ROLE=rdsa-iam-dbuser-role
IAM_DBUSER_ROLE_ARN=$(aws iam list-roles --query "Roles[?RoleName=='$IAM_DBUSER_ROLE'].Arn" --output text)


ENV_VARS_JSON=$(aws sts assume-role --role-arn "$IAM_DBUSER_ROLE_ARN" --role-session-name AWSCLI-DBUser-Session)

AWS_ACCESS_KEY_ID=$(jq -r '.Credentials.AccessKeyId' <<< $ENV_VARS_JSON )
AWS_SECRET_ACCESS_KEY=$(jq -r '.Credentials.SecretAccessKey' <<< $ENV_VARS_JSON )
AWS_SESSION_TOKEN=$(jq -r '.Credentials.SessionToken' <<< $ENV_VARS_JSON )





