#!/bin/bash

# 로그 파일 경로
LOG_DIR="/home/master/docker_log"
LOG_FILE="$LOG_DIR/docker_installation.log"

# 로그 디렉토리가 없다면 생성
if [ ! -d "$LOG_DIR" ]; then
    mkdir -p "$LOG_DIR"
fi

# 로그 파일이 있다면 기존 로그를 덮어쓰지 않고 새로 작성
echo "Docker installation started at $(date)" > "$LOG_FILE"

# 1. Update package list
echo "Running apt-get update..." >> "$LOG_FILE"
apt-get -y update >> "$LOG_FILE" 2>&1
if [ $? -ne 0 ]; then
    echo "apt-get update failed" >> "$LOG_FILE"
    exit 1
fi

# 2. Install dependencies
echo "Installing required packages..." >> "$LOG_FILE"
apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common >> "$LOG_FILE" 2>&1
if [ $? -ne 0 ]; then
    echo "Package installation failed" >> "$LOG_FILE"
    exit 1
fi

# 3. Add Docker’s official GPG key
echo "Adding Docker GPG key..." >> "$LOG_FILE"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - >> "$LOG_FILE" 2>&1
if [ $? -ne 0 ]; then
    echo "Failed to add Docker GPG key" >> "$LOG_FILE"
    exit 1
fi

# 4. Set up the stable repository with automatic entry
echo "Adding Docker repository..." >> "$LOG_FILE"
export DEBIAN_FRONTEND=noninteractive
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y >> "$LOG_FILE" 2>&1
if [ $? -ne 0 ]; then
    echo "Failed to add Docker repository" >> "$LOG_FILE"
    exit 1
fi

# 5. Update package list again after adding Docker repository
echo "Running apt-get update again..." >> "$LOG_FILE"
apt-get -y update >> "$LOG_FILE" 2>&1
if [ $? -ne 0 ]; then
    echo "apt-get update failed after adding Docker repository" >> "$LOG_FILE"
    exit 1
fi

# 6. Install Docker CE, CLI, and Containerd
echo "Installing Docker CE..." >> "$LOG_FILE"
apt-get install -y docker-ce docker-ce-cli containerd.io >> "$LOG_FILE" 2>&1
if [ $? -ne 0 ]; then
    echo "Docker installation failed" >> "$LOG_FILE"
    exit 1
fi

# 7. Check Docker service status
echo "Checking Docker service status..." >> "$LOG_FILE"
systemctl status docker >> "$LOG_FILE" 2>&1
if [ $? -eq 0 ]; then
    echo "Docker service is running" >> "$LOG_FILE"
else
    echo "Docker service is not running" >> "$LOG_FILE"
fi

# 8. Check Docker version
echo "Checking Docker version..." >> "$LOG_FILE"
docker -v >> "$LOG_FILE" 2>&1

echo "Docker installation finished at $(date)" >> "$LOG_FILE"
echo "Installation complete. Check logs in $LOG_FILE"

