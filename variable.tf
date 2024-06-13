variable "aws_region" {
  description = "This describe the region"
  type        = string
  

}
variable "ecr_repo" {
  description = "This defines the repository"
  type        = string
  

}
variable "aws_eks_cluster" {
  description = "This defines the eks cluster"
  type        = string
  

}
variable "aws_eks_node_group" {
  description = "This defines the eks cluster"
  type        = string
  default     = "node-group"

}



