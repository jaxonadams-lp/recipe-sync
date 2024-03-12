# contains the class definition for the user interface, which allows
#   the user to interact with this application through the CLI. Also
#   contains related classes needed to support the user interface.

class Menu
    def initialize(message, options)
        @message = message
        @options = options
    end

    def print_menu
        # print the available options to the screen, including an option
        #  to exit. The exit option will always be option 0.
        puts @message
        puts "\n"

        @options.length.times do |i|
            puts "[#{i + 1}] #{@options[i]}"
        end
        puts "[0] Exit"
    end

    def selection_is_valid?(selection)
        # ensure that the given user input is a valid selection.
        if selection.to_i.to_s == selection  # parsed to int and back should be the same value
            as_int = selection.to_i
            if as_int.between?(0, @options.length)
                return true
            end
        end
        return false
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
        # prints some ascii art (defined in initialize) to the screen.

        puts @title
    end

    def collect_input(prompt)
        # provides a way of collecting user input through a nicer display.

        puts "\n"
        print prompt
        user_input = gets
        puts "\n"
        return user_input.chomp
    end

    def prompt_options(options)
        # given a list of options, display a menu and prompt for an option

        menu = Menu.new("Pick an option.", options)
        menu.print_menu

        selection = collect_input("  >> ")
        puts "You selected option #{selection}"

        if menu.selection_is_valid?(selection)
            puts "Your selection was a valid option."
        else
            puts "Your selection was invalid."
        end
    end
end