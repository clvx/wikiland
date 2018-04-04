# EC2

∘ Virtual computing environments, known as instances.
∘ Preconfigured templates for your instances, known as Amazon Machine Images (AMIs).
∘ Various configurations of CPU, memory, storage, and networking capacity for your instances, known as instance types.
∘ Secure login information for your instances using key pairs.
∘ Storage volumes for temporary data that's deleted when you stop or terminate your instance, known as instance store volumes.
∘ Persistent storage volumes for your data using Amazon Elastic Block Store (Amazon EBS), known as Amazon EBS volumes.
∘ Multiple physical locations for your resources, known as regions and Availability Zones.
∘ A firewall that enables you to specify the protocols, ports, and source IP ranges that can reach your instances using security groups.
∘ Static IPv4 addresses for dynamic cloud computing, known as Elastic IP addresses.
∘ Metadata, known as tags, that you can create and assign to your Amazon EC2 resources.
∘ Pricing:
    ‣ On-Demand Instances: Pay for the instances that you use by the second, with no long-term commitments or upfront payments.
    ‣ Reserved Instances: Make a low, one-time, up-front payment for an instance, reserve it for a one- or three-year term, and pay a significantly lower hourly rate for these instances. 
    ‣ Spot Instances:  Request unused EC2 instances, which can lower your costs significantly.

∘ AMI:  
    ‣ Template that contains a software configuration.
    ‣  From an AMI, you launch an instance, which is a copy of the AMI running as a virtual server in the cloud.
    ‣ Your instances keep running until you stop or terminate them, or until they fail. 
    ‣ You have complete control of your instances; you can use sudo to run commands that require root privileges. 
    ‣ The root device for your instance contains the image used to boot the instance.
    ‣ An AMI includes the following:
        • A template for the root volume for the instance.
        • Launch permissions that control which AWS accounts can use the AMI to launch instances.
        • A block device mapping that specifies the volumes to attach to the instance when it's launched.
    ‣ AMI lifecycle: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/images/ami_lifecycle.png
    ‣ Creating your Own AMI:
        • You can launch an instance from an existing AMI, customize the instance, and then save this updated configuration as a custom AMI.
        • The root storage device of the instance determines the process you follow to create an AMI. 
    ‣ Instance store volumes are best used for temporary data. For important data, EBS or S3 are better alternatives.
    ‣ Security Best Practices:
        • Use IAM to control access to your AWS resources, including instances.
        • Restrict access by only allowing trusted hosts or networks to access ports on your instance.
        • Apply the principle of least privilege - only open up permissions that you require. 
        • Create a bastion security group that allows external login, and keep the remainder of your instances in a group that does not allow external logins. 
        • Disable password-based logins for instances launched from your AMI.
    ‣ Stopping an instance:
        • The instance goes to a stopped state. 
        • All of its EBS volumes remain attached. 
        • You can start the instance again at a later time. 
        • You are not charged for additional instance usage while the instance is in a stopped state. 
        • The EBS usage of your instance, including root device usage, is billed using typical Amazon EBS prices.
        • When an instance is in a stopped state, you can attach or detach EBS volumes, create an AMI from the instance, change the kernel, RAM disk, and instance type.
    ‣ Terminating an instance:
        •  The root device volume is deleted by default, but any EBS volumes are preserved by default.
        • The instance itself is deleted, and you can't start the instance again at a later time. 
    ‣ AMI Types:
        • You can select an AMI to use based on the following characteristics:
            ∘ Region
            ∘ Operating System
            ∘ Architecture
            ∘ Launch Permissions
                ‣ public: Any AWS account can launch.
                ‣ explicit: Specific AWS accounts can launch.
                ‣ implicit
            ∘ Storage for the Rood Device
        • Creating an Amazon EBS-Backed Linux AMI
            ∘  Start from an instance that you've launched from an existing Amazon EBS-backed Linux AMI.
            ∘ After you customize the instance to suit your needs, create and register a new AMI.
            ∘ During the AMI-creation process, Amazon EC2 creates snapshots of your instance's root volume and any other EBS volumes attached to your instance.
                ‣ You may find it more efficient to create snapshots of your volumes before creating your AMI.
            ∘ If any volumes attached to the instance are encrypted, the new AMI only launches successfully on instances that support Amazon EBS encryption. 
            ∘ After the process completes, you have a new AMI and snapshot created from the root volume of the instance.
            ∘ When you launch an instance using the new AMI, we create a new EBS volume for its root volume using the snapshot.
            ∘ Whole process: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/images/running-instance.png
        • Copying an AMI
            ∘ You can copy both Amazon EBS-backed AMIs and instance store-backed AMIs.
            ∘ You can copy encrypted AMIs and AMIs with encrypted snapshots.
            ∘ Copying a source AMI results in an identical but distinct target AMI with its own unique identifier.
                ‣  In the case of an Amazon EBS-backed AMI, each of its backing snapshots is, by default, copied to an identical but distinct target snapshot.
            ∘ AWS does not copy launch permissions, user-defined tags, or Amazon S3 bucket permissions from the source AMI to the new AMI.
            ∘ If you use an IAM user to copy an instance store-backed AMI, the user must have the following Amazon S3 permissions: 
                ‣ s3:CreateBucket
                ‣ s3:GetBucketAcl
                ‣ s3:ListAllMyBuckets
                ‣ s3:GetObject
                ‣ s3:PutObject
                ‣ s3:PutObjectAcl. 
            ∘ Copying between Regions:
                ‣ When you launch an instance from an AMI, it resides in the same region where the AMI resides.
                ‣ If you make changes to the source AMI and want those changes to be reflected in the AMIs in the target regions, you must recopy the source AMI to the target regions.
                ‣ https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/images/ami_copy.png
                ‣ When you first copy an instance store-backed AMI to a region, AWS creates an Amazon S3 bucket for the AMIs copied to that region. 
        • All instance store-backed AMIs that you copy to that region are stored in this bucket.
            ∘ Cross-Account AMI Copy
                ‣ Sharing an AMI does not affect the ownership of the AMI.
                ‣ The owning account is charged for the storage in the region. 
                ‣ If you copy an AMI that has been shared with your account, you are the owner of the target AMI in your account.
                ‣  The owner of the source AMI is charged standard Amazon EBS or Amazon S3 transfer fees, and you are charged for the storage of the target AMI in the destination region. 
                ‣ To copy an AMI that was shared with you from another account, the owner of the source AMI must grant you read permissions for the storage that backs the AMI, either the associated EBS snapshot (for an Amazon EBS-backed AMI) or an associated S3 bucket (for an instance store-backed AMI). 
        • Deregistering Your Linux AMI
            ∘ You can deregister an AMI when you have finished using it.
            ∘ After you deregister an AMI, you can't use it to launch new instances. 
            ∘ When you deregister an AMI, it doesn't affect any instances that you've already launched from the AMI.
            ∘ Amazon EBS-Backed AMI
                ‣ It doesn't affect the snapshot that was created for the root volume of the instance during the AMI creation process. You'll continue to incur storage costs for this snapshot.
                ‣ Cleaning process: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/images/ami_delete_ebs.png
            ∘ Instance Store-Backed AMI
                ‣ it doesn't affect the files that you uploaded to Amazon S3 when you created the AMI. You'll continue to incur usage costs for these files in Amazon S3.
                ‣ Cleaning process: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/images/ami_delete_instance_store.png

