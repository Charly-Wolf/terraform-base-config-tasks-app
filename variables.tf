variable "bucket_name" {
  type        = string
  description = "Name of the bucket."
  default     = "cardp-tasks-frontend-bucket"
}
variable "region" {
  type        = string
  description = "Default AWS region."
  default     = "us-east-1"
}
variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}