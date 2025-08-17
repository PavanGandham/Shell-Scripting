# 🐚 Shell-Scripting Master Guide 📖

<p align="center">
  <img src="https://img.shields.io/badge/OpsCatalyst-DevOps-blue" alt="OpsCatalyst" />
  <img src="https://img.shields.io/badge/Shell-Bash-green" alt="Shell Bash" />
  <img src="https://img.shields.io/badge/License-MIT-yellow" alt="MIT License" />
</p>

<details>
<summary><strong>✨ Why This Repo?</strong></summary>

This is your one-stop shop for shell scripting mastery! Whether you're automating cloud, managing infrastructure, or just want to level up your Linux skills, this repo is packed with:
- Real-world scripts for DevOps, SRE, and sysadmin tasks
- Cloud automation (AWS, Azure)
- Infrastructure as Code (Terraform, Ansible)
- Docker & Kubernetes helpers
- Database utilities
- Bash programming exercises
- Cheat sheets & quick references
- Practice files for hands-on learning
</details>

```
            ▐▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▌
            ▐                                                                        ▌
            ▐               ███████╗██╗  ██╗███████╗██╗     ██╗                      ▌
            ▐               ██╔════╝██║  ██║██╔════╝██║     ██║                      ▌
            ▐               ███████╗███████║█████╗  ██║     ██║                      ▌
            ▐               ╚════██║██╔══██║██╔══╝  ██║     ██║                      ▌
            ▐               ███████║██║  ██║███████╗███████╗███████╗                 ▌
            ▐               ╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝                 ▌
            ▐                                                                        ▌
            ▐   ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗██╗███╗   ██╗ ██████╗    ▌
            ▐   ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝██║████╗  ██║██╔════╝    ▌
            ▐   ███████╗██║     ██████╔╝██║██████╔╝   ██║   ██║██╔██╗ ██║██║  ███╗   ▌
            ▐   ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║   ██║██║╚██╗██║██║   ██║   ▌
            ▐   ███████║╚██████╗██║  ██║██║██║        ██║   ██║██║ ╚████║╚██████╔╝   ▌
            ▐   ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝    ▌
            ▐                                                                        ▌
            ▐▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▌

                         🚀 Accelerate Your Shell Scripting Journey 
```

Welcome to the **Shell-Scripting Master📜** repository, proudly maintained by **The OpsCatalyst🧪** ! This project is a curated collection of Linux bash scripts and automation tools for DevOps, cloud, infrastructure, and everyday scripting tasks. Whether you're a beginner or an advanced user, you'll find practical scripts, cheat sheets, and guides to boost your productivity.

---

<p align="center">
  <img src="https://img.shields.io/badge/OpsCatalyst-DevOps-blue" alt="OpsCatalyst" />
  <img src="https://img.shields.io/badge/Shell-Bash-green" alt="Shell Bash" />
  <img src="https://img.shields.io/badge/License-MIT-yellow" alt="MIT License" />
</p>

---


