#!/bin/bash

# Script Start Time
#
starttime="$(date)"
echo -e "\n\n\n"
echo "### START ###"
echo "Script Start Time: $starttime >"

# Start httpd
#
echo -e "\n\n"
echo "HTTPD Starting..."
httpd -k start
echo "HTTPD Started..."

# Start tomcat
#
echo -e "\n\n"
cd /opt1/server_installs/apache_Tomcat/apache-tomcat-7.0.105/bin/
echo "Tomcat Starting..."
./catalina.sh start
echo "Tomcat Started..."


# Stop Services
#
stop_services()
{

# sleep before stopping Services
#
echo -e "\n\n\n"
echo -e "\n STOP SERVICES"
echo "Executing -SLEEP- before -STOP- Apache HTTPD STOP | Tomcat STOP..."
echo "Sleeping..."
sleep 7

# Stop HTTPD
echo -e "\n\n"
echo "HTTPD Stopping..."
httpd -k stop
echo "HTTPD Stopped..."

# Stop tomcat
cd /opt1/server_installs/apache_Tomcat/apache-tomcat-7.0.105/bin/
echo -e "\n\n"
echo "Tomcat Stopping..."
./catalina.sh stop 7 -force
echo "Tomcat Stopped..."

# Script End Time
#
endtime="$(date)"
echo -e "\n\n Script End Time: $endtime >"

# Exit Container
#
echo -e "\n### Exiting Container - <EXIT 0> ###"
exit 0

}

# STOP Services WHEN Docker STOP is issued.
#
# trap -SIGSTOP- signal
#
trap 'stop_services' SIGKILL SIGTERM SIGSTOP

# Keep Container Running - Wait for STOP Signal (docker -stop-) >
#
echo -e "\n\n\n"
echo "Keep Container Running  - Wait for STOP Signal (docker -stop-) >"

# Loop + Wait for Signal
#
while true
do
tail -100f /dev/null & wait $!
done

#
#
# END
#
