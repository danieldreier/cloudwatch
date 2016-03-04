#### puppet-cloudwatch puppet module

## Overview

This module installs the AWS CloudWatch log agent and provides a `cloudwatch::log` defined type for shipping logs into CloudWatch.

## Setup

### What cloudwatch affects
This will:
* install Amazon's log tailing agent and set up a service
* send any logs you've configured it to log into CloudWatch

### Setup Requirements

This will only work if you have IAM permissions configured to allow CloudWatch logs to be sent in from a given node. Consult the AWS docs for how to do that.

### Beginning with cloudwatch

```
puppet module install danieldreier-cloudwatch
puppet apply -e 'include ::cloudwatch'
puppet apply -e "cloudwatch::log {'/var/log/messages': }"
```

## Usage

Install the agent by including the `::cloudwatch` class, then specify which logs to include with `cloudwatch::log` resources, like the example above.
