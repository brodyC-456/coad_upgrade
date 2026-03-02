Hunter Scholz | Brody Couture

We created a new repo to hold the upgraded COAD, following the instructions in the exercise (with some difficulty). We had to make a new Rail App with the newer version to copy over.

**Our first step was to ask ChatGPT for a gameplan on how to get the old app working in the new version, telling it which versions we started and ended with.**

1. Starting with providing our current Gemfile, and generating an updated file that we replaced it with. Several old gems were cut that were not compatible with the new version.
2. Coping the old application (`coad-upgrade->app`) files into the same location in new app, keeping anything newly added to the updated app.
3. Fixing the config routes and updating them to correct paths.
4. Moving all the files from `db` into the new app, and deleting the files that were in the new `db`.
5. Quickly double checking some example models and code files to see if they would break in the new Ruby version. All seemed to be well.
6. In the container, run `bundle install` from `coad-upgrade` to install any dependancies from the Gemfile.
7. In the Gemfile, update the version of `devise` to verison 5.0, and then run `bundle update devise` in the container.
8. In the Gemfile, add `gem 'observer', require: true`, and then update `factory_bot_rails` to 6.3 in the Gemfile. Then run `bundle install` and `bundle update factory_bot_rails` in the conmtainer.
9. We used `rails db:migrate` to set up the database.
