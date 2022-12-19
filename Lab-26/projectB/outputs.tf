output "server_standalone_ip" {
    value = module.server_standalone.web_server_public_ip
}

output "servers_loops_count_ip" {
    value = module.servers_loop_count[*].web_server_public_ip
}

output "servers_loop_foreach_ips" {
    value = values(module.servers_loop_foreach)[*].web_server_public_ip
}