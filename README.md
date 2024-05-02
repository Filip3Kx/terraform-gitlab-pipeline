# GitLab CI with Terraform

Simple pipeline to deploy your terraform code in an automated manner

## Pipeline

Here is a rundown of what the pipeline does before applying the terraform configuration to your infrastracture.

**1. Formatting check**
    
  Performs a `terraform fmt` command and fails if the formating is not valid when commiting.

**2. Terraform Validate**
    
  Performs a `terraform validate` command and fails if the configuration is not valid and raises any errors.

**3. Terraform Plan**
    
  Prepares a `terraform plan` that's displayed in the job logs as well as being saved in json format in the job artifacts and reports.

**4. Terraform Apply**
    
  `terraform apply` job only goes through after a manual start if everything seems right in the previous jobs.

---
## Docker Image

Using the official docker image from [gitlab.org](https://gitlab.com/gitlab-org/terraform-images) registry but creating a custom version from it.

Here is how to create a version you need

```bash
git clone https://gitlab.com/gitlab-org/terraform-images

#this will create a new repo and start a pipeline creating the images in the GitLab container registry
git push --set-upstream git@gitlab.com:{your_username}/{new_repo_name}
```

To build the versions of terraform binary you need into the image you need to change the `.gitlab-ci.yml` matrix that stores all the versions built

Example:
```yaml
.terraform-versions:
  parallel:
    matrix:
      - TERRAFORM_BINARY_VERSION: "1.4.7"
        TERRAFORM_VERSION: "1.4"
```

---
## Authentication

The pipeline uses a Service Account JSON key to authenticate to GCP in my case and it also supports impersonation for not automated testing

All you need to do is set a variable in your GitLab project that stores the key and retrives it during the job. In my example it's called `$GOOGLE_TF_SA_KEY`