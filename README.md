ectou-metadata
==============

Yet another EC2 instance metadata mocking service.

[![Docker Repository on Quay](https://quay.io/repository/turner/ectou-metadata/status?token=f4f31852-6ad5-4f13-ab11-0783dc8bab44 "Docker Repository on Quay")](https://quay.io/repository/turner/ectou-metadata)


Goals
-----

Mock subset of the [`EC2 instance metadata`](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html) service to enable local virtual machine environments to assume IAM roles.


Usage
-----

```
ectou_metadata [--host host] [--port port] [--role-arn role_arn]
```


Docker
------

```yaml
version: "2"

services:
  app:
    image: my-app-that-uses-aws-role:1.0
    ports:
    - 80:3000

# aws role support 

  role:
    image: quay.io/turner/ectou-metadata
    ports:
    - 9000:80
    environment:

      # the role you want your container to assume
      ROLE: arn:aws:iam::123456789:role/my-role

      # the local profile you want to use to assume the role
      AWS_PROFILE: my-profile

    volumes:
    - $HOME/.aws/credentials:/root/.aws/credentials:ro
    networks:
      default:
        ipv4_address: 169.254.169.254

networks:
  default:
    driver: bridge
    ipam:
     config:
       - subnet: 169.254.169.0/16
         gateway: 169.254.169.1    

```


Dependencies
------------

- boto3 >= 1.2.0
- bottle >= 0.12.0
