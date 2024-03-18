# RecipeSync -- a GitHub -> Workato deployment tool for LoanPro Integrations
# Author: Jaxon Adams

require_relative "lib/ui.rb"
require_relative "lib/ghclient.rb"
require_relative "config/config.rb"

module RecipeSync
    def self.deploy_python(ui)
        # gh_client = GitHubClient.new(ui)
        # gh_client.init

        settings = Configuration.new(ui, "./config/config.yaml")
        puts settings.config
    end

    def self.main
        ui = UserInterface.new
        ui.display_title

        # prompt user for what they'd like to do
        selection = ui.prompt_options [
            "Deploy a Python script.",  # more functionality will be added
        ]
        
        # this should be less verbose than a big if-else chain
        option_map = {
            "Deploy a Python script." => method(:deploy_python),
        }

        # if not nil, call the function; else exit the program
        option_map[selection] ? option_map[selection].(ui) : exit
    end
end

# !---------------------------------------------------------------------------
RecipeSync.main()
