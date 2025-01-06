# Ubuntu용 Docker 설치 스크립트(VMWare)

이 저장소는 Ubuntu 시스템에서 Docker를 자동으로 설치하는 쉘 스크립트를 제공합니다. 이 스크립트는 Docker를 설치하는 데 필요한 단계들을 자동으로 수행하며, 설치 과정 중 발생하는 로그를 지정된 디렉토리에 저장합니다.

    
## 기능
   - Ubuntu에서 Docker 설치 자동화
   - 설치 과정의 로그를 /home/master/docker_log/docker_installation.log에 저장
   - apt-transport-https, ca-certificates, curl 등 필요한 종속성 자동 설치
   - Docker의 GPG 키와 저장소 자동 추가, 수동 입력 없이 설치 진행
   - Docker가 정상적으로 설치되었는지 확인 (서비스 상태 및 버전 확인)

## 요구 사항
스크립트를 실행하기 전에 다음 사항들을 확인해주세요
   - sudo 권한이 있는 Ubuntu 시스템이어야 합니다.
   - /home/master/docker_log 디렉토리가 존재하거나, 스크립트 실행 중에 자동으로 생성됩니다.
   - 시스템이 Docker 및 필요한 패키지를 다운로드할 수 있는 인터넷 연결이 필요합니다.

## 사용 방법

1. 스크립트 다운로드
   docker_install.sh을 다운로드 합니다.

2. 실행 권한 부여
   스크립트에 실행 권한을 부여합니다:
   ```
   chmod +x docker_install.sh
   ```
3. 스크립트 실행
   다음 명령어로 스크립트를 실행합니다
   ```
   ./docker_install.sh
   ```
   스크립트가 수행하는 작업은 다음과 같습니다.
   - 패키지 목록을 업데이트합니다.
   - 필요한 종속성 패키지를 설치합니다.
   - Docker의 공식 GPG 키를 추가합니다.
   - Docker의 안정적인 저장소를 추가합니다.
   - Docker CE (Community Edition), Docker CLI, containerd를 설치합니다.
   - Docker 서비스 상태를 확인합니다.
   - 설치된 Docker 버전을 출력합니다.
   설치 과정은 /home/master/docker_log/docker_installation.log 파일에 기록됩니다.

4. 로그 확인
   스크립트 실행 후 설치 로그를 /home/master/docker_log/docker_installation.log에서 확인할 수 있습니다
   ```
   vim /home/master/docker_log/docker_installation.log
   ```
   로그 파일에는 각 단계별 설치 과정과 발생한 오류에 대한 정보가 포함되어 있습니다.

5. Docker 설치 확인
   스크립트가 완료되면 Docker가 정상적으로 설치되어 있어야 합니다.
   Docker 버전 확인으로 설치 여부를 확인 할 수 있습니다. 
   ```
   docker --version
   ```

6. Docker 서비스 확인
   ``` bash
   sudo systemctl status docker
   ```
   Docker가 정상적으로 설치되었다면 Docker 서비스가 "active (running)" 상태로 표시됩니다.

## 문제 해결
   설치 중 문제가 발생하면 /home/master/docker_log/docker_installation.log 로그 파일을 확인하세요.

## 일반적인 문제
   - Docker 패키지를 다운로드하는 중 네트워크 문제 발생
   - 종속성 문제 또는 패키지 충돌 (스크립트가 이를 자동으로 처리해야 함)
   - /home/master/docker_log 디렉토리에 대한 권한 문제
<hr/>

## 참조 링크
[docker] : https://hub.docker.com/

[ibm] : https://www.ibm.com/kr-ko/topics/kubernetes
