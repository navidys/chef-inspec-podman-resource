#
# Copyright 2022, Navid Yaghoobi
#

# Change module if required
module Inspec::Resources
  class PodmanImage < Inspec.resource(1)
    include Inspec::Resources::PodmanObject

    name "podman_image"

    supports platform: "linux"

    desc "podman (daemonless container engine) image resource"

    example <<~EXAMPLE
      describe podman_image('docker.io/library/httpd:latest') do
        it { should exist }
      end
      
      describe podman_image(id: 'f4599081097a') do
        it { should exist }
      end

      describe "podman_image('docker.io/library/httpd:latest')" do
        its('id') { should_not eq '' }
        its('image') { should eq 'docker.io/library/httpd:latest' }
        its('repo') { should eq 'docker.io/library/httpd' }
        its('tag') { should eq 'latest' }
      end

    EXAMPLE


    def initialize(opts = {})
      skip_resource "The `podman_image` resource is not yet available on your OS." unless inspec.os.linux?
      # do sanitizion of input values
      o = opts.dup
      o = { image: opts } if opts.is_a?(String)
      @opts = sanitize_options(o)
    end

    def image
      "#{repo}:#{tag}" if object_info.entries.size == 1
    end 

    def repo
      object_info.repositories[0] if object_info.entries.size == 1
    end
    
    def tag
      object_info.tags[0] if object_info.entries.size == 1
    end

    def to_s
      "podman_image #{@opts[:id]}#{@opts[:image]}"
    end


    private

    def sanitize_options(opts)
      opts.merge!(parse_components_from_image(opts[:image]))

      # assume a "latest" tag if we don't have one
      opts[:tag] ||= "latest"

      # if the ID isn't nil and doesn't contain a hash indicator (indicated by the presence
      # of a colon, which separates the indicator from the actual hash), we assume it's sha256.
      opts[:id] = "sha256:" + opts[:id] unless opts[:id].nil? || opts[:id].include?(":")

      # Assemble/reassemble the image from the repo and tag
      opts[:image] = "#{opts[:repo]}:#{opts[:tag]}" unless opts[:repo].nil?

      # return the santized opts back to the caller
      opts
    end

    def object_info
      return @info if defined?(@info)

      opts = @opts
      @info = inspec.podman.images.where do
        (repository == opts[:repo] && tag == opts[:tag]) || (!id.nil? && !opts[:id].nil? && (id == opts[:id] || id.start_with?(opts[:id])))
      end
    end

  end
end
