# Variables
CLUSTER_NAME=vprofile-eks-cluster3  # Bumped name to avoid conflicts with half-deleted stacks
REGION=ap-south-1
NODE_NAME=Linux-nodes

# Set AWS credentials before script execution
aws sts get-caller-identity >> /dev/null
if [ $? -eq 0 ]
then
  echo "Credentials tested, proceeding with the cluster creation."

  # Creation of EKS cluster running Ubuntu OS
  eksctl create cluster \
  --name $CLUSTER_NAME \
  --version 1.36 \
  --region $REGION \
  --nodegroup-name $NODE_NAME \
  --nodes 1 \
  --nodes-min 1 \
  --nodes-max 2 \
  --node-type t3.small \
  --node-volume-size 30 \
  --node-ami-family Ubuntu2204 \
  --managed
  
  if [ $? -eq 0 ]
  then
    echo "Cluster Setup Completed with eksctl command."
  else
    echo "Cluster Setup Failed while running eksctl command."
  fi
else
  echo "Please run aws configure & set right credentials."
  echo "Cluster setup failed."
fi
