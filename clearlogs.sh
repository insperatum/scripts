rm -rf ~/logs/*
(cat ~/spark-ec2/slaves) | (while read line; do
 ssh -n -o StrictHostKeyChecking=no -t -t root@$line "rm -rf ~/spark/work/*" & 
  tasks="$tasks $!"; done; for t in $tasks; do wait $t; done);
