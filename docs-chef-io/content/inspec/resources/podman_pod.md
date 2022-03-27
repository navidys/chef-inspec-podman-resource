+++
title = "podman_pod resource"
draft = false
gh_repo = "inspec"
platform = "linux"

[menu]
  [menu.inspec]
    title = "podman_pod"
    identifier = "inspec/resources/os/podman_pod.md podman_pod resource"
    parent = "inspec/resources/os"
+++

Use the `podman_pod` Chef InSpec audit resource to test the ...


## Availability

### Installation

This resource is distributed along with Chef InSpec itself. You can use it automatically.

## Syntax

A `podman_pod` Chef InSpec audit resource ...

    describe podman_pod do
      its('shoe_size') { should cmp 42 }
      it { should be_purple }
      it { should have_bells }
    end

## Properties


## Matchers

For a full list of available matchers, please visit our [matchers page](https://docs.chef.io/inspec/matchers/).


## Examples
The following examples show how to use this Chef InSpec audit resource.
