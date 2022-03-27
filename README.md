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