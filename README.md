# Recipe Sync

## Dependencies
To use this tool, you'll need Ruby or Docker installed on your computer. Additionally, you'll want to have a Personal Access Token for your GitHub account and an API key for Workato.

If you are deploying Python code to multiple recipes, you'll need a csv in this project's `/assets` directory with two columns: `recipe_id` (the recipe's ID in Workato) and `step_num` (the Python step in your recipe).

## Usage

**_WITH DOCKER_**

If you've updated your `input.csv` file in the `/assets` directory or this is your first time running RecipeSync, you'll need to build a new Docker image:
```bash
cd path/to/recipe-sync
docker build -t recipe-sync .
```

Build and run a new docker container running RecipeSync with the following command:
```bash
docker run -it --rm recipe-sync
```

The next time you update your `input.csv` file and want to build a new image, you may want to delete your old image. The following command will delete all your existing Docker images:
```bash
docker rmi $(docker images -q)
```

**_WITHOUT DOCKER_**

Navigate to the root directory of the project and run it:
```bash
cd path/to/recipe-sync
ruby main.rb
```

Follow the prompts to input your API credentials for Workato and GitHub and select which process the tool should run.
