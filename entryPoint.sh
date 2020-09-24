#!/bin/bash

# Script Start Time
#
starttime="$(date)"
echo -e "\n\n\n"
echo "### START ###"
echo "Script Start Time: $starttime >"

# echo
#
ls -ltr /opt1/server_installs/apache_Tomcat/apache-tomcat-7.0.105/webapps/ROOT/

# Stop Services

stop_services()
{

# Stop HTTPD
echo -e "\n\n\n"
echo "HTTPD Stopping..."
httpd -k stop
echo "HTTPD Stopped..."

# Stop tomcat
cd /opt1/server_installs/apache_Tomcat/apache-tomcat-7.0.105/bin/
echo -e "\n\n\n"
echo "Tomcat Stopping..."
./catalina.sh stop 7 -force
echo "Tomcat Stopped..."

}

echo -e "\n\n\n"
echo "Executing ---SLEEP--- before Apache HTTPD | Tomcat startup..."
echo "Sleeping..."
sleep 7

# Start httpd
echo -e "\n\n\n"
echo "HTTPD Starting..."
httpd -k start
echo "HTTPD Started..."

# Start tomcat
echo -e "\n\n\n"
cd /opt1/server_installs/apache_Tomcat/apache-tomcat-7.0.105/bin/
echo "Tomcat Starting..."
./catalina.sh start
echo "Tomcat Started..."

# Script End Time
#
endtime="$(date)"
echo -e "\n\n\n"
echo "Script End Time: $endtime >"


# END Script
#
echo -e "\n"
echo "### END ###"

# Keep Container Running >
#
echo -e "\n\n\n"
echo "Keep Container Running >"

trap 'stop_services' SIGKILL SIGTERM SIGSTOP

while true
do
tail -100f /dev/null & wait $!
done


# Exit Container
#
#echo -e "\n Exiting Container..."
#exit 0

# END
