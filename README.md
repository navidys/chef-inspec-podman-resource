# Chef InSpec Podman Resource

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
    its('version') { should cmp >= '4.1.0' }
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

```
describe podman_container('apache01') do
    it { should exist }
    it { should be_running }
    its('id') { should_not eq '' }
    its('pod') { should eq '' }
    its('pod_name') { should eq '' }
    its('image') { should eq 'docker.io/library/httpd:latest' }
    its('repo') { should eq 'docker.io/library/httpd' }
    its('tag') { should eq 'latest' }
    its('ports') { should eq ["0.0.0.0:8890->80/tcp", " 0.0.0.0:8891->443/tcp"] }
    its('command') { should eq 'httpd-foreground' }
    its('labels') { should include 'app=httpd' }
end
      
describe podman_container(id: '74ea6842be22') do
    it { should exist }
    it { should be_running }
end
```

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