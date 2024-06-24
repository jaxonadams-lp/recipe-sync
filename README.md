# Recipe Sync

## Dependencies
To use this tool, you'll need Ruby installed on your computer. Additionally, you'll want to have a Personal Access Token for your GitHub account and an API key for Workato.

If you are deploying Python code to multiple recipes, you'll need a csv in this project's `/assets` directory with two columns: `recipe_id` (the recipe's ID in Workato) and `step_num` (the Python step in your recipe).

## Usage
To use this tool, navigate to the root directory of the project and run it:
```
cd ./path/to/recipe-sync
ruby main.rb
```

Follow the prompts to input your API credentials for Workato and GitHub and select which process the tool should run.