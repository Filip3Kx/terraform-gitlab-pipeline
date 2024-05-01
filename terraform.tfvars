terraform_service_account = ""
not_impersonate = null
gcp_info = {
    project = "caramel-compass-393820"
    region = "europe-west1"
    zone = "europe-west1-b"
}

instance_info = {
    machine_type = "n1-standard-1"
    image_family = "debian-11"
    image_project = "debian-cloud"
}

instance_tags = ["allow-ssh", "allow-http", "terraform-tp"]

autoscaler_info = {
    max_replicas = 5
    min_replicas = 2
    cooldown_period = 60
    cpu_utilization_target = 0.5
}

lb_tags = ["terraform-tp"]
lb_port = 80
