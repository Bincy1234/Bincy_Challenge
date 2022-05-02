## Static Web Application

This project host a static web page with the following content on [AWS]
(https://aws.amazon.com/getting-started/).

  ```

  <html>
  <head>
  <title>Hello World</title>
  </head>
  <body>
  <h1>Hello World!</h1>
  </body>
  </html>

  ```
  * The creation and deployment of the application done with [Ansible](https://www.ansible.com/).
    For the configuration details visit [projects Ansible README.md](ansible/README.md)

  * The entire scalable and self healing infrastructure of the Web Server is
    maintained as code using [Terraform](https://www.terraform.io/).
    For the setup instructions visit [projects Terraform README.md](terraform/README.md)
