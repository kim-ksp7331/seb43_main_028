#!/bin/bash
# 빌드 파일의 이름이 콘텐츠와 다르다면 다음 줄의 .jar 파일 이름을 수정하시기 바랍니다.
BUILD_JAR=$(ls /home/ubuntu/seb43_main_028/server/build/libs/section6-main-project-0.0.1-SNAPSHOT.jar)
JAR_NAME=$(basename $BUILD_JAR)

echo "> 현재 시간: $(date)" >> /home/ubuntu/seb43_main_028/server/deploy.log

echo "> build 파일명: $JAR_NAME" >> /home/ubuntu/seb43_main_028/server/deploy.log

echo "> build 파일 복사" >> /home/ubuntu/seb43_main_028/server/deploy.log
DEPLOY_PATH=/home/ubuntu/seb43_main_028/server
cp $BUILD_JAR $DEPLOY_PATH

echo "> 현재 실행중인 애플리케이션 pid 확인" >> /home/ubuntu/seb43_main_028/server/deploy.log
CURRENT_PID=$(pgrep -f $JAR_NAME)

if [ -z $CURRENT_PID ]
then
  echo "> 현재 구동중인 애플리케이션이 없으므로 종료하지 않습니다." >> /home/ubuntu/seb43_main_028/server/deploy.log
else
  echo "> kill -9 $CURRENT_PID" >> /home/ubuntu/seb43_main_028/server/deploy.log
  sudo kill -9 $CURRENT_PID
  sleep 5
fi


DEPLOY_JAR=$DEPLOY_PATH$JAR_NAME
echo "> DEPLOY_JAR 배포"    >> /home/ubuntu/seb43_main_028/server/deploy.log
sudo nohup java -jar $DEPLOY_JAR >> /home/ubuntu/seb43_main_028/server/deploy.log 2>/home/ubuntu/seb43_main_028/server/deploy_err.log &