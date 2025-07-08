#!/bin/bash
kill -9 `cat pidfile.txt`
ps -ef | grep webos.jar | grep -v grep | awk '{print $2}' | xargs -I {} kill -9 {}
sleep 3
javaPath="../jre/bin/java"
lc="java"
if [ -f "$javaPath" ]; then
    lc="$javaPath"
fi
nohup $lc -Dfile.encoding=UTF-8 -javaagent:webos.jar -XX:+UseG1GC -Xms128m -jar webos.jar > webos.log &
echo 'Starting...'
sleep 5
cat webos.log