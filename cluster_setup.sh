#/usr/bin/env bash

set -e

# original source from aws summit London: https://s3.amazonaws.com/aws-big-data-resources/demo/NASA/big-data-first-steps.txt

## use configure.sh to set these automatically, if you want

S3_BUCKET_NAME="S3_BUCKET_NAME"
KEYPAIR_NAME="KEYPAIR_NAME"
BID_PRICE="BID_PRICE"
EMR_PROFILE="EMS_PROFILE"
PRIVATE_KEY="PRIVATE_KEY"
EMR_CLUSTER_NAME="EMR_CLUSTER_NAME"
EMR_CLUSTER_SIZE="EMR_CLUSTER_SIZE"

## create an EMR cluster with Spark, Hive and Zeppelin
### create cluster
cluster_id=$(aws emr create-cluster \
  --name ${EMR_CLUSTER_NAME} \
  --release-label emr-4.7.1 \
  --instance-groups \
InstanceGroupType=MASTER,\
InstanceType=m3.xlarge,\
InstanceCount=1,\
BidPrice=${BID_PRICE} \
InstanceGroupType=CORE,\
InstanceType=m3.xlarge,\
InstanceCount=${EMR_CLUSTER_SIZE},\
BidPrice=${BID_PRICE} \
  --ec2-attributes KeyName=${KEYPAIR_NAME} \
  --use-default-roles \
  --applications Name=Hive Name=Spark Name=Zeppelin-Sandbox \
  --profile ${EMR_PROFILE} \
  --log-uri s3://${S3_BUCKET_NAME} \
  --bootstrap-action Path=s3://${S3_BUCKET_NAME}/bootstrap_jupyter_pyspark.sh \
  --output text)

echo "$cluster_id"
echo "waiting for cluster to start, can take ~10 minutes..."

aws emr wait cluster-running --profile ${EMR_PROFILE} --cluster-id $cluster_id

# Bleh ... I think it's time to use python...
master_dns=$(aws emr describe-cluster \
  --cluster-id=${cluster_id} \
  --profile ${EMR_PROFILE} --output text \
| grep ec2 \
| awk '{ print $5 }')

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "starting jupyter..."
echo "once complete, visit http://$master_dns:8888"
echo "(you will need to have configured a proxy, see: http://docs.aws.amazon.com/ElasticMapReduce/latest/DeveloperGuide/emr-connect-master-node-proxy.html)"
echo "if the tunnel to your cluster breaks, reconnect using ssh -i ${PRIVATE_KEY} -ND 8157 hadoop@${master_dns}"
echo "don't forget to shut down $cluster_id once finished :)"
echo

# is there a better way to avoid requiring user input than not checking the Host Key?
ssh -o StrictHostKeyChecking=no -i ${PRIVATE_KEY} -ND 8157 hadoop@$master_dns&

ssh -o StrictHostKeyChecking=no -i ${PRIVATE_KEY} hadoop@$master_dns "pyspark"
