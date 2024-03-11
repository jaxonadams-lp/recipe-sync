# contains the class definition for the user interface, which allows
#   the user to interact with this application through the CLI.

class UserInterface
    def initialize
        @title = "
         ______ _______ _______ _____  _____  _______     _______ __   __ __   _ _______
        |_____/ |______ |         |   |_____] |______ ___ |______   \\_/   | \\  | |      
        |    \\_ |______ |_____  __|__ |       |______     ______|    |    |  \\_| |______
                                                                                        
       "
    end

    def display_title
        puts @title
    end
end