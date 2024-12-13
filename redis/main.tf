resource "grafana_rule_group" "redis_rule_group" {
  org_id           = 1
  name             = "1m"
  folder_uid       = var.folder_uid
  interval_seconds = 60

  rule {
    name      = "RedisDown"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.contact_point
      model          = "{\"editorMode\":\"code\",\"expr\":\"redis_up{job=\\\"redis\\\"} == 0\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "C"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[0],\"type\":\"gt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"C\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "1m"
    annotations = {
      description = "Redis instance is down\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}"
      summary     = "Redis down (instance {{ $labels.instance }})"
    }
    is_paused = false

    notification_settings {
      contact_point = var.contact_point
      group_by      = null
      mute_timings  = null
    }
  }
  rule {
    name      = "RedisOutOfMemory"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.contact_point
      model          = "{\"editorMode\":\"code\",\"expr\":\"redis_memory_used_bytes{job=\\\"redis\\\"} / redis_total_system_memory_bytes{job=\\\"redis\\\"} * 100 > 90\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "C"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[0],\"type\":\"gt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"C\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "1m"
    annotations = {
      description = "Redis is running out of memory (> 90%)\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}"
      summary     = "Redis out of memory (instance {{ $labels.instance }})"
    }
    is_paused = false

    notification_settings {
      contact_point = var.contact_point
      group_by      = null
      mute_timings  = null
    }
  }
  rule {
    name      = "RedisTooManyConnections"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.contact_point
      model          = "{\"editorMode\":\"code\",\"expr\":\"redis_connected_clients{job=\\\"redis\\\"} > 100\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "C"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[0],\"type\":\"gt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"C\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "1m"
    annotations = {
      description = "Redis instance has too many connections\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}"
      summary     = "Redis too many connections (instance {{ $labels.instance }})"
    }
    is_paused = false

    notification_settings {
      contact_point = var.contact_point
      group_by      = null
      mute_timings  = null
    }
  }
  rule {
    name      = "RedisClusterSlotFail"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.contact_point
      model          = "{\"editorMode\":\"code\",\"expr\":\"redis_cluster_slots_fail{job=\\\"redis\\\"} > 0\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "C"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[0],\"type\":\"gt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"C\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "1m"
    annotations = {
      description = "Redis cluster has slots fail\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}"
      summary     = "Number of hash slots mapping to a node in FAIL state (instance {{ $labels.instance }})"
    }
    is_paused = false

    notification_settings {
      contact_point = var.contact_point
      group_by      = null
      mute_timings  = null
    }
  }
  rule {
    name      = "RedisClusterSlotPfail"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.contact_point
      model          = "{\"editorMode\":\"code\",\"expr\":\"redis_cluster_slots_pfail{job=\\\"redis\\\"} > 0\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "C"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[0],\"type\":\"gt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"C\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "1m"
    annotations = {
      description = "Redis cluster has slots pfail\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}"
      summary     = "Number of hash slots mapping to a node in PFAIL state (instance {{ $labels.instance }})"
    }
    is_paused = false

    notification_settings {
      contact_point = var.contact_point
      group_by      = null
      mute_timings  = null
    }
  }
  rule {
    name      = "RedisClusterStateNotOk"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.contact_point
      model          = "{\"editorMode\":\"code\",\"expr\":\"redis_cluster_state{job=\\\"redis\\\"} == 0\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
    }
    data {
      ref_id = "C"

      relative_time_range {
        from = 0
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[0],\"type\":\"gt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"C\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "1m"
    annotations = {
      description = "Redis cluster is not ok\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}"
      summary     = "Redis cluster state is not ok (instance {{ $labels.instance }})"
    }
    is_paused = false

    notification_settings {
      contact_point = var.contact_point
      group_by      = null
      mute_timings  = null
    }
  }
}
