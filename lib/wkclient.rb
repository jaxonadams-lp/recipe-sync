# contains the class definition for a Workato client, which allows
#   for interaction with Workato through this program. All interaction
#   with Workato is handled through Workato's Developer API.

require "net/http"
require "uri"
require "json"

class WorkatoClient
    def initialize(ui, api_key)
        @ui = ui
        @api_key = api_key
        @base_url = "https://www.workato.com/api"
    end

    def update_code_step(recipe_id, step_num, new_code)
        # fetch the recipe's current config, then update
        #   the python code section for the recipe.

        recipe_data = get_recipe_data(recipe_id)
        new_payload = create_payload_with_new_script(
            recipe_data,
            step_num,
            new_code
        )

        update_recipe(recipe_id, new_payload)
    end

    def get_recipe_data(recipe_id)
        # get the recipe's configuration data from Workato

        url = URI("#{@base_url}/recipes/#{recipe_id}")

        request = Net::HTTP::Get.new(url)
        request["Authorization"] = "Bearer #{@api_key}"

        response = Net::HTTP.start(url.host, url.port, use_ssl: true) do |http|
            http.request(request)
        end
        exit_if_bad_status(response)

        data = JSON.parse(response.body)

        data
    end

    private

    def exit_if_bad_status(response)
        if response.code != "200"
            puts "Error: #{response.code} - #{response.message}"
            puts response.body
            exit
        end
    end

    def update_recipe(recipe_id, payload)
        # using the provided payload, update the given Workato recipe

        url = URI("#{@base_url}/recipes/#{recipe_id}")

        request = Net::HTTP::Put.new(url)
        request["Authorization"] = "Bearer #{@api_key}"
        request.content_type = "application/json"
        request.body = payload.to_json

        response = Net::HTTP.start(url.host, url.port, use_ssl: true) do |http|
            http.request(request)
        end
        exit_if_bad_status(response)

        response.code
    end

    def create_payload_with_new_script(recipe_data, step_to_update, new_code)
        # substitute the python code step in the given data hash
        #   to use the new block of code

        original_recipe_code = JSON.parse(recipe_data["code"])

        new_recipe_code = original_recipe_code.dup
        new_recipe_code["block"].select{
            |step|

            step["number"] == step_to_update.to_i - 1

        }[0]["input"]["code"] = new_code

        return {
            "recipe": {
                "code": new_recipe_code.to_json
            }
        }
    end
end
