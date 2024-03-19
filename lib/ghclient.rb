# contains the class definition for a GitHub client, which allows
#   for interaction with GitHub through this program. This class
#   serves as a wrapper for GitHub's own `octokit` rubygem.

require "octokit"

class GitHubClient
    def initialize(ui, access_token)
        @ui = ui
        @client = Octokit::Client.new(access_token: access_token)
    end

    def read_remote(repo, fpath)
        # read a remote file from the given repository

        begin
            file_content = @client.contents(repo, path: fpath)
            script = Base64.decode64(file_content.content)
        rescue Octokit::NotFound
            puts "File '#{path}' not found in the repository '#{owner}/#{name}'."
            exit
        rescue Octokit::Error => e
            puts "Octokit error: #{e.message}"
            exit
        end

        script
    end
end
