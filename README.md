chefserver README
==================

This cookbooks configures a system to be a *standalone* Chef Server. It
will install the appropriate platform-specific chef-server Omnibus
package from Package Cloud and perform the initial configuration.

This also install and configures opscode addons manage, reporting and push-server

Requirements
============

This cookbook is tested with  Chef (client) 12. It may work with or
without modification on earlier versions of Chef, but Chef 12 is
recommended.

## Cookbooks

* apt
* apt-chef
* chef-server
* chef-ingredient
* packagecloud
* yum
* yum-chef

## Platform

This cookbook is tested on the following platforms.

- Ubuntu 12.04.5 64-bit

Install Methods
===============

## Bootstrap Chef (server) with Chef (solo)

The easiest way to get a Chef Server up and running is to install
chef-solo (via the chef-client Omnibus packages) and bootstrap the
system using this script:

    # install chef-server
    https://github.com/ravibhure/chefserver/blob/master/setup.sh


This script will install and setup opscode chefserver for you with addons to access
your chefserver.

    Chef URL : https://<fqdn>
    Default Username : admin
    Default Password : ubuntu


# License and Authors

* Author: Ravi Bhure <ravibhure@gmail.com>

```text
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
```
