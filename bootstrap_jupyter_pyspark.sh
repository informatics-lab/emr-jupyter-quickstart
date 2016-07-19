#/usr/bin/env bash

set -e

mkdir $HOME/notebooks

wget http://repo.continuum.io/archive/Anaconda2-4.1.1-Linux-x86_64.sh -O $HOME/Anaconda2-4.1.1-Linux-x86_64.sh
bash $HOME/Anaconda2-4.1.1-Linux-x86_64.sh -b
rm $HOME/Anaconda2-4.1.1-Linux-x86_64.sh

echo -en "\n" >> ~/.bashrc # ensure we start on a clean new line
echo \export PATH=$HOME/anaconda2/bin:\$PATH >> ~/.bashrc
echo \export PYSPARK_DRIVER_PYTHON=jupyter >> ~/.bashrc
echo \export PYSPARK_PYTHON=$HOME/anaconda2/bin/python >> ~/.bashrc
echo \export PYSPARK_DRIVER_PYTHON_OPTS=\"notebook --no-browser --ip=0.0.0.0 --notebook-dir=$HOME/notebooks/\" >> ~/.bashrc

source ~/.bashrc

conda clean --all -y
conda install -y -c scitools iris
