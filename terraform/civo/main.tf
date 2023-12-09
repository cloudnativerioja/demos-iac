# Create a firewall
resource "civo_firewall" "tf-controller-firewall" {
    name = "tf-controller-firewall"
}

# Create a firewall rule
resource "civo_firewall_rule" "kubernetes" {
    firewall_id = civo_firewall.tf-controller-firewall.id
    protocol = "tcp"
    start_port = "6443"
    end_port = "6443"
    cidr = ["0.0.0.0/0"]
    direction = "ingress"
    label = "kubernetes-api-server"
    action = "allow"
}

# Create a cluster with k3s
resource "civo_kubernetes_cluster" "my-cluster" {
    name = "tf-controller-cluster"
    firewall_id = civo_firewall.tf-controller-firewall.id
    cluster_type = "k3s"
    pools {
        label = "LaRiojaRocks" // Optional
        size = element(data.civo_size.xsmall.sizes, 0).name
        node_count = 3
    }
}
