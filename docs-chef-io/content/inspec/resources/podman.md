+++
title = "podman resource"
draft = false
gh_repo = "inspec"
platform = "linux"

[menu]
  [menu.inspec]
    title = "podman"
    identifier = "inspec/resources/os/podman.md podman resource"
    parent = "inspec/resources/os"
+++

Use the `podman` Chef InSpec audit resource to test configuration datga for the Podman (daemonless container engine).


## Availability

### Installation

This resource is distributed along with Chef InSpec itself. You can use it automatically.

## Syntax

A `podman` Chef InSpec audit resource ...

      describe podman.version do
        its('Version') { should cmp >= '3.4.4' }
      end

      describe podman.pods do
        its('names') { should include 'pod01' }
      end
      
      describe podman.containers do
        its('images') { should_not include 'httpd:latest' }
      end

      describe podman.images do
        its('repositories') { should include 'registry.fedoraproject.org/fedora' }
      end

## Properties


## Matchers

For a full list of available matchers, please visit our [matchers page](https://docs.chef.io/inspec/matchers/).


## Examples

The following examples show how to use this Chef InSpec audit resource.