## 📋 Table of Contents
1. [Project Overview](#project-overview)
2. [Folder Structure & Highlights](#folder-structure--highlights)
3. [References](#references)
4. [Contributing](#contributing)
5. [License](#license)

---


## 📖 Project Overview
This repository is a curated collection of shell scripts and automation tools for:
- **DevOps & SRE:** System monitoring, backups, health checks, security hardening, CI/CD helpers
- **Cloud Automation:** AWS (EC2, S3, ECS, AMI, Nitro), Azure resource scripts
- **Infrastructure as Code:** Terraform modules, Ansible playbook runners
- **Containers & Orchestration:** Docker management, Kubernetes (Helm, ArgoCD, RBAC, kops)
- **Database Utilities:** PostgreSQL scripts, sample data
- **Bash Programming:** Classic exercises (Fibonacci, Armstrong, Fractals, Math)
- **Cheat Sheets:** Bash, jq, tmux, vi editor
- **Practice & Learning:** Hands-on files for testing shell commands

---






## 📂 Folder Structure & Highlights

<details>
<summary>Click to expand folder structure</summary>

- **[Ansible/](./Ansible)** — Automation with Ansible playbooks and inventory
  - `ansible.sh`: Run and manage playbooks, inventory, and roles
- **[Aws/](./Aws)** — AWS CLI, EC2, S3, ECS, AMI, Nitro, and more
  - `ami/`: AMI management scripts
  - `cli/`: AWS CLI helpers
  - `ec2/`: EC2 instance automation
  - `ecr/`: ECR registry scripts
  - `ecs/`: ECS cluster and service scripts
  - `nitro_Instance/`: Nitro instance utilities
  - `s3/`: S3 bucket management
- **[Azure/](./Azure)** — Azure resource management and automation
  - `resources-script-1.sh`: Provision and manage Azure resources
- **[Bash-Programming/](./Bash-Programming)** — Classic bash programming exercises
  - `amstrong-number.sh`: Armstrong number check
  - `fibonacci.sh`: Fibonacci sequence generator
  - `fractal.sh`: Fractal pattern script
  - `mathematical-exprs.sh`: Math expressions evaluator
  - `n-numbers-average.sh`: Average calculator
  - `odd-natural-nums.sh`: Odd number generator
- **[Bash-Scripting/](./Bash-Scripting)** — Core bash scripting concepts and utilities
  - `arrays/`: Array operations
  - `awk/`: AWK usage examples
  - `conditions/`: Conditional logic scripts
  - `debug/`: Debugging helpers
  - `functions/`: Bash functions
  - `grep/`: Grep usage and patterns
  - `loops/`: Loop constructs
  - `miscellaneous/`: Misc scripts
  - `operators/`: Operator usage
  - `sed/`: Sed usage and patterns
- **[Cheatsheets/](./Cheatsheets)** — Quick reference scripts and images
  - `bash-cheatsheet.sh`: Bash quick reference
  - `jq-cheatsheet.sh`: jq quick reference
  - `tmux-cheat-sheet.webp`: tmux visual cheat sheet
  - `tmux-cheatsheet.webp`: tmux visual cheat sheet
  - `vi-editor-cheatsheet.txt`: vi editor cheat sheet
- **[Databases/](./Databases)** — PostgreSQL scripts and sample data
  - `postgres-data.sql`: Sample PostgreSQL data
  - `postgres-data-1.sql`: Sample PostgreSQL data
  - `postgresql.sh`: PostgreSQL management
- **[Docker/](./Docker)** — Docker management and orchestration
  - `docker-compose.sh`: Compose file automation
  - `docker-container-status.sh`: Container status checker
  - `docker.sh`: Docker helpers
- **[Kubernetes/](./Kubernetes)** — Kubernetes and cloud-native automation
  - `argocd_install.sh`: ArgoCD setup
  - `certbot-letsencrypt.sh`: Certbot for Let's Encrypt
  - `helm_install.sh`: Helm installation
  - `kops_cluster.sh`: kops cluster management
  - `kops_install.sh`: kops installer
  - `kubectl_install.sh`: kubectl installer
  - `kubens-kubectx_install.sh`: Namespace/context switchers
  - `kubernetes.sh`: General K8s helpers
  - `rbac.sh`: RBAC configuration
- **[Practice/](./Practice)** — Practice files and scripts for learning
  - `file-1`: Sample file
  - `file-2`: Sample file
  - `file-3`: Sample file
  - `mergedfile`: Merged output
  - `multi-file-line-copy.sh`: Multi-file line copy utility
  - `test.sh`: Test script
- **[Scripts/](./Scripts)** — Utility scripts for sysadmin, monitoring, backups, security, and more
  - `alert-memory.sh`: Memory alert
  - `archive-data.sh`: Data archiving
  - `backup.sh`: Backup utility
  - `cpu-load-monitor.sh`: CPU load monitor
  - `health-check.sh`: System health check
  - `jenkins-centos.sh`: Jenkins installer (CentOS)
  - `jenkins-ubuntu.sh`: Jenkins installer (Ubuntu)
  - `sonarqube-install.sh`: SonarQube setup
  - `ssl-tls-cert-generate.sh`: SSL/TLS cert generator
  - `nginx-install-amz-linux-2.sh`: Nginx installer
  - `user-sudo-access-check.sh`: Sudo access checker
  - ...many more utility scripts!
- **[Shell-Projects/](./Shell-Projects)** — Project-based shell scripts for real-world automation
  - `nginx-switchover.sh`: Nginx switchover automation
- **[Terraform/](./Terraform)** — Infrastructure as Code scripts using Terraform
  - `packer.sh`: Packer automation
  - `terraform.sh`: Terraform helpers
  - `tf-manual-test.sh`: Manual test script
</details>



## 🔗 References
- [Bash Scripting Guide](https://www.gnu.org/software/bash/manual/bash.html)
- [AWS CLI Documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)
- [Azure CLI Documentation](https://learn.microsoft.com/en-us/cli/azure/)
- [Docker Documentation](https://docs.docker.com/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Terraform Documentation](https://www.terraform.io/docs)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Ansible Documentation](https://docs.ansible.com/)

---


## 🤝 Contributing
Want to add your own scripts or improvements? Fork, star, and send a pull request! All contributions are welcome—let's build the ultimate shell scripting resource together.

---


## 📄 License
This project is licensed under the MIT License.