# terraform-aws-eks

- ``` terraform-aws-eks ``` is a Terraform module to provide EKS cluster With node groups .
- it's an opensource module under GPL license

## Usage
```


module "eks" {
  name               = "Kubernetes-ELK"
  role               = "arn:aws:iam::648792355513:role/role"
  security_group_ids = "sg-01ba4dab8ebd2e9ee"
  subnet_ids         = "subnet-02480121a8c228106"
  depends            = module.eks-wescale.iam_defined_attachements
  cluster_vars = [
    {
      cluster_name    = "Kubernetes-ELK"
      node_group_name = "integ_nodes"
      node_role_arn   = module.integ_node_group_role.iam_arn
      desired_size    = 3
      max_size        = 10
      min_size        = 3
    },
    {
      cluster_name    = "Kubernetes-ELK"
      node_group_name = "monitoring_nodes"
      node_role_arn   = module.integ_node_group_role.iam_arn
      desired_size = 6
      max_size     = 10
      min_size     = 6

    }
  ]
  depends_cluster = [module.integ_node_group_role.iam_defined_attachements,
  module.integ_node_group_role.iam_defined_attachements]
  labels = [{},{}]
  tags_for_node_groups=[{},{}]

}


```

## Input Variables:

| name                      | description                                                                                       | type         | required |
|---------------------------|---------------------------------------------------------------------------------------------------|--------------|----------|
| name                      | Name of CLuster                                                                                   | string       | yes      |
| role                      | ARN of IAM roles                                                                                  | string       | yes      |
| subnet_ids                | A list of subnet IDs to launch the cluster in                                                     | list(string) | yes      |
| security_group_ids        | A list of associated security group IDs                                                           | list(string) | yes      |
| depends                   | dependencies of cluster                                                                           | list(map)    | no       |
| tags_for_cluster          | Cluster Tags                                                                                      | map(string)  | no       |
| version_kube              | Kubernetes Version                                                                                | string       | no       |
| enabled_cluster_log       | A list of the desired control plane logging to enable. For more information                       | list(string) | no       |
| endpoint_private_access   | Indicates whether or not the Amazon EKS private API server endpoint is enabled. Default is false  | Bool         | no       |
| endpoint_public_access    | Indicates whether or not the Amazon EKS public API server endpoint is enabled. Default is true    | Bool         | no       |
| public_access_cidrs       | List of CIDR blocksIndicates which CIDR blocks can access the Amazon EKS public                   | list(string) | no       |
| cluster_vars              | Variables required to build Node Groupe                                                           | list(map)    | yes      |
| instance_types            | instance types                                                                                    | list(string) | no       |
| labels                    | Key-value map of Kubernetes labels                                                                | list(map)    | no       |
| tags_for_node_groups      | Node group Tags                                                                                   | list(map)    | no       |
| depends_cluster           | dependencies of node groupe                                                                       | list(map)    | yes      |
| force_update_version      | Force version update if existing pods are unable to be drained due to pod disruption budget issue | Bool         | no       |
| disk_size                 | Disk size in GiB for worker nodes. Defaults to 20.                                                | Number       | no       |

```

- cluster_vars are variables for node groupe, you can create multiple nodes groups in one cluster : 
cluster_vars = [ { # first node group
      cluster_name    => EKS cluster name
      node_group_name => Nodes groups name
      node_role_arn   => ARN of IAM for nodes groups
      desired_size    => Desired number of worker nodes
      max_size        => Maximum number of worker nodes
      min_size        => Minimum number of worker nodes
      ami_type        => ami type for instances, by default is "AL2_x86_64" .
      disk_size       => Disk size in GiB for worker nodes. Defaults to 20( optional )
},
 { # second node group
      cluster_name    => EKS cluster name
      node_group_name => Nodes groups name
      node_role_arn   => ARN of IAM for nodes groups
      desired_size    => Desired number of worker nodes
      max_size        => Maximum number of worker nodes
      min_size        => Minimum number of worker nodes
      ami_type        => ami type for instances, by default is "AL2_x86_64" .
      disk_size       => Disk size in GiB for worker nodes. Defaults to 20( optional )
}


]

- for labels and tags_for_node_groups :  
You must specify for each node group the vars,despite with values or not, for example we have 2 nodes groups:
 
labels = [{},{}]

tags_for_node_groups=[{},{}]

```



## Output Variables:

| name                                        | description                                |
|---------------------------------------------|--------------------------------------------|
| kubeconfig-certificate-authority-data       | Nested attribute for your cluster          |
| endpoint                                    | The endpoint for your Kubernetes API server|


## License:
```
                    GNU GENERAL PUBLIC LICENSE
                       Version 3, 29 June 2007

 Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
 Everyone is permitted to copy and distribute verbatim copies
 of this license document, but changing it is not allowed.

                            Preamble

  The GNU General Public License is a free, copyleft license for
software and other kinds of works.

  The licenses for most software and other practical works are designed
to take away your freedom to share and change the works.  By contrast,
the GNU General Public License is intended to guarantee your freedom to
share and change all versions of a program--to make sure it remains free
software for all its users.  We, the Free Software Foundation, use the
GNU General Public License for most of our software; it applies also to
any other work released this way by its authors.  You can apply it to
your programs, too.
```
