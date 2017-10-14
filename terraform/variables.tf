
variable "access_key" {
}

variable "secret_key" {
}

variable "region" {
}

variable "ami" {
  default = "ami-8c3beef6"
}

variable "admin_ejabberd" {
  type    = "string"
  default = " "
}

variable "pass_ejabberd" {
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

variable "ejabberddomain" {
  type    = "string"
  default = "localhost"
}
