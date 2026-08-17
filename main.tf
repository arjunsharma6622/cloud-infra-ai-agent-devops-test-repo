module "network" {
  source = "./modules/network"
}

module "security" {
  source = "./modules/security"
  vpc_id = module.network.vpc_id
}

module "database" {
  source               = "./modules/database"
  db_subnet_ids        = module.network.private_subnet_ids
  db_security_group_id = module.security.db_sg_id
}

module "compute" {
  source             = "./modules/compute"
  private_subnet_ids = module.network.private_subnet_ids
  eks_node_sg_id     = module.security.eks_node_sg_id
  eks_iam_role_arn   = module.security.eks_node_role_arn
}