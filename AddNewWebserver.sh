#! /bin/bash
# Script adding a new persistent webserver
# - Takes a name as input and adds this to a static web page.
# Return any errors as output of function.

# Variables: NAME (1st input argument)

function errorExit() {
  # write input string as error message with STDIN to STDERR
  # and exit with status '1'
  local ERRMSG="\nERROR: $1"
  echo -e $ERRMSG 1>&2
  exit 1
}

NAME=$1
# Check that an parameter was given
if [ "${#NAME}" == 0 ]
then
  errorExit "A parameter stating a name is expected." 
fi

# Check that user is root and quit otherwise.
if [ $(whoami) != root ]
then
  errorExit "You are running as $(whoami).\nPlease run as root."
fi


function isServiceInstalled() {
    # checks if service (in input parameter) exist
    # String contains text if it exist
    systemctl list-units --type=service | grep $1
}

# Check that service is not already installed
RESULT=$(isServiceInstalled nginx)

if [ "${#RESULT}" != 0 ] 
then
  errorExit "Server nginx already in place.\nPlease remove nginx and try again."
fi


echo "Installing service - this may take a while..."
# Install nginx webserver. 
apt-get update --yes > /dev/null
apt-get install nginx --yes > /dev/null

# Start webserver and persist
systemctl start nginx.service > /dev/null
systemctl enable nginx.service > /dev/null


# Check it is installed - minimal error handling
RESULT=$(isServiceInstalled nginx)

if [ "${#RESULT}" == 0 ] 
then
  errorExit "Something went wrong - server not found"
fi

# Modify the initial welcomepage.
#cat /var/www/html/index.nginx-debian.html

mv /var/www/html/index.nginx-debian.html /var/www/html/index.nginx-debian.html.bak
cat /var/www/html/index.nginx-debian.html.bak | sed 's/<h1>.*</<h1>This is '$NAME's page</' > /var/www/html/index.nginx-debian.html
chmod 644 /var/www/html/index.nginx-debian.html

