variable "json" {
  type = string
}

locals { 
  jd = jsondecode(var.json != null ? var.json : "{}")
}

output "j" {
  value = local.jd
} 
