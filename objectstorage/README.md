# ObjectStorage Terraform OTC Example

This script will create the following resources:
* aws\_s3\_bucket
* aws\_s3\_bucket\_object

## Description

This is a very simple example on how to use terraforms **aws\_s3** resources to access the OBS object storage provided by OTC.

## Available Variables

### Required

For more information on how to create and manage your access keys see:

[How Do I Manage Access Keys?](https://docs.otc.t-systems.com/en-us/usermanual/ac/en-us_topic_0046606340.html)

* **access\_key** (Your Access Key)
* **secret\_key** (Your Secret Key)
* **bucket\_name** (The (globally unique) bucket name)

### Optional
* **obs\_filename** (the file to upload to the object store, _default=sample.txt_)
