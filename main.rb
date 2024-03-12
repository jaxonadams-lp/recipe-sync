# RecipeSync -- a GitHub -> Workato deployment tool for LoanPro Integrations
# Author: Jaxon Adams

require_relative "lib/ui.rb"

module RecipeSync
    def self.main
        ui = UserInterface.new
        ui.display_title

        selection = ui.prompt_options [
            "Deploy a Python script.",
        ]
        puts "You chose to do the following: #{selection}"
    end
end

# !---------------------------------------------------------------------------
RecipeSync.main()
