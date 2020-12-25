output "display_remote" {
  value = data.terraform_remote_state.shared_services.*
}

output "rg_commonresourcegroup_name" {
  value = data.terraform_remote_state.shared_services.outputs.rg_commonresourcegroup_name
}

output "tls_private_key" { 
  value = tls_private_key.admin_ssh.private_key_pem 
}
