# contains the class definition for a Config object, which contains
#   API keys for GitHub and Workato, and other app configurations.

require "yaml"

class Configuration
    # loads configuration from a YAML file, or creates a YAML if it does
    #   not exist yet.

    attr_reader :config_file, :config

    def initialize(ui, config_file)
        @ui = ui

        @config_file = config_file
        @config = load_config(config_file)
    end

    private

    CONFIG_FIELDS = {
        "github" => {
            "personal_access_token" => nil
        },
        "workato" => {
            "api_key" => nil
        }
    }

    def prompt_for_config
        @ui.puts_info "\nConfiguring RecipeSync...\n"

        new_config = {}

        CONFIG_FIELDS.each_pair do |domain, settings|
            settings.each_pair do |field, _|
                prompt = "Please enter your #{field} for #{domain}."
                if (field.include?("key") || field.include?("token"))
                    value = @ui.prompt_sensitive(prompt)
                else
                    value = @ui.prompt(prompt)
                end

                if new_config[domain].nil? then new_config[domain] = {} end
                new_config[domain][field] = value
            end
        end

        new_config
    end

    def create_config_file(config_hash)
        File.open(@config_file, "w") do |file|
            file.write(config_hash.to_yaml)
        end
        @ui.puts_info "New configuration file created at #{@config_file}."
    end

    def load_config(config_file)
        if File.exist?(config_file)
            config = YAML.load_file(config_file)
            @ui.puts_info "Configuration loaded from #{config_file}"
            config
        else
            new_config = prompt_for_config
            create_config_file(new_config)
            new_config
        end
    end
end