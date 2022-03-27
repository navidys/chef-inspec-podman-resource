#
# Copyright 2022, Navid Yaghoobi
#

# Change module if required
module Inspec::Resources
  class PodmanPod < Inspec.resource(1)
    include Inspec::Resources::PodmanObject

    name "podman_pod"

    supports platform: "linux"

    desc "A resource to retrieve information about podman pods"

    example <<~EXAMPLE
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
    EXAMPLE

    def initialize(opts = {})
      skip_resource "The `podman_pod` resource is not yet available on your OS." unless inspec.os.linux?
      # if a string is provided, we expect it is the name
      if opts.is_a?(String)
        @opts = { name: opts }
      else
        @opts = opts
      end
    end

    def running?
      status.downcase.start_with?("running") if object_info.entries.length == 1
    end

    def status
      object_info.status[0] if object_info.entries.length == 1
    end

    def containers
      cntlist = []
      object_info.containers[0].each { |cnt| cntlist.append(cnt["Id"][0..11]) } if object_info.entries.length == 1
      cntlist
    end

    def labels
      object_info.labels
    end

    def cgroup
      object_info.cgroups[0] if object_info.entries.length == 1
    end

    def infra_id
      object_info.infraids[0] if object_info.entries.length == 1
    end

    def resource_id
      @opts[:name] || @opts[:id]
    end

    def to_s
      "podman_pod #{resource_id}"
    end

    private

    def object_info
      return @info if defined?(@info)

      opts = @opts
      @info = inspec.podman.pods.where { name == opts[:name] || (!id.nil? && !opts[:id].nil? && (id == opts[:id] || id.start_with?(opts[:id]))) }
    end

  end
end
