 #!/bin/bash
 
 set -x
 
 sleep 60

 scp_to_target()
 {
 scp -i /home/ankitchanpuriag/capstone_project/ec2_instance/capstone_project.pem -r authorized_keys ubuntu@${1}:/home/jenkins/.ssh
 }

 scp_to_target $1