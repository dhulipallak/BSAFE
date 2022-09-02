#!/bin/bash

setup_expect_exec()
{
    sudo apt-get --yes --force-yes update
    sudo apt install expect --yes --force-yes
}

setup_expect_exec

chmod +x /tmp/expect_script.sh
chmod +x /tmp/jenkins_worker_setup.sh

/tmp/expect_script.sh
