# RecipeSync -- a GitHub -> Workato deployment tool for LoanPro Integrations
# Author: Jaxon Adams

require_relative "lib/ui.rb"

module RecipeSync
    def self.main
        ui = UserInterface.new
        ui.display_title

        ui.prompt_options ["Option A", "Option B", "Option C"]
    end
end

# !---------------------------------------------------------------------------
RecipeSync.main()
