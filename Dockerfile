# Use the official Ruby image from the Docker Hub
FROM ruby:3.0

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install the dependencies
RUN bundle install

# Copy the rest of the application code into the container
COPY . .

# Command to run the application
CMD ["ruby", "main.rb"]