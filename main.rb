# RecipeSync -- a GitHub -> Workato deployment tool for LoanPro Integrations
# Author: Jaxon Adams

require_relative "lib/ui.rb"
require_relative "lib/ghclient.rb"
require_relative "lib/wkclient.rb"
require_relative "config/config.rb"

module RecipeSync
    def self.deploy_python(ui)
        settings = Configuration.new(ui, "./config/config.yaml")

        access_token = settings.config["github"]["personal_access_token"]
        gh_client = GitHubClient.new(ui, access_token)

        workato_key = settings.config["workato"]["api_key"]
        wk_client = WorkatoClient.new(ui, workato_key)

        owner = ui.prompt("Please enter the owner of your repository.")
        name = ui.prompt("Please enter the repository name.")
        path = ui.prompt("What file should I read? Please enter a relative path.")

        code = gh_client.read_remote("#{owner}/#{name}", path)

        # sample recipe id: 45459373 (dev workspace)
        recipe_id = ui.prompt("Please enter the ID of the recipe you'd like to update.")
        step = ui.prompt("Please enter the step number for your Python step.")

        update_status = wk_client.update_code_step(recipe_id, step, code)
    end

    def self.main
        ui = UserInterface.new
        ui.display_title

        # menu of options -- each is a callable function
        option_map = {
            "Deploy a Python script." => method(:deploy_python),
        }

        # prompt user for what they'd like to do
        selection = ui.prompt_options(option_map.keys)

        # if not nil, call the function; else exit the program
        option_map[selection] ? option_map[selection].(ui) : exit
    end
end

# !---------------------------------------------------------------------------
RecipeSync.main()
