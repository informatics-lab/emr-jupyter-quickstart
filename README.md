# emr-jupyter-quickstart
Scripts to create AWS Elastic Map Reduce cluster with Jupyter installed

## Prerequisites

- aws command line installed
- Proxy installed and configured - see http://docs.aws.amazon.com/ElasticMapReduce/latest/DeveloperGuide/emr-connect-master-node-proxy.html


## Instructions

1. Modify variables in configure.sh
2. Run configure.sh
3. Run cluster_setup.sh
4. Visit public_dns:8888 to start using pyspark through a Jupyter notebook
