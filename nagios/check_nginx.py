#!/usr/bin/python
# check_nginx is a Nagios to monitor nginx status
# The version is 1.0.2
# fixed by Nikolay Kandalintsev (twitter: @nicloay)
# Based on yangzi2008@126.com from http://www.nginxs.com 
#       which available here http://exchange.nagios.org/directory/Plugins/Web-Servers/nginx/check_nginx/details

import string
import urllib2
import getopt
import sys

def usage():
   print """check_nginx is a Nagios to monitor nginx status
   Usage:

   check_nginx [-h|--help][-U|--url][-P|--path][-u|--user][-p|--passwd][-w|--warning][-c|--critical]

   Options:
          --help|-h)
            print check_nginx help.
          --url|-U)
            Sets nginx status url.
          --path|-P)
            Sets nginx status url path. Default is: off
          --user|-u)
            Sets nginx status BasicAuth user. Default is: off
          --passwd|-p)
            Sets nginx status BasicAuth passwd. Default is: off
          --warning|-w)
            Sets a warning level for nginx Active connections. Default is: off
          --critical|-c)
            Sets a critical level for nginx Active connections. Default is: off
	Example:
            The url is www.nginxs.com/status
            ./check_nginx -U www.nginxs.com -P /status -u eric -p nginx -w 1000 -c 2000
            if dont't have password:
            ./check_nginx -U www.nginxs.com -P /status -w 1000 -c 2000
            if don't have path and password:
            ./check_nginx -U www.nginxs.com -w 1000 -c 2000"""

   sys.exit(3)

try:
    options,args = getopt.getopt(sys.argv[1:],"hU:P:u:p:w:c:",["help","url=","path=","user=","passwd=","warning=","critical="])

except getopt.GetoptError:
   usage()
   sys.exit(3)

for name,value in options:
    if name in ("-h","--help"):
       usage()
    if name in ("-U","--url"):
       url = "http://"+value
    if name in ("-P","--path"):
       path = value
    if name in ("-u","--user"):
       user = value
    if name in ("-p","--passwd"):
       passwd = value
    if name in ("-w","--warning"):
       warning = value
    if name in ("-c","--critical"):
       critical = value
try:
   if 'path' in dir():
      req = urllib2.Request(url+path)
   else:
      req = urllib2.Request(url)
   if 'user' in dir() and 'passwd' in dir():
      passman = urllib2.HTTPPasswordMgrWithDefaultRealm()
      passman.add_password(None, url+path, user, passwd)
      authhandler = urllib2.HTTPBasicAuthHandler(passman)
      opener = urllib2.build_opener(authhandler)
      urllib2.install_opener(opener)
   response = urllib2.urlopen(req)
   the_page = response.readline()
   conn = the_page.split()
   ActiveConn = conn[2]
   the_page1 = response.readline()
   the_page2 = response.readline()
   the_page3 = response.readline()
   response.close()

   a = the_page2.split()
   AcceptedConn = int(a[0])
   HandledConn = int(a[1])
   NbRequests = int(a[2])

   ReqPerConn = NbRequests / HandledConn

   b = the_page3.split()
   reading = b[1]
   writing = b[3]
   waiting = b[5]
   output = 'ActiveConn:%s, reading:%s, writing:%s, waiting:%s, AcceptedConn:%s, HandledConn:%s, NbRequests:%s' % (ActiveConn,
                                                                                                                  reading,
                                                                                                                  writing,
                                                                                                                  waiting,
                                                                                                                  AcceptedConn,
                                                                                                                  HandledConn,
                                                                                                                  NbRequests)
   perfdata = 'ActiveConn=%s; reading=%s; writing=%s; waiting=%s; ReqPerConn=%s' % (ActiveConn,reading,writing,waiting,ReqPerConn)

except Exception:
   print "NGINX STATUS unknown: Error while getting Connection"
   sys.exit(3)
if 'warning' in dir() and 'critical' in dir():
   if int(ActiveConn) >= int(critical):
      print 'CRITICAL - %s|%s' % (output,perfdata)
      sys.exit(2)
   elif int(ActiveConn) >= int(warning):
      print 'WARNING - %s|%s' % (output,perfdata)
      sys.exit(1)
   else:
      print 'OK - %s|%s' % (output,perfdata)
      sys.exit(0)
else:
   print 'OK - %s|%s' % (output,perfdata)
   sys.exit(0)