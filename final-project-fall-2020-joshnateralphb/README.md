# The Final Project

## Introduction

The goal in this project is to perform one iteration of the Agile Methodology.




## Prerequisites

1. Install Ruby via [RailsInstaller](http://railsinstaller.org/en) *(install latest version)*

2. Clone project

3. Navigate to directory in command line

4. Install required gems: `bundle install --without production`

   


## Running the Application

1. 'bundle exec ruby app.rb' 

   

## Part 0 - Getting Started

Label your group members as Person A, Person B, or Person C.



**Person A**

1. Create and checkout a branch. Name the branch `user_stories`:

   ```
   $ git checkout -b [name_of_your_new_branch]
   ```

2. Add your user stories to `user_stories.txt` in the root directory of your project

3. Add and commit your changes

   ```
   $ git add .
   $ git commit -m "Add user stories"
   ```

4. Push the branch to Github:

   ```
   $ git push origin [name_of_your_new_branch]
   ```



**Person B**

1. Fetch the latest information from Github

   ```
   $ git fetch
   ```

2. Checkout the branch:

   ```
   $ git checkout [name_of_branch]
   ```

3. Sort the user stories by priority

4. Add and commit and push your changes

   ```
   $ git add .
   $ git commit -m "Sorted user stories"
   $ git push
   ```



**Person C**

1. Fetch the latest information from Github

   ```
   $ git fetch
   ```

2. Checkout the branch:

   ```
   $ git checkout [name_of_branch]
   ```

3. Place asterisks next to the user stories your team will attempt to complete in this iteration

4. Add, commit, and push your changes

   ```
   $ git add .
   $ git commit -m "Sorted user stories"
   $ git push
   ```

5. Go back to the master branch

   ```
   $ git checkout master
   ```

6. Merge the branch into master

   ```
   $ git merge [your_branch_name]
   ```

7. Push to Github

   ```
   $ git push
   ```



**Person A** **and B**

```
$ git checkout master
$ git pull
```





## Part 1 - Modeling the Data

For part 1 your job is to add the tests for the custom classes  you might need to `spec/part1_spec.rb`

* Run tests with: `bundle exec rspec spec/part1_spec.rb`



**IMPORTANT: You are responsible for writing the tests and passing them.**





## Part 2 - Iteration!

Make the API endpoints for the user stories you selected.

You should make a branch per user story, then merge that branch into master when it is done.


**IMPORTANT: You are responsible for writing the tests and passing them.**

**ALSO: Don't forget to add whatever.auto_upgrade! to your models.rb and whatever.auto_migrate! to spec/spec_helper.rb**


*Run tests with: `bundle exec rspec spec/part2_spec.rb`





## Deploying to Heroku

### Deployment Instructions

1. Add all your changes on git and make a commit
2. Create a Heroku server: `heroku create`
3. Create a database for your server: `heroku addons:create heroku-postgresql:hobby-dev`
4. Push the code to Heroku: `git push heroku master`
5. I preconfigured the necessary files for this to work.
6. Verify all is working and submit your links (github and heroku) to me.