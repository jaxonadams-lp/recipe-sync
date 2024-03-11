# contains the class definition for the user interface, which allows
#   the user to interact with this application through the CLI. Also
#   contains related classes needed to support the user interface.

class Menu
    def initialize(message, options)
        @message = message
        @options = options
    end

    def print_menu
        puts @message
        puts "\n"

        @options.length.times do |i|
            puts "[#{i + 1}] #{@options[i]}"
        end
        puts "[0] Exit"
    end
end

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

    def prompt_options(options)
        # given a list of options, display a menu and prompt for an option

        menu = Menu.new("Pick an option.", options)
        menu.print_menu
    end
end