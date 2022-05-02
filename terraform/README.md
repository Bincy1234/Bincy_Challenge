# Architecture

The terraform code creates the following resources
1) AWS Application Load balancer & AWS load balance listener

      Application Load Balancer act as a point of contact for the clients.
      It distributes traffic across two subnets in different availability zone.
      The Load balance listener checks for connection requests from clients, using the protocol and port that you configure. The Listener is configured with a self-signed cert for encrypting traffic between the client and the ALB. The ALB periodically checks the health of the instances so that the load balancer will send requests only to the healthy targets.

2) AWS Autoscaling Group

      The autoscaling group is responsible for maintaining the number of instances
      by performing periodic health checks on the instances in the group. If an
      instance becomes unhealthy, the group terminates the unhealthy instance and
      launches another instance and add them to the load balancer.


3) AWS Launch Configurations
    The launch configuration launches the EC2 instances. The launch configuration
    executes a user-data script when a new EC2 instance is spun up. The user-data
    downloads necessary tools and executes the ansible role `static_web_app` to
    dispaly HelloWorld.


4) AWS Security Groups
    Security Groups can add rules that control the inbound and outbound traffic to instances.

5  AWS key pairs
    key pair  is used for authentication while connecting to the instance.

6) AWS Cloudwatch Metric Alarm
    A Cloud Watch alarm will trigger a new instance if the CPU utilization is near 80%
    after 120 secs .The new instance launched is added to the application load balancer.



## Prerequistes

* Generate a self-signed certificate

  ```
  openssl req -x509 -nodes -days 1024 -newkey rsa:2048 -keyout server.key -out server.crt -config ssl.conf -extensions 'v3_req'

  ```
* Generate SSH RSA key pair

  ```
  ssh-keygen -t rsa -N "" -f $PWD/rsa-key

  ```
* Set credentials to communicate with AWS
    ```
    export AWS_ACCESS_KEY_ID=<access_key_id>
    export AWS_SECRET_ACCESS_KEY=<secret_access_key>

    ```
* Install AWS cli
* Upload certs to AWS IAM
  ```
  aws iam upload-server-certificate --server-certificate-name alb-cert-x509 --certificate-body file://server.crt --private-key file://server.key

  ```
  **output**
      ```
      {
        "ServerCertificateMetadataList": [
            {
                "Path": "/",
                "ServerCertificateName": "alb-x509",
                "ServerCertificateId": "ASCAEXAMPLE123EXAMPLE",
                "Arn": "< sample_arn >",
                "UploadDate": "2022-04-22T21:13:44+00:00",
                "Expiration": "2022-10-15T22:23:16+00:00"
            },
          }
      }

      ```
Set the terraform variable `TF_VAR_certificateID` with the value of Arn.
  export TF_VAR_certificateID=<sample_arn>    


## Steps to run

1) terraform init
2) terraform plan
3) terraform apply


## Testing

# Prerequistes

* Install stress package

  ```
  apt-get install stress

  ```

* Execute

```

stress --cpu 1 --timeout 240

```
