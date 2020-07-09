
variable "key_name" {
  type = string
}

variable "image_id" {
  type    = string
  default = "ami-052c08d70def0ac62" # Asia Mumbai
}

variable "region" {
  type    = string
  default = "ap-south-1"
}