output "instance_ids" {
    value = aws_instance.my_server[*].id  
}

output "instances_public_ips" {
    value = aws_instances.my_server[*].public _ip
}

output "server_id_ip" {
    value = {
        for x in aws_instance.my_server
        "Server with Id:
    }
}