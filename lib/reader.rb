# contains the class definition for a Reader object, which loads data
#   by reading from a given CSV.

require "csv"

class FileReader
    def initialize(ui)
        @ui = ui

        @dirpath = "./assets"
        @selected_file = nil
    end

    def select_file_for(purpose)
        files_in_dir = Dir.entries(@dirpath).select {
            |file|
            File.file?("#{@dirpath}/#{file}")
        }

        @selected_file = @ui.prompt_options(
            "Please select a file to read for #{purpose}.",
            files_in_dir
        )
    end

    def read_csv
        # read the selected file and return its contents

        CSV.foreach("#{@dirpath}/#{@selected_file}") do |row|
            puts row.inspect
        end
    end
end
