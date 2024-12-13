resource "grafana_rule_group" "linux_rule_group" {
  org_id           = 1
  name             = "1m"
  folder_uid       = var.folder_uid
  interval_seconds = 60

  rule {
    name      = "NodeNetworkReceiveErrs"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.datasource_uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"rate(node_network_receive_errs_total{job=~\\\"integrations/(node_exporter|unix)\\\"}[2m]) / rate(node_network_receive_packets_total{job=~\\\"integrations/(node_exporter|unix)\\\"}[2m]) > 0.01\\n\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
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
      description = "{{ $labels.instance }} interface {{ $labels.device }} has encountered {{ printf \"%.0f\" $value }} receive errors in the last two minutes."
      summary     = "Network interface is reporting many receive errors."
    }
    is_paused = false

    notification_settings {
      contact_point = var.contact_point
      group_by      = null
      mute_timings  = null
    }
  }
  rule {
    name      = "NodeNetworkTransmitErrs"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.datasource_uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"rate(node_network_transmit_errs_total{job=~\\\"integrations/(node_exporter|unix)\\\"}[2m]) / rate(node_network_transmit_packets_total{job=~\\\"integrations/(node_exporter|unix)\\\"}[2m]) > 0.01\\n\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
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
      description = "{{ $labels.instance }} interface {{ $labels.device }} has encountered {{ printf \"%.0f\" $value }} transmit errors in the last two minutes."
      summary     = "Network interface is reporting many transmit errors."
    }
    is_paused = false

    notification_settings {
      contact_point = var.contact_point
      group_by      = null
      mute_timings  = null
    }
  }
  rule {
    name      = "NodeHighNumberConntrackEntriesUsed"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.datasource_uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"(node_nf_conntrack_entries{job=~\\\"integrations/(node_exporter|unix)\\\"} / node_nf_conntrack_entries_limit) > 0.75\\n\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
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
      description = "{{ $value | humanizePercentage }} of conntrack entries are used."
      summary     = "Number of conntrack are getting close to the limit."
    }
    is_paused = false

    notification_settings {
      contact_point = var.contact_point
      group_by      = null
      mute_timings  = null
    }
  }
  rule {
    name      = "NodeTextFileCollectorScrapeError"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.datasource_uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"node_textfile_scrape_error{job=~\\\"integrations/(node_exporter|unix)\\\"} == 1\\n\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
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
      description = "Node Exporter text file collector on {{ $labels.instance }} failed to scrape."
      summary     = "Node Exporter text file collector failed to scrape."
    }
    is_paused = false

    notification_settings {
      contact_point = var.contact_point
      group_by      = null
      mute_timings  = null
    }
  }
  rule {
    name      = "NodeClockSkewDetected"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.datasource_uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"(\\n  node_timex_offset_seconds{job=~\\\"integrations/(node_exporter|unix)\\\"} > 0.05\\nand\\n  deriv(node_timex_offset_seconds{job=~\\\"integrations/(node_exporter|unix)\\\"}[5m]) >= 0\\n)\\nor\\n(\\n  node_timex_offset_seconds{job=~\\\"integrations/(node_exporter|unix)\\\"} < -0.05\\nand\\n  deriv(node_timex_offset_seconds{job=~\\\"integrations/(node_exporter|unix)\\\"}[5m]) <= 0\\n)\\n\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
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
      description = "Clock at {{ $labels.instance }} is out of sync by more than 0.05s. Ensure NTP is configured correctly on this host."
      summary     = "Clock skew detected."
    }
    is_paused = false

    notification_settings {
      contact_point = var.contact_point
      group_by      = null
      mute_timings  = null
    }
  }
  rule {
    name      = "NodeClockNotSynchronising"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.datasource_uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"min_over_time(node_timex_sync_status{job=~\\\"integrations/(node_exporter|unix)\\\"}[5m]) == 0\\nand\\nnode_timex_maxerror_seconds{job=~\\\"integrations/(node_exporter|unix)\\\"} >= 16\\n\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
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
      description = "Clock at {{ $labels.instance }} is not synchronising. Ensure NTP is configured on this host."
      summary     = "Clock not synchronising."
    }
    is_paused = false

    notification_settings {
      contact_point = var.contact_point
      group_by      = null
      mute_timings  = null
    }
  }
  rule {
    name      = "NodeRAIDDegraded"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.datasource_uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"node_md_disks_required{job=~\\\"integrations/(node_exporter|unix)\\\",device!=\\\"\\\"} - ignoring (state) (node_md_disks{state=\\\"active\\\",job=~\\\"integrations/(node_exporter|unix)\\\",device!=\\\"\\\"}) > 0\\n\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
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
      description = "RAID array '{{ $labels.device }}' at {{ $labels.instance }} is in degraded state due to one or more disks failures. Number of spare drives is insufficient to fix issue automatically."
      summary     = "RAID Array is degraded."
    }
    is_paused = false

    notification_settings {
      contact_point = var.contact_point
      group_by      = null
      mute_timings  = null
    }
  }
  rule {
    name      = "NodeRAIDDiskFailure"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.datasource_uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"node_md_disks{state=\\\"failed\\\",job=~\\\"integrations/(node_exporter|unix)\\\",device!=\\\"\\\"} > 0\\n\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
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
      description = "At least one device in RAID array at {{ $labels.instance }} failed. Array '{{ $labels.device }}' needs attention and possibly a disk swap."
      summary     = "Failed device in RAID array."
    }
    is_paused = false

    notification_settings {
      contact_point = var.contact_point
      group_by      = null
      mute_timings  = null
    }
  }
  rule {
    name      = "NodeFileDescriptorLimit"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.datasource_uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"(\\n  node_filefd_allocated{job=~\\\"integrations/(node_exporter|unix)\\\"} * 100 / node_filefd_maximum{job=~\\\"integrations/(node_exporter|unix)\\\"} > 70\\n)\\n\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
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
      description = "File descriptors limit at {{ $labels.instance }} is currently at {{ printf \"%.2f\" $value }}%."
      summary     = "Kernel is predicted to exhaust file descriptors limit soon."
    }
    is_paused = false

    notification_settings {
      contact_point = var.contact_point
      group_by      = null
      mute_timings  = null
    }
  }
  rule {
    name      = "NodeCPUHighUsage"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.datasource_uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"sum without(mode) (avg without (cpu) (rate(node_cpu_seconds_total{job=~\\\"integrations/(node_exporter|unix)\\\", mode!=\\\"idle\\\"}[2m]))) * 100 > 90\\n\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
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
      description = "CPU usage at {{ $labels.instance }} has been above 90% for the last 15 minutes, is currently at {{ printf \"%.2f\" $value }}%."
      summary     = "High CPU usage."
    }
    is_paused = false

    notification_settings {
      contact_point = var.contact_point
      group_by      = null
      mute_timings  = null
    }
  }
  rule {
    name      = "NodeSystemSaturation"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.datasource_uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"node_load1{job=~\\\"integrations/(node_exporter|unix)\\\"}\\n/ count without (cpu, mode) (node_cpu_seconds_total{job=~\\\"integrations/(node_exporter|unix)\\\", mode=\\\"idle\\\"}) > 2\\n\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
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
      description = "System load per core at {{ $labels.instance }} has been above 2 for the last 15 minutes, is currently at {{ printf \"%.2f\" $value }}."
      summary     = "System saturated, load per core is very high."
    }
    is_paused = false

    notification_settings {
      contact_point = var.contact_point
      group_by      = null
      mute_timings  = null
    }
  }
  rule {
    name      = "NodeMemoryMajorPagesFaults"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.datasource_uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"rate(node_vmstat_pgmajfault{job=~\\\"integrations/(node_exporter|unix)\\\"}[5m]) > 500\\n\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
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
      description = "Memory major pages are occurring at very high rate at {{ $labels.instance }}, 500 major page faults per second for the last 15 minutes, is currently at {{ printf \"%.2f\" $value }}."
      summary     = "Memory major page faults are occurring at very high rate."
    }
    is_paused = false

    notification_settings {
      contact_point = var.contact_point
      group_by      = null
      mute_timings  = null
    }
  }
  rule {
    name      = "NodeMemoryHighUtilization"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.datasource_uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"100 - (node_memory_MemAvailable_bytes{job=~\\\"integrations/(node_exporter|unix)\\\"} / node_memory_MemTotal_bytes{job=~\\\"integrations/(node_exporter|unix)\\\"} * 100) > 90\\n\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
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
      description = "Memory is filling up at {{ $labels.instance }}, has been above 90% for the last 15 minutes, is currently at {{ printf \"%.2f\" $value }}%."
      summary     = "Host is running out of memory."
    }
    is_paused = false

    notification_settings {
      contact_point = var.contact_point
      group_by      = null
      mute_timings  = null
    }
  }
  rule {
    name      = "NodeDiskIOSaturation"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.datasource_uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"rate(node_disk_io_time_weighted_seconds_total{job=~\\\"integrations/(node_exporter|unix)\\\", device!=\\\"\\\"}[5m]) > 10\\n\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
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
      description = "Disk IO queue (aqu-sq) is high on {{ $labels.device }} at {{ $labels.instance }}, has been above 10 for the last 15 minutes, is currently at {{ printf \"%.2f\" $value }}."
      summary     = "Disk IO queue is high."
    }
    is_paused = false

    notification_settings {
      contact_point = var.contact_point
      group_by      = null
      mute_timings  = null
    }
  }
  rule {
    name      = "NodeSystemdServiceFailed"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.datasource_uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"node_systemd_unit_state{job=~\\\"integrations/(node_exporter|unix)\\\", state=\\\"failed\\\"} == 1\\n\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
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
      description = "Systemd service {{ $labels.name }} has entered failed state at {{ $labels.instance }}"
      summary     = "Systemd service has entered failed state."
    }
    is_paused = false

    notification_settings {
      contact_point = var.contact_point
      group_by      = null
      mute_timings  = null
    }
  }
  rule {
    name      = "NodeSystemdServiceCrashlooping"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.datasource_uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"increase(node_systemd_service_restart_total{job=~\\\"integrations/(node_exporter|unix)\\\"}[5m]) > 2\\n\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
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
      description = "Systemd service {{ $labels.name }} has been restarted too many times at {{ $labels.instance }} for the last 15 minutes. Please check if service is crash looping."
      summary     = "Systemd service keeps restaring, possibly crash looping."
    }
    is_paused = false

    notification_settings {
      contact_point = var.contact_point
      group_by      = null
      mute_timings  = null
    }
  }
  rule {
    name      = "NodeFilesystemAlmostOutOfSpace"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.datasource_uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"(\\n  node_filesystem_avail_bytes{job=~\\\"integrations/(node_exporter|unix)\\\",fstype!=\\\"\\\",mountpoint!=\\\"\\\"} / node_filesystem_size_bytes{job=~\\\"integrations/(node_exporter|unix)\\\",fstype!=\\\"\\\",mountpoint!=\\\"\\\"} * 100 < 5\\nand\\n  node_filesystem_readonly{job=~\\\"integrations/(node_exporter|unix)\\\",fstype!=\\\"\\\",mountpoint!=\\\"\\\"} == 0\\n)\\n\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
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
      description = "Filesystem on {{ $labels.device }}, mounted on {{ $labels.mountpoint }}, at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available space left."
      summary     = "Filesystem has less than 5% space left."
    }
    is_paused = false

    notification_settings {
      contact_point = var.contact_point
      group_by      = null
      mute_timings  = null
    }
  }
  rule {
    name      = "NodeFilesystemFilesFillingUp"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.datasource_uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"(\\n  node_filesystem_files_free{job=~\\\"integrations/(node_exporter|unix)\\\",fstype!=\\\"\\\",mountpoint!=\\\"\\\"} / node_filesystem_files{job=~\\\"integrations/(node_exporter|unix)\\\",fstype!=\\\"\\\",mountpoint!=\\\"\\\"} * 100 < 40\\nand\\n  predict_linear(node_filesystem_files_free{job=~\\\"integrations/(node_exporter|unix)\\\",fstype!=\\\"\\\",mountpoint!=\\\"\\\"}[6h], 24*60*60) < 0\\nand\\n  node_filesystem_readonly{job=~\\\"integrations/(node_exporter|unix)\\\",fstype!=\\\"\\\",mountpoint!=\\\"\\\"} == 0\\n)\\n\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
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
      description = "Filesystem on {{ $labels.device }}, mounted on {{ $labels.mountpoint }}, at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available inodes left and is filling up."
      summary     = "Filesystem is predicted to run out of inodes within the next 24 hours."
    }
    is_paused = false

    notification_settings {
      contact_point = var.contact_point
      group_by      = null
      mute_timings  = null
    }
  }
  rule {
    name      = "NodeFilesystemAlmostOutOfFiles"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.datasource_uid
      model          = "{\"editorMode\":\"code\",\"expr\":\"(\\n  node_filesystem_files_free{job=~\\\"integrations/(node_exporter|unix)\\\",fstype!=\\\"\\\",mountpoint!=\\\"\\\"} / node_filesystem_files{job=~\\\"integrations/(node_exporter|unix)\\\",fstype!=\\\"\\\",mountpoint!=\\\"\\\"} * 100 < 5\\nand\\n  node_filesystem_readonly{job=~\\\"integrations/(node_exporter|unix)\\\",fstype!=\\\"\\\",mountpoint!=\\\"\\\"} == 0\\n)\\n\",\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\"}"
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
      description = "Filesystem on {{ $labels.device }}, mounted on {{ $labels.mountpoint }}, at {{ $labels.instance }} has only {{ printf \"%.2f\" $value }}% available inodes left."
      summary     = "Filesystem has less than 5% inodes left."
    }
    is_paused = false

    notification_settings {
      contact_point = var.contact_point
      group_by      = null
      mute_timings  = null
    }
  }
}
