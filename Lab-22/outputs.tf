output "instance_ids" {
    value = aws_instance.my_server[*].id  
}

output "instances_public_ips" {
    value = aws_instances.my_server[*].public_ip
}

output "server_id_ip_map" {
  value = {
        for x in aws_instance.my_server :
        x.id => x.public
    }
}

output "users_unique_id_arn" {
  value = [
    for user in aws_iam_user.user :
    "UserID: ${user.unique_id} has ARN: ${user.arn}"
  ]
}

output "users_unique_id_name_custom" {
  value = {
    for user in aws_iam_user.user :
    user.unique_id => user.name // "AIDA4BML4S5345K74HQFF" : "john"
    if length(user.name) < 7
  }
}
output "server_id_ip" {
    value = {
        for x in aws_instance.my_server
        "Server with Id:
    }
}
