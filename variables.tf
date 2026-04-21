variable "instance_type" {
  description = "Type d'instance EC2"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Nom de l'instance EC2"
  type        = string
  default     = "nginx-server"
}

variable "security_group_port" {
  description = "Port par défaut autorisé par le groupe de sécurité"
  type        = number
  default     = 80
}

variable "bucket_name" {
  description = "Nom du bucket S3"
  type        = string
  default     = "fiack-tp3-aremy-bucket"
}
