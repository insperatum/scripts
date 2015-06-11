if [ -z "$9" ]; then echo "Please give 9 arguments:"; echo "name, subvolumes_train, seed, initialTrees, maxDepth, maxBins, featureSubsetStrategy, features, leafSize"; exit 1; fi
source ~/scripts/subvolumes.sh
~/scripts/clear.sh;
echo "$1"; echo "$2"; echo "$3"; echo "$4"; echo "$5"; echo "$6"; echo "$7"; echo "$8"; echo "$9"
dt=$(date '+%Y%m%d_%H%M%S');
~/spark/bin/spark-submit --executor-memory 28G --driver-memory 120G --conf spark.shuffle.spill=false --conf spark.shuffle.memoryFraction=0.1 --conf spark.storage.memoryFraction=0.7 --master spark://`cat ~/spark-ec2/masters`:7077 --class Main ./neuronforest-spark.jar "name=$1" numExecutors=30 maxMemoryInMB=2500 data_root=/mnt/data localDir=/mnt/tmp master= "subvolumes_train=$2" subvolumes_test=$SUBVOLUMES_TEST "seed=$3" learningRate=1 "initialTrees=$4" save_to=/mnt/predictions save_model_to=/mnt/models treesPerIteration=10 iterations=0 "maxDepth=$5" testPartialModels=none testDepths= "maxBins=$6" useNodeIdCache=false subsampleProportion=1 momentum=0 "featureSubsetStrategy=$7" "features=$8" "leafSize=$9" nBaseFeatures=36 > "/root/logs/$dt stdout.txt" 2> "/root/logs/$dt stderr.txt" &&
~/scripts/save.sh