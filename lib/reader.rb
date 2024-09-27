# contains the class definition for a Reader object, which loads data
#   by reading from a given CSV.

require "csv"

class FileReader
    def initialize(ui)
        @ui = ui
        @dirpath = "."
        @selected_file = nil
    end

    def select_file_for(purpose)
        @dirpath = "./assets"

        files_in_dir = Dir.entries(@dirpath).select {
            |file|
            File.file?("#{@dirpath}/#{file}")
        }

        @selected_file = @ui.prompt_options(
            "Please select a file to read for #{purpose}.",
            files_in_dir
        )
    end

    def select_file_relative_path
        @selected_file = @ui.prompt("What CSV should I read for recipe IDs? Please enter a relative path.")
    end

    def read_csv
        # read the selected file and return its contents

        data = []
        CSV.foreach("#{@dirpath}/#{@selected_file}") do |row|
            data << row
        end

        {
            "columns" => data[0],
            "rows" => data[1..-1],
        }
    end
end
