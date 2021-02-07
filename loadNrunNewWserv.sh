#! /bin/bash
# Script running another a bash script - from a Git repository -
# to install a new webserver with a static welcome page.
# Intended to be used in a SSH session.
# Starts by downloading a bash script from a Git repository, 
# runs the script and then removes the repository.
#
# 
# sudo apt install git
cd 
mkdir TmpWorkSpace
cd TmpWorkSpace
git clone https://github.com/lottaF/AddWServer.git
cd AddWServer
NAMEONPAGE=$1
RESULT=(bash AddNewWebserver.sh $NAMEONPAGE)
echo "Pretending to run the script"
#check result
# add error text if not ok
#cleanup
echo "cleanup"
cd
#rm --r TmpWorkSpace