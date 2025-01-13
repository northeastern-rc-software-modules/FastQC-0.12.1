#!/bin/bash
#SBATCH -N 1
#SBATCH -n 32
#SBATCH -p short

# Setting up the environment
source env_fastqc-0.12.1.sh

module load OpenJDK/22.0.2
module load perl/5.40.0
# Creating the src directory for the installed application
mkdir -p $SOFTWARE_DIRECTORY/src

# Installing $SOFTWARE_NAME/$SOFTWARE_VERSION

# Installing fastqc 0.12.1
cd $SOFTWARE_DIRECTORY/src
wget https://github.com/s-andrews/FastQC/archive/refs/tags/v0.12.1.tar.gz
tar vxf v0.12.1.tar.gz
export PERL=$(which perl)
sed -i "1s|^.*|\#\!${PERL}|" fastqc

cp $SOFTWARE_DIRECTORY/src $SOFTWARE_DIRECTORY

# Creating modulefile
touch $SOFTWARE_VERSION
echo "#%Module" >> $SOFTWARE_VERSION
echo "module-whatis	 \"Loads $SOFTWARE_NAME/$SOFTWARE_VERSION module." >> $SOFTWARE_VERSION
echo "" >> $SOFTWARE_VERSION
echo "This module was built on $(date)" >> $SOFTWARE_VERSION
echo "" >> $SOFTWARE_VERSION
echo "fastqc" >> $SOFTWARE_VERSION
echo "" >> $SOFTWARE_VERSION
echo "The script used to build this module can be found here: $GITHUB_URL" >> $SOFTWARE_VERSION
echo "" >> $SOFTWARE_VERSION
echo "To load the module, type:" >> $SOFTWARE_VERSION
echo "module load $SOFTWARE_NAME/$SOFTWARE_VERSION" >> $SOFTWARE_VERSION
echo "" >> $SOFTWARE_VERSION
echo "\"" >> $SOFTWARE_VERSION
echo "" >> $SOFTWARE_VERSION
echo "conflict	 $SOFTWARE_NAME" >> $SOFTWARE_VERSION
echo "prepend-path	 PATH $SOFTWARE_DIRECTORY" >> $SOFTWARE_VERSION

# Moving modulefile
mkdir -p $CLUSTER_DIRECTORY/modulefiles/$SOFTWARE_NAME
cp $SOFTWARE_VERSION $CLUSTER_DIRECTORY/modulefiles/$SOFTWARE_NAME/$SOFTWARE_VERSION
