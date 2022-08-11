variable "json" {
  type = string
  default = <<EOH
{
  "access_groups": [],
  "appid": {
    "keys": [
      "slz-appid-key"
    ],
    "name": "slz-appid",
    "resource_group": "sap-slz-service-rg",
    "use_appid": false,
    "use_data": false
  },
  "clusters": [],
  "enable_transit_gateway": true,
  "transit_gateway_connections": [
    "management",
    "workload"
  ],
  "transit_gateway_resource_group": "sap-slz-service-rg",
  "virtual_private_endpoints": [
    {
      "resource_group": "sap-slz-service-rg",
      "service_name": "cos",
      "service_type": "cloud-object-storage",
      "vpcs": [
        {
          "name": "management",
          "subnets": [
            "vpe-zone-1"
          ]
        },
        {
          "name": "workload",
          "subnets": [
            "vpe-zone-1"
          ]
        }
      ]
    }
  ],
  "service_endpoints": "private",
  "security_groups": [],
  "vpn_gateways": [
    {
      "connections": [],
      "name": "management-gateway",
      "resource_group": "sap-slz-management-rg",
      "subnet_name": "vpn-zone-1",
      "vpc_name": "management"
    }
  ],
  "atracker": {
    "collector_bucket_name": "atracker-sap-bucket",
    "receive_global_events": true,
    "resource_group": "sap-slz-service-rg",
    "add_route": true
  },
  "cos": [
    {
      "buckets": [
        {
          "endpoint_type": "public",
          "force_delete": true,
          "kms_key": "slz-atracker-key",
          "name": "atracker-sap-bucket",
          "storage_class": "standard"
        }
      ],
      "keys": [
        {
          "name": "cos-bind-key",
          "role": "Writer",
          "enable_HMAC": false
        }
      ],
      "name": "atracker-cos",
      "plan": "standard",
      "random_suffix": true,
      "resource_group": "sap-slz-service-rg",
      "use_data": false
    },
    {
      "buckets": [
        {
          "endpoint_type": "public",
          "force_delete": true,
          "kms_key": "slz-slz-key",
          "name": "management-bucket",
          "storage_class": "standard"
        },
        {
          "endpoint_type": "public",
          "force_delete": true,
          "kms_key": "slz-slz-key",
          "name": "workload-bucket",
          "storage_class": "standard"
        }
      ],
      "keys": [],
      "name": "cos",
      "plan": "standard",
      "random_suffix": true,
      "resource_group": "sap-slz-service-rg",
      "use_data": false
    }
  ],
  "iam_account_settings": {
    "enable": false
  },
  "key_management": {
    "keys": [
      {
        "key_ring": "slz-slz-ring",
        "name": "slz-slz-key",
        "root_key": true
      },
      {
        "key_ring": "slz-slz-ring",
        "name": "slz-atracker-key",
        "root_key": true
      },
      {
        "key_ring": "slz-slz-ring",
        "name": "slz-vsi-volume-key",
        "root_key": true
      }
    ],
    "name": "slz-slz-kms",
    "resource_group": "sap-slz-service-rg",
    "use_hs_crypto": false
  },
  "resource_groups": [
    {
      "create": true,
      "name": "sap-slz-service-rg",
      "use_prefix": true
    },
    {
      "create": true,
      "name": "sap-slz-management-rg",
      "use_prefix": true
    },
    {
      "create": true,
      "name": "sap-slz-workload-rg",
      "use_prefix": true
    }
  ],
  "secrets_manager": {
    "kms_key_name": null,
    "name": null,
    "resource_group": null,
    "use_secrets_manager": false
  },
  "network_cidr": "10.0.0.0/8",
  "vpcs": [
    {
      "address_prefixes": {
        "zone-1": [],
        "zone-2": [],
        "zone-3": []
      },
      "default_security_group_rules": [],
      "flow_logs_bucket_name": "management-bucket",
      "network_acls": [
        {
          "name": "management-acl",
          "rules": [
            {
              "action": "allow",
              "destination": "10.0.0.0/8",
              "direction": "inbound",
              "name": "allow-ibm-inbound",
              "source": "161.26.0.0/16"
            },
            {
              "action": "allow",
              "destination": "10.0.0.0/8",
              "direction": "inbound",
              "name": "allow-all-network-inbound",
              "source": "10.0.0.0/8"
            },
            { 
              "action": "allow",
              "destination": "10.0.0.0/8",
              "direction": "inbound",
              "name": "allow-all-ssh-inbound",
              "source": "0.0.0.0/0",
              "tcp": {
                "port_max": 22,
                "port_min": 22
              }
            },
            {
              "action": "allow",
              "destination": "0.0.0.0/0",
              "direction": "outbound",
              "name": "allow-all-outbound",
              "source": "0.0.0.0/0"
            }
          ]
        }
      ],
      "prefix": "management",
      "resource_group": "sap-slz-management-rg",
      "subnets": {
        "zone-1": [
          {
            "acl_name": "management-acl",
            "cidr": "10.10.10.0/24",
            "name": "vsi-zone-1",
            "public_gateway": false
          },
          {
            "acl_name": "management-acl",
            "cidr": "10.10.20.0/24",
            "name": "vpe-zone-1",
            "public_gateway": false
          },
          {
            "acl_name": "management-acl",
            "cidr": "10.10.30.0/24",
            "name": "vpn-zone-1",
            "public_gateway": false
          }
        ],
        "zone-2": null,
        "zone-3": null
      },
      "use_public_gateways": {
        "zone-1": false,
        "zone-2": false,
        "zone-3": false
      }
    },
    {
      "address_prefixes": {
        "zone-1": [],
        "zone-2": [],
        "zone-3": []
      },
      "default_security_group_rules": [],
      "flow_logs_bucket_name": "workload-bucket",
      "network_acls": [
        {
          "name": "workload-acl",
          "rules": [
            {
              "action": "allow",
              "destination": "10.0.0.0/8",
              "direction": "inbound",
              "name": "allow-ibm-inbound",
              "source": "161.26.0.0/16"
            },
            {
              "action": "allow",
              "destination": "10.0.0.0/8",
              "direction": "inbound",
              "name": "allow-all-network-inbound",
              "source": "10.0.0.0/8"
            },
            {
              "action": "allow",
              "destination": "0.0.0.0/0",
              "direction": "outbound",
              "name": "allow-all-outbound",
              "source": "0.0.0.0/0"
            }
          ]
        }
      ],
      "prefix": "workload",
      "resource_group": "sap-slz-workload-rg",
      "subnets": {
        "zone-1": [
          {
            "acl_name": "workload-acl",
            "cidr": "10.40.10.0/24",
            "name": "vsi-zone-1",
            "public_gateway": false
          },
          {
            "acl_name": "workload-acl",
            "cidr": "10.40.20.0/24",
            "name": "vpe-zone-1",
            "public_gateway": false
          }
        ],
        "zone-2": null,
        "zone-3": null
      },
      "use_public_gateways": {
        "zone-1": false,
        "zone-2": false,
        "zone-3": false
      }
    }
  ],
  "vsi": [
    {
      "boot_volume_encryption_key_name": "slz-vsi-volume-key",
      "image_name": "ibm-sles-12-4-amd64-sap-applications-2",
      "machine_type": "cx2-4x8",
      "name": "bastion-vsi",
      "resource_group": "sap-slz-management-rg",
      "enable_floating_ip": true,
      "security_group": {
        "name": "management",
        "rules": [
          {
            "direction": "inbound",
            "name": "allow-ibm-inbound",
            "source": "161.26.0.0/16"
          },
          {
            "direction": "inbound",
            "name": "allow-vpc-inbound",
            "source": "10.0.0.0/8"
          },
          {
            "direction": "inbound",
            "name": "allow-ssh-inbound",
            "source": "0.0.0.0/0",
            "tcp": {
              "port_max": 22,
              "port_min": 22
            }
          },
          {
            "direction": "outbound",
            "name": "allow-vpc-outbound",
            "source": "10.0.0.0/8"
          },
          {
            "direction": "outbound",
            "name": "allow-ibm-tcp-53-outbound",
            "source": "161.26.0.0/16",
            "tcp": {
              "port_max": 53,
              "port_min": 53
            }
          },
          {
            "direction": "outbound",
            "name": "allow-ibm-tcp-80-outbound",
            "source": "161.26.0.0/16",
            "tcp": {
              "port_max": 80,
              "port_min": 80
            }
          },
          {
            "direction": "outbound",
            "name": "allow-ibm-tcp-443-outbound",
            "source": "161.26.0.0/16",
            "tcp": {
              "port_max": 443,
              "port_min": 443
            }
          }
        ],
        "vpc_name": "management"
      },
      "ssh_keys": [
        "ssh-key"
      ],
      "subnet_names": [
        "vsi-zone-1"
      ],
      "vpc_name": "management",
      "vsi_per_subnet": 1
    },
    {
      "boot_volume_encryption_key_name": "slz-vsi-volume-key",
      "image_name": "ibm-sles-12-4-amd64-sap-applications-2",
      "machine_type": "cx2-4x8",
      "name": "services-vsi",
      "resource_group": "sap-slz-workload-rg",
      "security_group": {
        "name": "services",
        "rules": [
          {
            "direction": "inbound",
            "name": "allow-squid-inbound",
            "source": "0.0.0.0/0",
            "tcp": {
              "port_max": 3128,
              "port_min": 3128
            }
          },
          {
            "direction": "inbound",
            "name": "allow-nfs-outbound",
            "source": "0.0.0.0/0",
            "tcp": {
              "port_max": 2049,
              "port_min": 2049
            }
          },
          {
            "direction": "inbound",
            "name": "allow-ssh-inbound",
            "source": "0.0.0.0/0",
            "tcp": {
              "port_max": 22,
              "port_min": 22
            }
          },
          {
            "direction": "outbound",
            "name": "allow-nfs-inbound",
            "source": "0.0.0.0/0",
            "tcp": {
              "port_max": 2049,
              "port_min": 2049
            }
          },
          {
            "direction": "inbound",
            "name": "allow-ibm-inbound",
            "source": "161.26.0.0/16"
          },
          {
            "direction": "inbound",
            "name": "allow-vpc-inbound",
            "source": "10.0.0.0/8"
          },
          {
            "direction": "outbound",
            "name": "allow-vpc-outbound",
            "source": "10.0.0.0/8"
          },
          {
            "direction": "outbound",
            "name": "allow-ibm-tcp-53-outbound",
            "source": "161.26.0.0/16",
            "tcp": {
              "port_max": 53,
              "port_min": 53
            }
          },
          {
            "direction": "outbound",
            "name": "allow-ibm-tcp-80-outbound",
            "source": "161.26.0.0/16",
            "tcp": {
              "port_max": 80,
              "port_min": 80
            }
          },
          {
            "direction": "outbound",
            "name": "allow-ibm-tcp-443-outbound",
            "source": "161.26.0.0/16",
            "tcp": {
              "port_max": 443,
              "port_min": 443
            }
          }
        ],
        "vpc_name": "workload"
      },
      "ssh_keys": [
        "ssh-key"
      ],
      "subnet_names": [
        "vsi-zone-1"
      ],
      "vpc_name": "workload",
      "vsi_per_subnet": 1
    }
  ],
  "wait_till": "IngressReady"
}
EOH
}

locals { 
  jd = jsondecode(var.json != null ? var.json : "{}")
}

output "j" {
  value = local.jd
} 
