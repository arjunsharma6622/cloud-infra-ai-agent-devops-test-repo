module "network" {
  source = "./modules/network"
}

module "security" {
  source = "./modules/security"
  vpc_id = module.network.vpc_id
}

module "database" {
  source             = "./modules/database"
  private_subnet_ids = module.network.private_subnet_ids
  rds_security_group_id = module.security.rds_security_group_id
  db_password        = var.db_password
}

module "compute" {
  source                = "./modules/compute"
  public_subnet_ids     = module.network.public_subnet_ids
  private_subnet_ids    = module.network.private_subnet_ids
  eks_security_group_id = module.security.eks_security_group_id
}