# prometheus-thanos
Prometheus setup with Thanos components that are ready to connect with Thanos Querier.
Supposed to use /opt/prometheus/ as working directory

- bot/ - Mounts inside tgbot container. Contains bot alerting message template and its db.
- conf/ - Mounts inside prometheus container. Contains prometheus confids and alerts/ containing alert rules.
