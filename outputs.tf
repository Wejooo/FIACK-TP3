output "instance_id" {
  description = "ID de l'instance EC2"
  value       = aws_instance.web.id
}

output "instance_public_ip" {
  description = "IP publique de l'instance"
  value       = aws_instance.web.public_ip
}

output "ssh_command" {
  description = "Commande SSH pour se connecter à l'instance"
  value       = "ssh -i deployer-key.pem ec2-user@${aws_instance.web.public_ip}"
}

output "bucket_id" {
  description = "Identifiant du bucket S3"
  value       = aws_s3_bucket.demo_bucket.id
}

output "bucket_url" {
  description = "URL de l'objet uploadé"
  value       = "https://${aws_s3_bucket.demo_bucket.id}.s3.amazonaws.com/${aws_s3_object.demo_object.key}"
}
