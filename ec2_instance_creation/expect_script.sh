#!/usr/bin/expect -f

set timeout -1

spawn /tmp/jenkins_worker_setup.sh

expect "New password:"

send -- "jenkinspass\r"

expect "Retype new password:"

send -- "jenkinspass\r"

expect eof