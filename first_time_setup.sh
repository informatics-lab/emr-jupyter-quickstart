#!/usr/bin/env bash

#### configure ####

S3_BUCKET_NAME="S3_BUCKET_NAME"

#### configure END ####

aws s3 mb s3://${S3_BUCKET_NAME}

aws s3 cp ./bootstrap_jupyter_pyspark.sh s3://${S3_BUCKET_NAME}/bootstrap_jupyter_pyspark.sh
