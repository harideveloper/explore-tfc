

Requirement 

1. Networking: The Kubernetes cluster is required to run with these ranges:
    - Nodes: 10.0.0.0/16 
    - Pods: 10.1.0.0/16
    - Services: 10.2.0.0/16

2. Security: Least-privileged access should be leveraged to the maximum extend
3. Ops: Different infrastructure engineers should be able to collaborate over your solution without side effects.



Solution :

1. Networking: The Kubernetes cluster is required to run with these ranges:
   - Custom VPC with subnet with respective  primary & secondary ip ranges for nodes, pods & services configured

2. Security: Least-privileged access should be leveraged to the maximum extend
    -  Private GKE Cluster  - COMPLETED 
    -  Custom GKE service Account with mandatory IAM roles  - COMPLETED 
    -  Only Mandatory APIs are not enabled - COMPLETED 
    -  Kube API / Operations are allowed only through Bastion Hosts - COMPLETED 
    -  Access to GCP Resources only through CI/CD & Bastion Hosts - COMPLETED 
    -  Firewall Rules - Ingress rules to Node/Pod with specific Ports - COMPLETED 
    -  KMS - Additional encryption  protection/ layer  to etcd, application secrets - COMPLETED 

3. Ops: Different infrastructure engineers should be able to collaborate over your solution without side effects.

    - Terraform state version controlled in google storage bucket — COMPLETED 
	- Infrastructure gitops pipeline to create the relevant infrastructire — COMPLETED
	- Active PR/MR strategy for easy colloboration — COMPLETED
    - TF Service Account Usage - Service Account Key as GH Secrets to be changes to Workload Federation - PENDING
    - TF Service Account are with highest priviledges, test by lowering respective priviledges - PENDING
	


