#!/usr/bin/env bash

slack_url=

date="$(date +"%Y-%m-%d %H:%M")"
host="$(hostname)"

if [ "$PAM_TYPE" == "open_session" ]; then
    curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"${date}, ${PAM_USER}(${PAM_RHOST}) connected to ${host}\",\"attachments\":[{\"color\":\"#36C5F0\",\"blocks\":[{\"type\":\"header\",\"text\":{\"type\":\"plain_text\",\"text\":\"SSH Login\"}},{\"type\":\"section\",\"fields\":[{\"type\":\"mrkdwn\",\"text\":\"*Date*\\n${date}\"},{\"type\":\"mrkdwn\",\"text\":\"*Host*\\n${host}\"},{\"type\":\"mrkdwn\",\"text\":\"*IP*\\n${PAM_RHOST}\"},{\"type\":\"mrkdwn\",\"text\":\"*User*\\n${PAM_USER}\"}]}]}]}" "$slack_url" &
fi

if [ "$PAM_TYPE" == "close_session" ]; then
    curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"${date}, ${PAM_USER}(${PAM_RHOST}) disconnected to ${host}\",\"attachments\":[{\"color\":\"#36C5F0\",\"blocks\":[{\"type\":\"header\",\"text\":{\"type\":\"plain_text\",\"text\":\"SSH Logout\"}},{\"type\":\"section\",\"fields\":[{\"type\":\"mrkdwn\",\"text\":\"*Date*\\n${date}\"},{\"type\":\"mrkdwn\",\"text\":\"*Host*\\n${host}\"},{\"type\":\"mrkdwn\",\"text\":\"*IP*\\n${PAM_RHOST}\"},{\"type\":\"mrkdwn\",\"text\":\"*User*\\n${PAM_USER}\"}]}]}]}" "$slack_url" &
fi
