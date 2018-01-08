cluster.name: {{.Values.hermes_elasticsearch_cluster_name}}

node.master: true
node.data: true

path.data: /data/data
path.logs: /data/logs

network.host: 0.0.0.0
transport.host: 0.0.0.0
http.enabled: true
http.max_content_length: 500mb
xpack.security.enabled: false

bootstrap.memory_lock: true

discovery.zen.minimum_master_nodes: 1
