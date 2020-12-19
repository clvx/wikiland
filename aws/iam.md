# IAM

    #create group
    aws iam create-group --group-name <group-name>
    #list groups
    aws aim list-groups
    #attach policy to groups
    aws iam attach-policy-group --group-name <group-name> --policy-arn <policy-arn>
    #list policies
    aws iam list-attached-group-policies --group-name <group-name>
    #create user
    aws iam create-user --user-name <username>
    #create login profile
    aws iam create-login-profile --user-name <username> --password <password>
    #programmatic access
    aws iam create-access-key --user-name <username>
    #add user to group
    aws iam add-user-to-group --group-name <group-name> --user-name <username>
    #create policy
    aws iam create-policy --policy-name <name> --description <description> --policy-document </path/to/policy.json>
    #attach policy to a user
    aws iam attach-user-policy --user-name <name> --policy-arn <policy-arn>

## Root account tasks

- Modify root user details.
- Chage your AWS support plan.
- Change or delete payment options.
- View your account billing info.
- Close an AWS account.
- Submit a Reverse DNS for amazon EC2 request.
- Sign up for GovCloud.
- Create a cloudfront key/pair.
- Transfer a Route 53 domain to another AWS account.
- Change the AWS EC2 setting for longer resource ID's.
- Submit a request to perform penetration testing on your AWS infrastructure using the web form.
- Request removal of the port 25 email throttle on your EC2 instance.
- Find your account canonical user ID.
- Reassinging permissions in a resource-based policy(such as an S3 bucket policy) 
that were revoked by explicitly denying IAM users access.
- Create an AWS created x.509 signing certificate.

## User

- Identities in IAM.
- A user can be in multiple groups.
- A user can be added or removed at any time.

## Groups

- It's not an identity in IAM.
- It cannot be nested.
- There's no default group.
- It can have multiple users.

## Policies
- All requests are denied by default.
- An explicit allow overrides this default.
- only the root user(by default) has access to all the resources in an account.
- Policies attached to a group assign permissions to the group's users.
- A policy can be attached to multiple groups.

### Identity based
- Managed policies
- Inline policies
    - Policy for a specific use case.

### Resource based policies
- Control what action the specified principal can perform on that resource in which conditions.
- They are inline policies.
- S3 bucket policies.
- EC2 policies.

### Structure

    {
        "version": "XXX",
        "Statement": {
            "Effect": "Allow|Deny",
            "Action": "Specific action",
            "Resource": "Object(s) that the statement covers",
            "Condition": "When this policy is in effect"
                "NotIpAddress": {
                    "aws:SourceIp: [
                        "192.168.1.0/24",
                        "192.168.2.0/24"
                    ]
                }
        }
    }

### Policy authorization
- When a principal makes a request in AWS, the IAM service checks wethere the principal is 
authenticated(signed in) and authorized(has permissions).
- IAM checks each policy that matches the context of the request. If a policy includes 
a denied action, IAM denies the entire requests and stops evaluation policies.

### Policy with S3 buckets
- Pilicies can be attached to S3 buckets.
- Policies can be attached to users and groups to manage access to S3 buckets.
- S3 model is a flat structure.
    - There's no hierarchy of sub-buckets or sub-folders.
    - You can emulate a folder hierarchy.
    - The S3 console can present a logical hierarchy with folders and sub-folders.
    - The trailing `/` in a S3 bucket simulates a tree structure.
- For a cross account permission, a bucker policy is needed.

## Roles
- A role is an identity.
- A role is not associated with a user.
- A role has temporary credentials.
    - Credentials are create dynamically.
- A role helps to delegate access to users, applications, or services to connect
to AWS resources in your accounts.

### Role types
- Service roles.
- Cross account roles.
    - Same account.
    - Third party accounts.
        - External ID is an optional piece of information that you can use in an IAM role 
        trust policy to designate who can assume that role.
        - Without using External ID another third party might be able to guess or 
        obtain the orle ARN.

### EC2 instance profile.
- Service role type.
- Container for IAM role that you could pass role information to an EC2 instance when 
an instance starts.
- No need to setup credentials in an EC2 instance.
- Roles created in the console will have the same name for the instance profile.


    aws iam create-instance-profile
    aws iam add-role-to-instance-profile
    aws iam list-instance-profiles
    aws iam get-instance-profile
    aws iam remove-role-from-instance-profile
    aws iam delete-instance-profile.

