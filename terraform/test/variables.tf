# variable "access_key" {
#   description = "AWS Access Key"
#   type = string
# }

# variable "secret_key" {
#   description = "value"
#   type = string
# }

# variable "token" {
#   description = "value"
#   type = string
# }

variable "credentials_file" {
  description = "value"
  type = string
  default = "C:/Users/Quan/.aws/credentials"
}

variable "iam_role_arn" {
  description = "value"
  default = "arn:aws:iam::540789410226:role/LabRole"
}

variable "vpc_id" {
  description = "value"
  default = "vpc-062414db4b11adc72"
}

