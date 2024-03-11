# RecipeSync -- a GitHub -> Workato deployment tool for LoanPro Integrations
# Author: Jaxon Adams

require_relative "lib/ui.rb"

module RecipeSync
    def self.main
        ui = UserInterface.new
        ui.display_title
    end
end

# !---------------------------------------------------------------------------
RecipeSync.main()
