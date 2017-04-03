
variable "access_key" {
}

variable "secret_key" {
}

variable "region" {
}

variable "ami" {
  default = "ami-515de947"
}

variable "pass_ejabberd" {
  type    = "string"
  default = " "
}

variable "admin_ejabberd" {
  type    = "string"
  default = " "
}

variable "instance_count" {
  default = 0
}

variable "erlang_cookie" {
  type    = "string"
  default = "default"
}
