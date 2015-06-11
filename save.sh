echo SAVING...
(cat ~/spark-ec2/slaves) | (tasks=""; while read line; do
 ssh -n -o StrictHostKeyChecking=no -t -t root@$line "source aws-credentials && aws s3 cp /mnt/predictions/ s3://neuronforest.sparkdata/isbi_predictions --recursive" &
        tasks="$tasks $!"; done; for t in $tasks; do wait $t; done);
        source aws-credentials && aws s3 cp /mnt/predictions/ s3://neuronforest.sparkdata/isbi_predictions --recursive
        source aws-credentials && aws s3 cp /mnt/models/ s3://neuronforest.sparkdata/isbi_models --recursive
