#!/bin/bash

# 현재 날짜와 시간을 기반으로 로그 파일 이름 생성
DATE=$(date +"%Y%m%d_%H%M%S")
LOG_DIR="/home/master/docker_mysql_log"
LOG_FILE="$LOG_DIR/docker_mysql_$DATE.log"

# 로그 디렉토리 생성 (존재하지 않으면)
mkdir -p "$LOG_DIR"

# 사용자로부터 MySQL root 비밀번호 입력받기
read -sp "MySQL root 비밀번호를 입력하세요: " MYSQL_ROOT_PASSWORD
echo

# 3306 포트를 ufw 방화벽에서 허용
echo "MySQL 포트 3306을 방화벽에서 허용 중..."
sudo ufw allow 3306/tcp

# MySQL Docker 컨테이너 실행
docker run --name mysql-container -e MYSQL_ROOT_PASSWORD="$MYSQL_ROOT_PASSWORD" -p 3306:3306 \
  -v /home/master/mysql/my.cnf:/etc/mysql/mysql.conf.d/mysqld.cnf \
  -v /var/log/mysql:/var/log/mysql \
  -d mysql:latest \
  >> "$LOG_FILE" 2>&1

# 실행 결과 확인
if [ $? -eq 0 ]; then
    echo "MySQL 컨테이너가 성공적으로 시작되었습니다."
    echo "로그 파일: $LOG_FILE"
else
    echo "MySQL 컨테이너 시작 중 오류가 발생했습니다."
    echo "로그 파일: $LOG_FILE"
fi
