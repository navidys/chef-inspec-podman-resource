+++
title = "podman_image resource"
draft = false
gh_repo = "inspec"
platform = "linux"

[menu]
  [menu.inspec]
    title = "podman_image"
    identifier = "inspec/resources/os/podman_image.md podman_image resource"
    parent = "inspec/resources/os"
+++

Use the `podman_image` Chef InSpec audit resource to test the ...


## Availability

### Installation

This resource is distributed along with Chef InSpec itself. You can use it automatically.

## Syntax

A `podman_image` Chef InSpec audit resource ...

    describe "podman_image('docker.io/library/httpd:latest')" do
      its('id') { should_not eq '' }
      its('image') { should eq 'docker.io/library/httpd:latest' }
      its('repo') { should eq 'docker.io/library/httpd' }
      its('tag') { should eq 'latest' }
    end


## Properties


## Matchers

For a full list of available matchers, please visit our [matchers page](https://docs.chef.io/inspec/matchers/).

## Examples

The following examples show how to use this Chef InSpec audit resource.
