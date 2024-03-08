require "net/http"
require "uri"
require "json"

require "octokit"

def get_input(msg)
    puts "\n"
    puts msg
    print "  >> "
    usr_input = gets
    puts "\n"
    return usr_input.chomp
end

# get personal access token from user
gh_token = get_input "Please enter your GitHub personal access token."

# create connection to GitHub through the octokit sdk
client = Octokit::Client.new(access_token: gh_token)
puts "Connected to GitHub successfully."

# get the owner and repository name
repo_owner = get_input "Please enter the owner of the repository."
repo_name = get_input "Please enter the name of the repository."

# get the path to the desired file for retrieval
file_path = get_input "Please enter the path to your file."

# get the contents of the file
begin
    file_content = client.contents("#{repo_owner}/#{repo_name}", path: file_path)
    script = Base64.decode64(file_content.content)
    puts "\nHere's the file you requested:\n"
    puts script
rescue Octokit::NotFound
    puts "File #{file_path} not found in the repository #{repo_owner}/#{repo_name}"
    exit
rescue Octokit::Error => e
    puts "Error: #{e.message}"
    exit
end

# connect to Workato API and request current data from recipe
workato_key = get_input "Please enter your Workato API key."

recipe_id = get_input "Enter your recipe ID."

# 3.8.24 sample recipe id: 45518986
url = URI("https://www.workato.com/api/recipes/#{recipe_id}")
request = Net::HTTP::Get.new(url)

request["Authorization"] = "Bearer #{workato_key}"

response = Net::HTTP.start(url.host, url.port, use_ssl: url.scheme == "https") do |http|
    http.request(request)
end

if response.code == '200'
    data = JSON.parse(response.body)
    original_code_json = JSON.parse(data["code"]) # we'll use an updated version of this later
else
    puts "Error: #{response.code} - #{response.message}"
    exit
end

step_num = get_input "Please enter the step number you'd like updated. This should be a python step."

# we may not need the original code later down the line.
# for now, I'll keep the logic so I don't lose it
py_code_block = original_code_json["block"].select{|step| step["number"] == step_num.to_i - 1}[0]
original_python_code = py_code_block["input"]["code"]

new_code_json = original_code_json.dup

new_code_json["block"].select{
    |step|

    step["number"] == step_num.to_i - 1

}[0]["input"]["code"] = script

update_recipe_payload = {
    "recipe": {
        "code": new_code_json.to_json
    }
}

# send request to update recipe
request = Net::HTTP::Put.new(url)

request.content_type = "application/json"
request["Authorization"] = "Bearer #{workato_key}"

request.body = update_recipe_payload.to_json

response = Net::HTTP.start(url.host, url.port, use_ssl: url.scheme == "https") do |http|
    http.request(request)
end

if response.code == '200'
    puts "Update was successful"
else
    puts "Error: #{response.code} - #{response.message}"
    exit
end
