#!/bin/bash
# Update the ~/.bashrc 
# Sets up the environment variables with information used by the PG tools
# REQUIRES the region to be provided as an argument
if [ -z "$1" ]; then
    echo "Usage:  ./bin/set-env.sh  <AWS-Region> "
    echo "e.g.,   ./bin/set-env.sh  us-east-1"
    exit 1
fi

export AWS_DEFAULT_REGION=$1
echo "export AWS_DEFAULT_REGION=\"$AWS_DEFAULT_REGION\"" >> /home/ec2-user/.bashrc

export PG_CLUSTER_ID=rdsa-postgresql-cluster

export PGWRITEREP="$(aws rds describe-db-clusters  --db-cluster-identifier $PG_CLUSTER_ID | jq -r .DBClusters[0].Endpoint)"
echo "export PGWRITEREP=\"$PGWRITEREP\"" >> /home/ec2-user/.bashrc

export PGREADEREP=$(aws rds describe-db-clusters  --db-cluster-identifier $PG_CLUSTER_ID | jq -r .DBClusters[0].ReaderEndpoint)
echo "export PGREADEREP=\"$PGREADEREP\"" >> /home/ec2-user/.bashrc

export PGHOST=$PGWRITEREP
echo "export PGHOST=\"$PGHOST\"" >> /home/ec2-user/.bashrc

export PGPORT=5432
echo "export PGPORT=\"$PGPORT\"" >> /home/ec2-user/.bashrc

export PGUSER=masteruser
echo "export PGUSER=\"$PGUSER\"" >> /home/ec2-user/.bashrc

export PGPASSWORD=masteruserpw
echo "export PGPASSWORD=\"$PGPASSWORD\"" >> /home/ec2-user/.bashrc

export PGDATABASE=labdb
echo "export PGDATABASE=\"$PGDATABASE\"" >> /home/ec2-user/.bashrc
