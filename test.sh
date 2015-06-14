if [ -z "$5" ]; then echo "Please give 5 arguments:"; echo "name, subvolumes_train, maxBins, loadModel, features"; exit 1; fi
source ~/scripts/subvolumes.sh
~/scripts/clear.sh;
echo "$1"; echo "$2"; echo "$3"; echo "$4"; echo "$5"; echo "$6";
dt=$(date '+%Y%m%d_%H%M%S');
~/spark/bin/spark-submit --executor-memory 28G --driver-memory 120G --conf spark.shuffle.spill=false --conf spark.shuffle.memoryFraction=0.1 --conf spark.storage.memoryFraction=0.7 --master spark://`cat ~/spark-ec2/masters`:7077 --class Main ./neuronforest-spark.jar "name=$1" numExecutors=30 maxMemoryInMB=2500 data_root=/mnt/data localDir=/mnt/tmp master= "subvolumes_train=$2" subvolumes_test=$SUBVOLUMES_TEST "loadModel=$4" save_to=/mnt/predictions save_model_to= iterations=0 testPartialModels= "maxBins=$3" useNodeIdCache=false "features=$5" nBaseFeatures=36 > "/root/logs/$dt stdout.txt" 2> "/root/logs/$dt stderr.txt" &&
~/scripts/save.sh
