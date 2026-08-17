output "vpc_id" {
  value = module.network.vpc_id
}

output "eks_cluster_name" {
  value = module.compute.eks_cluster_name
}

output "db_instance_endpoint" {
  value = module.database.db_instance_endpoint
}