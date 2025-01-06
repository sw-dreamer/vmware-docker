# Ubuntu용 MySQL Docker Setup (VMWare)

이 프로젝트는 Docker를 사용하여 MySQL 서버를 설정하고 실행하는 방법을 설명합니다.
사전에 Ubuntu에 Docker가 설치 되어야 합니다. Docker 설치 하는 방법은 [docker 설치](https://github.com/sw-dreamer/docker.git)에 표시되어있습니다.
아래는 필요한 설정 파일과 함께 MySQL Docker 컨테이너를 실행하는 스크립트에 대한 설명입니다.

## 프로젝트 파일

1. MySQL Docker 실행 스크립트(mysql_docker.sh)
   
   이 스크립트는 MySQL Docker 컨테이너를 실행하며, 로그 파일을 생성하여 실행 결과를 기록합니다.
   
   - MySQL root 비밀번호 입력 받기
   - 3306 포트를 ufw 방화벽에서 허용
   - Docker에서 MySQL 컨테이너 실행
     
   스크립트의 실행 결과는 /home/master/docker_mysql_log 디렉토리 내에 시간별로 생성된 로그 파일에 기록됩니다.
  
   사용방법
   ```
   bash
   ./mysql_docker.sh
   ```


2. MySQL 설정 파일 (my.cnf)
   
   이 파일은 MySQL 서버의 기본 설정을 정의합니다.
   
   MySQL 서버의 포트, 데이터 디렉토리, 소켓 경로, 기본 인증 플러그인 등의 설정을 포함하고 있습니다.

   해당 설정은 MySQL Docker 컨테이너에 마운트하여 사용됩니다.
   
   해당 경로는 /home/master/mysql/my.cnf 입니다.
   
   - bind-address: MySQL 서버가 외부에서 접근할 수 있도록 0.0.0.0으로 설정
   - port: MySQL 서버의 기본 포트인 3306
   - datadir: MySQL 데이터 디렉토리
   - symbolic-links: 심볼릭 링크 비활성화
   - default-storage-engine: innodb로 설정하여 기본 스토리지 엔진으로 사용
   - sql_mode: SQL 모드 설정, STRICT_TRANS_TABLES와 같은 옵션 포함
   - default_authentication_plugin: mysql_native_password로 설정하여 호환성 확보



3. MySQL 컨테이너 설정 파일 (mysqld.cnf)
   
   mysqld.cnf 파일은 MySQL 서버의 상세 설정을 포함합니다.
   
   Docker 컨테이너 내에서 MySQL 설정을 변경하는 데 사용됩니다.
   
   이 파일은 Docker 컨테이너 내의 /etc/mysql/mysql.conf.d/mysqld.cnf 경로에 마운트됩니다.
   
   해당 경로는 /etc/mysql/mysql.conf.d/mysqld.cnf 입니다.
   
   - bind-address: 외부에서 MySQL 서버에 접근할 수 있도록 0.0.0.0으로 설정
   - mysql_native_password: MySQL 인증을 mysql_native_password로 설정
   - log-error: MySQL 에러 로그를 /var/log/mysql/error.log에 기록

## MySQL Docker 컨테이너 실행
MySQL Docker 컨테이너를 실행하려면, 위에 제공된 mysql_docker.sh 스크립트를 실행해야 합니다.

이 스크립트는 MySQL Docker 이미지를 기반으로 컨테이너를 생성하고 설정을 적용합니다.

컨테이너 실행 후, MySQL은 3306 포트를 사용하며, 외부에서 접속할 수 있도록 설정됩니다.

설정에 따라 my.cnf와 mysqld.cnf 파일이 컨테이너에 마운트되며, MySQL의 로깅과 인증 설정이 적절하게 적용됩니다.

## 로그 파일
컨테이너 실행 중 발생하는 모든 로그는 /home/master/docker_mysql_log/docker_mysql_YYYYMMDD_HHMMSS.log 형식으로 생성됩니다. 이 파일에는 MySQL 컨테이너의 시작과 관련된 모든 출력이 기록됩니다.

## 방화벽 설정
스크립트는 ufw 방화벽에서 3306 포트를 허용하는 명령을 자동으로 실행합니다.
이를 통해 외부에서 MySQL 서버에 접속할 수 있도록 설정됩니다.

## 참고
- mysql_docker.sh 스크립트는 실행 시 MySQL root 비밀번호를 묻습니다. 비밀번호를 안전하게 입력해야 합니다.
- MySQL 서버가 정상적으로 실행되지 않으면, 생성된 로그 파일을 확인하여 원인을 파악할 수 있습니다.
