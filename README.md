# BunkCalc - Attendance Calculator

---

## Description
BunkCalc is a web application designed to help users calculate their attendance percentage and predict how many hours they need to attend to reach specific target percentages. It's deployed as a static website on Amazon S3, with all infrastructure managed as code using Terraform. This ensures automated and consistent provisioning of the S3 bucket, public access settings, and website configuration, simplifying the deployment process.

---

## Features
* Calculate current attendance percentage based on total and present hours.
* Factor in planned leave hours to see their impact on attendance.
* Predict hours needed to reach target attendance percentages (60%, 65%, 70%, 75%, 80%).
* User-friendly interface with clear instructions.

---

## Infrastructure as Code (IaC) & Hosting

This project leverages **Terraform** for Infrastructure as Code (IaC) to provision and manage the necessary AWS resources, ensuring repeatable and automated deployments. The application itself is hosted as a **static website on Amazon S3**.

### How it's Hosted

The `index.html` file, which contains the entire BunkCalc application (HTML, CSS, and JavaScript), is uploaded directly to an S3 bucket. Amazon S3's static website hosting feature is enabled for this bucket, allowing the `index.html` file to be served as the main document. Public read access is configured to make the website accessible.

### IaC (Terraform) Details

Terraform is used to define and manage the following AWS resources:

* **`aws_s3_bucket`**: Creates the S3 bucket that hosts the static website.
* **`aws_s3_bucket_ownership_controls`**: Sets the bucket ownership to `BucketOwnerPreferred`, which is a prerequisite for applying certain ACLs.
* **`aws_s3_bucket_public_access_block`**: Configures the public access block settings for the bucket, explicitly allowing public read access required for a static website.
* **`aws_s3_bucket_acl`**: Applies a `public-read` Access Control List to the bucket, making its contents publicly viewable.
* **`aws_s3_bucket_website_configuration`**: Enables static website hosting on the S3 bucket, specifying `index.html` as the index document.
* **`aws_s3_object`**: Uploads the `index.html` file to the S3 bucket, setting its content type and public-read ACL.

This approach ensures that the entire hosting environment can be consistently deployed and managed through code.

---

## Project Structure

* `main.tf`: Contains the Terraform configuration for deploying the S3 bucket, ACL, public access block, ownership controls, website configuration, and uploading the `index.html` file.
* `index.html`: The core HTML, CSS, and JavaScript file for the BunkCalc application.
* `terraform.tfstate`: (Generated after `terraform apply`) Stores the state of your deployed infrastructure.

---

## How to Run the Project (Local Development)

You can run and test the BunkCalc application directly on your local machine without deploying it to AWS.

1.  **Clone the Repository:**
    If you haven't already, clone this GitHub repository to your local machine:
    ```bash
    git clone [https://github.com/YOUR_USERNAME/BunkCalc.git](https://github.com/YOUR_USERNAME/BunkCalc.git)
    cd BunkCalc
    ```
2.  **Open `index.html`:**
    Locate the `index.html` file within the `BunkCalc` directory.
    Open this file in your preferred web browser (e.g., Chrome, Firefox, Edge).
    The application will load in your browser, and you can start using it immediately.

---

## Deployment Steps (to AWS S3 with Terraform)

### Prerequisites
Before you begin, ensure you have the following installed:

* **Terraform**: [Install Terraform](https://developer.hashicorp.com/terraform/downloads)
* **AWS CLI**: [Install AWS CLI](https://aws.amazon.com/cli/)
* **AWS Account**: An active AWS account with programmatic access configured.

### Steps

1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/YOUR_USERNAME/BunkCalc.git](https://github.com/YOUR_USERNAME/BunkCalc.git)
    cd BunkCalc
    ```

2.  **Configure AWS Credentials:**
    Make sure your AWS credentials are configured for Terraform. You can do this by setting environment variables (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`) or by configuring the AWS CLI with `aws configure`. The `provider.tf` file already specifies the `ap-south-1` region.

3.  **Initialize Terraform:**
    Run `terraform init` in your project directory to download the necessary AWS provider plugin:
    ```bash
    terraform init
    ```

4.  **Review the Plan:**
    Before applying any changes, it's good practice to review the execution plan. This will show you what Terraform will create, modify, or destroy:
    ```bash
    terraform plan
    ```

5.  **Apply Terraform Configuration:**
    If the plan looks good, apply the Terraform configuration to deploy your S3 bucket and static website:
    ```bash
    terraform apply
    ```
    Type `yes` when prompted to confirm the deployment.

6.  **Access Your Website:**
    Once Terraform successfully applies the configuration, it will output the `website_endpoint` for your S3 static website. You can access your BunkCalc application using this URL.

    You can find the website endpoint in the `terraform.tfstate` file under `aws_s3_bucket_website_configuration.bunkcalc.attributes.website_endpoint` or by checking the Terraform output after `terraform apply`.

    Example endpoint: `http://bunkcalctf2025.s3-website.ap-south-1.amazonaws.com`

---

## Contributing
Feel free to fork this repository, make improvements, and submit pull requests.

---

## License
This project is open-source and available under the MIT License.

---
