# bash-script

직접 사용하려고 만든 스크립트입니다.

## sshd 슬랙 알림

1. 스크립트를 저장할 디렉터리 만들기

   ```bash
   sudo mkdir /etc/ssh/scripts
   ```

2. `/etc/ssh/scripts`에 `slack_notification.sh` 생성 후 작성

   ```bash
   sudo nano /etc/ssh/scripts/slack_notification.sh

   # sshd/slack_notification.sh 참고
   # slack_url에 url 입력
   ```

3. 권한 설정

   ```bash
   sudo chmod +x /etc/ssh/scripts/slack_notification.sh
   ```

4. 알림 등록

   ```bash
   sudo echo "session optional pam_exec.so seteuid /etc/ssh/scripts/slack_notification.sh" >> /etc/pam.d/sshd

   # 또는

   sudo nano /etc/pam.d/sshd

   # @include common-password 밑에
   # session optional pam_exec.so seteuid /etc/ssh/scripts/slack_notification.sh 추가
   ```

ssh 접속을 통해 슬랙 메시지를 확인할 수 있습니다.

## fail2ban 슬랙 알림

1. `jail.conf` 파일 복사

   ```bash
   sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
   ```

2. `jail.local` 설정 중 `banaction` 변경

   ```bash
   sudo nano /etc/fail2ban/jail.local

   # before
   ...
   banaction = iptables-multiport
   ...

   # after
   ...
   banaction = iptables-multiport slack_notification
   ...
   ```

3. `/etc/fail2ban/action.d`에 `slack_notification.conf` 생성 후 작성

   ```bash
   sudo nano /etc/fail2ban/action.d/slack_notification.conf

   # fail2ban/slack_notification.conf 참고
   # slack_url에 url 입력
   ```

4. fail2ban 재시작 및 확인

   ```bash
   sudo systemctl restart fail2ban
   sudo systemctl status fail2ban
   ```

`sudo fail2ban-client set sshd banip 192.168.100.10` 그리고 `sudo fail2ban-client set sshd unbanip 192.168.100.10`을 통해 슬랙 메시지를 확인할 수 있습니다.
