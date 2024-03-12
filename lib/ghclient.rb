# contains the class definition for a GitHub client, which allows
#   for interaction with GitHub through this program. This class
#   serves as a wrapper for GitHub's own `octokit` rubygem.

require "octokit"

class GitHubClient
    def initialize(ui)
        @ui = ui
    end

    def init
        # create and store a connection to GitHub.
        prompt = "Please enter your GitHub Personal Access Token."
        access_token = @ui.prompt_sensitive(prompt)

        puts access_token
    end
end
