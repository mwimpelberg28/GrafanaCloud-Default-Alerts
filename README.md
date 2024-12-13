# Grafana Cloud Kubernetes, Redis, and Linux Alerts

This Terraform project sets up and configures Kubernetes, Redis, and Linux alerts in Grafana Cloud. It is designed to be simple and flexible, requiring only a few input variables to get started.

## Prerequisites

- Terraform v1.x.x

## Variables

The following input variables are required:

| Variable       | Description                                      | Example                |
|----------------|--------------------------------------------------|------------------------|
| `folder_uid`   | The UID of the folder to organize resources      | `abc123`               |
| `datasource_uid` | The UID of the datasource for monitoring         | `datasource_xyz`       |
| `contact_point` | The alert contact point for notifications        | `grafana-default-email`   |

## Usage

1. Clone this repository:

   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. Initialize Terraform:

   ```bash
   terraform init
   ```

3. Create a `terraform.tfvars` file and populate it with your values:

   ```hcl
   folder_uid      = "your-folder-uid"
   datasource_uid  = "your-datasource-uid"
   contact_point   = "your-contact@example.com"
   ```

4. Apply the configuration:

   ```bash
   terraform apply
   ```

   Review the plan and confirm to proceed.

5. Verify the deployment in your monitoring and alerting setup.

## Clean Up

To destroy the resources created by this configuration:

```bash
terraform destroy
```

Confirm the plan to remove all resources.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
