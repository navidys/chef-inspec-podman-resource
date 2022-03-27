# inspec-podman-resource
Chef InSpec Podman Resource

----
## Resources

| resource name    | description |
| ---------------- | ----------- |
| podman           | retrieves information about podman
| podman_pod       | retrieves information about podman pods
| podman_container | retrieves information about podman containers
| podman_image     | retrieves information about podman images

----

## Examples

### podman

```
describe podman.version do
    its('Version') { should cmp >= '3.4.4' }
end

describe podman.pods do
    its('names') { should include 'pod01' }
end

```
### podman_pod

```
describe podman_pod('webserver') do
    it { should exist }
    it { should be_running }
    its('id') { should_not eq '' }
    its('infra_id') { should_not eq '' }
    its('cgroup') { should eq 'user.slice' }
    its('containers') { should include '9af79b3463e5' }
    its('labels') { should include 'app=httpd' }
end

describe podman_pod(id: 'fa4c0bbdfe84') do
    it { should exist }
    it { should be_running }
end
```

### podman_container


### podman_image

```
describe podman_image(id: 'f4599081097a') do
    it { should exist }
end

describe "podman_image('docker.io/library/httpd:latest')" do
    its('id') { should_not eq '' }
    its('image') { should eq 'docker.io/library/httpd:latest' }
    its('repo') { should eq 'docker.io/library/httpd' }
    its('tag') { should eq 'latest' }
end
```