∘ Regions and Availability Zones:
    ‣ Regions:
        • Each region is a separate geographic area.
        • Each region is completely independent.
        • Each region has multiple, isolated locations known as Availability Zones.
        • Resources aren't replicated across regions unless you do so specifically.
        • You only see the resources tied to the region you've specified.
        • There is a charge for data transfer between regions. 
    ‣ Availability Zones:
        • An Availability Zone is represented by a region code followed by a letter identifier.
            ∘ us-east-1a
        • To ensure that resources are distributed across the Availability Zones for a region, we independently map Availability Zones to identifiers for each account.
            ∘ Your Availability Zone us-east-1a might not be the same location as us-east-1a for another account.
        • As Availability Zones grow over time, our ability to expand them can become constrained. If this happens, we might restrict you from launching an instance in a constrained Availability Zone unless you already have an instance in that Availability Zone.
    ‣ When you work with an instance using the command line interface or API actions, you must specify its regional endpoint.
    ‣ Migration an Instance to Another Availability Zone:
        • The migration process involves creating an AMI from the original instance, launching an instance in the new Availability Zone, and updating the configuration of the new instance.

∘ Root Device Volume:
    ‣ The root device volume contains the image used to boot the instance.
    ‣ You can choose between AMIs backed by Amazon EC2 instance store(S3/instance store) and AMIs backed by Amazon EBS(ebs).
    ‣ Instance Store-backend instances
        • Instances that use instance stores for the root device automatically have one or more instance store volumes available, with one volume serving as the root device volume.
        • When an instance is launched, the image that is used to boot the instance is copied to the root volume. 
        • Any data on the instance store volumes persists as long as the instance is running, but this data is deleted when the instance is terminated Any data on the instance store volumes persists as long as the instance is running, but this data is deleted when the instance is terminated.
        • https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/images/instance_store_backed_instance.png
    ‣ EBS-backed instances
        • Instances that use Amazon EBS for the root device automatically have an Amazon EBS volume attached.
        • When you launch an Amazon EBS-backed instance, we create an Amazon EBS volume for each Amazon EBS snapshot referenced by the AMI you use.
        • An Amazon EBS-backed instance can be stopped and later restarted without affecting data stored in the attached volumes.
        • Regularly back up your EBS volumes using Amazon EBS snapshots, and create an Amazon Machine Image (AMI) from your instance to save the configuration as a template for launching future instances.
        • Use separate Amazon EBS volumes for the operating system versus your data. Ensure that the volume with your data persists after instance termination.
        • Regularly test the process of recovering your instances and Amazon EBS volumes if they fail. 
        • https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/images/ebs_backed_instance.png


