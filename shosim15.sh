#!/bin/bash
export PATH=$PATH:/opt/HP/BSM/opr/support:/usr/bin/
set +x #echo on

echo "The scenario will begin in 10 seconds, press ctrl+c to cancel"
#Stage 1 - 3 minutes before next
#SiteScope
sendEvent.sh -j -s major -t "The amount of online users is above expected (2731 Avg) - high load alert" -rch "AOS Shop Main 15" -eh "Real_User_event:Major" -k "users:normal" -ckp "users:normal" -sch sitescope -nd aoslb_15
sendEvent.sh -j -s minor -t "DB transactional locks: 14 per second spotted on table: account_cnt" -rch "aosdb_15.example.com" -eh "ServerTransactionRate:Normal" -k "db:aosdb_15:*" -ckp "db:aosdb_15:normal" -sch sitescope  -nd "aosdb_15.example.com"
#NNMI
sendEvent.sh -j -s minor -t "Network activity is reaching 52%" -rch "aosweb1_15.example.com" -eh "Network:Warning" -k "network:aosweb1_15:*" -ckp "network:aosweb1_15:normal" -sch nnmi -nd "aosweb1_15.example.com"
sendEvent.sh -j -s minor -t "Network activity is reaching 61%" -rch "aosweb2_15.example.com" -eh "Network:Warning" -k "network:aosweb2_15:*" -ckp "network:aosweb2_15:normal" -sch nnmi -nd "aosweb2_15.example.com"
date
sleep 150

#Stage 2 - escalate 3 minutes before next
#SiteScope
sendEvent.sh -j -s Critical -t "High load alert - DDOS attack expected" -rch "AOS Shop Main 15" -eh "Real_User_event:Critical" -k "ddos:*" -ckp "ddos:normal" -sch sitescope
sendEvent.sh -j -s major -t "DB transactional locks: 25 per second spotted on table: account_cnt" -rch "aosdb_15.example.com" -eh "ServerTransactionRate:High" -k "db:aosdb_15:normal" -ckp "db:aosdb_15:normal" -sch sitescope -nd "aosdb_15.example.com"

#NNMI
sendEvent.sh -j -s Major -t "Network activity is reaching 87%" -rch "aosweb1_15" -eh "Network:Critical" -k "network:aosweb1_15:*" -ckp "network:aosweb1_15:normal" -sch nnmi -nd "aosweb1_15.example.com"
sendEvent.sh -j -s Major -t "Network activity is reaching 82%" -rch "aosweb2_15" -eh "Network:Critical" -k "network:aosweb2_15:*" -ckp "network:aosweb2_15:normal" -sch nnmi -nd "aosweb2_15.example.com"

#APM
sendEvent.sh -j -s Major -t "Transaction: Login Performance 12.2 seconds " -rch "AOS Shop Main 15" -eh "End_User_event:Critical" -k "login:normal" -ckp "login:normal" -sch apm
SiteScope Direct login
sendEvent.sh -j -s Major -t "Script monitor: slow responce above 10s " -rch "Apache Tomcat 15:aosweb1_15.example.com" -eh "LegacySystem:Minor" -k "response:aosweb1_15:*" -ckp "response:aosweb1_15:normal" -sch sitescope -nd "aosweb1_15.example.com"
sendEvent.sh -j -s Major -t "Script monitor: slow responce above 10s " -rch "Apache Tomcat 15:aosweb2_15.example.com" -eh "LegacySystem:Minor" -k "responce:aosweb2_15:*" -ckp "responce:aosweb2_15:normal" -sch sitescope -nd "aosweb2_15.example.com"
sendEvent.sh -j -s Major -t "Script monitor: slow responce above 10s " -rch "Load Balancer 15:aoslb_15.example.com" -eh "LegacySystem:Minor" -k "responce:aoslb_15:*" -ckp "responce:aoslb_15:normal" -sch sitescope -nd "aoslb_15.example.com"

#Second app reacts
sendEvent.sh -j -s Critical -t "Security scan initiated" -rch "AOS Security 15" -eh "LegacySystem:Critical" -k "Security:trouble" -ckp "Security:trouble" -sch sitescope
date
sleep 150


#Stage 3 - relax 3 minutes before next
#SiteScope
sendEvent.sh -j -s major -t "The amount of online users is above expected (2345 avg) - high load alert" -rch "AOS Shop Main 15" -eh "Real_User_event:Major" -k "users:normal" -ckp "users:normal" -sch sitescope -nd aoslb_15
sendEvent.sh -j -s minor -t "DB transactional locks: 7 per second spotted on table: account_cnt" -rch "aosdb_15.example.com" -eh "ServerTransactionRate:Normal" -k "db:aosdb_15:normal" -ckp "db:aosdb_15:normal" -sch sitescope  -nd "aosdb_15.example.com"
#NNMI
sendEvent.sh -j -s minor -t "Network activity is reaching 54%" -rch "aosweb1_15.example.com" -eh "Network:Warning" -k "network:aosweb1_15:*" -ckp "network:aosweb1_15:normal" -sch nnmi -nd "aosweb1_15.example.com"
sendEvent.sh -j -s minor -t "Network activity is reaching 51%" -rch "aosweb2_15.example.com" -eh "Network:Warning" -k "network:aosweb2_15:*" -ckp "network:aosweb2_15:normal" -sch nnmi -nd "aosweb2_15.example.com"

