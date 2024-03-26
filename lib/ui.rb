# contains the class definition for the user interface, which allows
#   the user to interact with this application through the CLI. Also
#   contains related classes needed to support the user interface.

require "io/console"

require "colorize"

class Menu
    def initialize(message, options)
        @message = message
        @options = options
    end

    def print_menu
        # print the available options to the screen, including an option
        #  to exit. The exit option will always be option 0.
        puts @message.yellow
        puts "\n"

        @options.length.times do |i|
            puts "  [#{i + 1}] #{@options[i]}".yellow
        end
        puts "  [0] Exit".red
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

    def puts_info(message)
        puts message.light_blue
    end

    def display_title
        # prints some ascii art (defined in initialize) to the screen.

        puts @title.red
    end

    def exit_ui
        # handles exiting the app
        # additional logic may be added later

        puts_info "Goodbye!"
        exit
    end

    def collect_input(prompt)
        # provides a way of collecting user input through a nicer display.

        puts "\n"
        print prompt
        user_input = gets
        puts "\n"
        return user_input.chomp
    end

    def prompt_options(msg, options)
        # given a list of options, display a menu and prompt for an option

        menu = Menu.new(msg, options)
        menu.print_menu

        selection = collect_input(">> ")

        while !menu.selection_is_valid?(selection)
            puts "Please enter a valid option. You should enter a number; for example, \"2\" (without quotes).".red
            selection = collect_input(">> ")
        end

        if selection.to_i == 0
            exit_ui
        end

        return options[selection.to_i - 1]
    end

    def prompt(message)
        # prompt the user for input using the given message

        puts "\n"
        puts message.yellow
        user_input = collect_input(">> ")
        puts "\n"

        return user_input
    end

    def prompt_sensitive(message)
        puts "\n"

        puts message.yellow
        puts "\n"
        print ">> "

        input = ""
        loop do
            char = STDIN.getch
            break if char == "\r" || char == "\n"  # enter key pressed
            print "*"
        input << char
        end

        puts "\n"
        puts "\n"
        return input
    end
end
