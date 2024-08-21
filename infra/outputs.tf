output "k8s-cluster-id" {
  value = oci_containerengine_cluster.k8s_cluster.id
}

output "public_subnet_id" {
  value = oci_core_subnet.vcn_public_subnet.id
}

output "node_pool_smart_id" {
  value = oci_containerengine_node_pool.k8s_node_pool_smart.id
}

output "node_pool_hound_id" {
  value = oci_containerengine_node_pool.k8s_node_pool_hound.id
}