#APM
sendEvent.sh -j -s Normal -t "Resolved Transaction: Login Performance 2.4 seconds " -rch "AOS Shop Main 15" -eh "End_User_event:Normal" -k "login:normal" -ckp "login:normal" -sch apm
SiteScope Direct login
sendEvent.sh -j -s Minor -t "Normal: Script monitor: slow responce above 8s " -rch "Apache Tomcat 15:aosweb1_15.example.com" -eh "LegacySystem:Normal" -k "response:aosweb1_15:normal" -ckp "response:aosweb1_15:normal" -sch sitescope -nd "aosweb1_15.example.com"
sendEvent.sh -j -s Minor -t "Normal: monitor: slow responce above 8s " -rch "Apache Tomcat 15:aosweb2_15.example.com" -eh "LegacySystem:Normal" -k "responce:aosweb2_15:normal" -ckp "responce:aosweb2_15:normal" -sch sitescope -nd "aosweb2_15.example.com"
sendEvent.sh -j -s Minor -t "Normal: monitor: slow responce above 8s " -rch "Load Balancer 15:aoslb_15.example.com" -eh "LegacySystem:Normal" -k "responce:aoslb_15:normal" -ckp "responce:aoslb_15:normal" -sch sitescope -nd "aoslb_15.example.com"

sendEvent.sh -j -s Major -t "Security scan complete - attack NOT Detected. High load confirmed" -rch "AOS Security 15" -eh "LegacySystem:Critical" -k "Security:trouble" -ckp "Security:trouble" -sch sitescope -d "Notification: this alert triggers server scale up automcation"
date
#Remediation action - scale up servers
/opt/HP/BSM/opr/bin/opr-node.sh -add_node -node_name aosweb3_15.example.com -ci_name aosweb3_15 -ip_addrs 10.10.10.16 -user admin -pw Hel1um34.Ale2
/opt/HP/BSM/opr/bin/opr-node.sh -add_node -node_name aosweb4_15.example.com -ci_name aosweb4_15 -ip_addrs 10.10.10.34 -user admin -pw Hel1um34.Ale2
date
sleep 150



#Stage 4 - remediation related events 3 minutes  before next
sendEvent.sh -j -s Minor -t "Security scan complete - attack NOT Detected. High load confirmed" -rch "AOS Security 15" -eh "LegacySystem:Minor" -k "Security:trouble" -ckp "Security:trouble" -sch sitescope
sendEvent.sh -j -s Minor -t "DB backup restore via automation started" -rch "aosdb_15" -eh "LegacySystem:Minor" -k "db:*" -ckp "db:*" -sch sitescope -nd aosdb_15
sendEvent.sh -j -s Minor -t "DB backup restore activity detected" -rch "aosdb_15backup" -eh "LegacySystem:Minor" -k "dbback:lock" -ckp "dbback:lock" -sch sitescope -nd aosdb_15backup
date
sleep 150


#Stage 5 - Back to normal next reset by crontab job
#SiteScope
sendEvent.sh -j -s Normal -t "Normal: users are back to normal: Average 1145 per sever" -rch "AOS Shop Main 15" -eh "Real_User_event:Major" -k "login:normal" -ckp "login:normal" -sch sitescope -nd aoslb_15
sendEvent.sh -j -s Normal -t "Normal: DB transactional locks: 7 per second spotted on table: account_cnt" -rch "aosdb_15.example.com" -eh "ServerTransactionRate:Normal" -k "db:aosdb_15:normal" -ckp "db:aosdb_15:normal" -sch sitescope  -nd "aosdb_15.example.com"
#NNMI
sendEvent.sh -j -s Normal -t "Network activity is back to normal 12%" -rch "aosweb1_15.example.com" -eh "Network:Normal" -k "network:aosweb1_15:*" -ckp "network:aosweb1_15:*" -sch nnmi -nd "aosweb1_15.example.com"
sendEvent.sh -j -s Normal -t "Network activity is back to normal 16%" -rch "aosweb2_15.example.com" -eh "Network:Normal" -k "network:aosweb2_15:*" -ckp "network:aosweb2_15:*" -sch nnmi -nd "aosweb2_15.example.com"

#SiteScope

sendEvent.sh -j -s Normal -t "Normal: Security scan complete - attack NOT Detected. High load confirmed" -rch "AOS Security 15" -eh "LegacySystem:Normal" -k "Security:*" -ckp "Security:*" -sch sitescope

sendEvent.sh -j -s Normal -t "Resolved: Script monitor: slow responce above 10s " -rch "Apache Tomcat 15:aosweb1_15.example.com" -eh "LegacySystem:Normal" -k "response:aosweb1_15:normal" -ckp "response:aosweb1_15:normal" -sch sitescope -nd "aosweb1_15.example.com"
sendEvent.sh -j -s Normal -t "Resolved: Script monitor: slow responce above 10s " -rch "Apache Tomcat 15:aosweb2_15.example.com" -eh "LegacySystem:Normal" -k "responce:aosweb2_15:normal" -ckp "responce:aosweb2_15:normal" -sch sitescope -nd "aosweb2_15.example.com"
sendEvent.sh -j -s Normal -t "Resolved: Script monitor: slow responce above 10s " -rch "Load Balancer 15:aoslb_15.example.com" -eh "LegacySystem:Normal" -k "responce:aoslb_15:normal" -ckp "responce:aoslb_15:normal" -sch sitescope -nd "aoslb_15.example.com"
date
#reset CIs for next run
/opt/HP/BSM/opr/bin/opr-node.sh -del_node -node_name aosweb3_15.example.com -ci_name aosweb3_15 -ip_addrs 10.10.10.16 -user admin -pw Hel1um34.Ale2
/opt/HP/BSM/opr/bin/opr-node.sh -del_node -node_name aosweb4_15.example.com -ci_name aosweb4_15 -ip_addrs 10.10.10.34 -user admin -pw Hel1um34.Ale2
date

