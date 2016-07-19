#### configure ####

# S3 bucket to store EMR Bootstrap scripts + cluster logs in
S3_BUCKET_NAME=S3_BUCKET_NAME

# AWS Account ID (see support > support center)
ACCOUNT_ID=ACCOUNT_ID

# AWS Profile with permissions to create EMR cluster (requires setup in ~/.aws/config)
EMR_PROFILE=EMS_PROFILE

# AWS Keypair name to enable EC2 login
KEYPAIR_NAME=KEYPAIR_NAME

# Location of local private key linked to AWS Keypair
PRIVATE_KEY=PRIVATE_KEY

# Maximum bid for spot pricing
BID_PRICE=BID_PRICE

# EMR Cluster Name 
EMR_CLUSTER_NAME=EMR_CLUSTER_NAME

# Number of 'Core' nodes to spin up
EMR_CLUSTER_SIZE=EMR_CLUSTER_SIZE

#### configure END ####


sed -i '' -e "s/S3_BUCKET_NAME=.*/S3_BUCKET_NAME=\"$S3_BUCKET_NAME\"/" ./*_setup.sh
sed -i '' -e "s/ACCOUNT_ID=.*/ACCOUNT_ID=\"$ACCOUNT_ID\"/" ./*_setup.sh
sed -i '' -e "s/FIREHOSE_PROFILE=.*/FIREHOSE_PROFILE=\"$FIREHOSE_PROFILE\"/" ./*_setup.sh
sed -i '' -e "s/EMR_PROFILE=.*/EMR_PROFILE=\"$EMR_PROFILE\"/" ./*_setup.sh
sed -i '' -e "s/KEYPAIR_NAME=.*/KEYPAIR_NAME=\"$KEYPAIR_NAME\"/" ./*_setup.sh
sed -i '' -e "s/BID_PRICE=.*/BID_PRICE=\"$BID_PRICE\"/" ./*_setup.sh
sed -i '' -e "s/EMR_CLUSTER_NAME=.*/EMR_CLUSTER_NAME=\"$EMR_CLUSTER_NAME\"/" ./*_setup.sh
sed -i '' -e "s/EMR_CLUSTER_SIZE=.*/EMR_CLUSTER_SIZE=\"$EMR_CLUSTER_SIZE\"/" ./*_setup.sh

# Private key is likely a path, so we use @ as a sed delimiter rather than /
sed -i '' -e "s@PRIVATE_KEY=.*@PRIVATE_KEY=\"$PRIVATE_KEY\"@" ./*_setup.sh
