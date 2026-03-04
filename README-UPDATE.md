Hunter Scholz | Brody Couture

# Step-By-Step at the bottom

**Our process**

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
9. We attempted to run `rails db:migrate` to set up the database, but seemed to have no effect.
10. In `user.rb` we switched `enum :role` to `enum :role, {admin: 0, organization: 1}`.
11. Checked in the rest of the files to look for enum errors, doing the same thing in `organization.rb`.
12. Dumped the controller code into ChatGPT to check for errors.
13. In `organization-controller` we removed `.to_h`.
14. Throw in the towel and use Claude.
15. Asked Claude for help in updating the code to Rails 8.1.2.
16. Allowed Claude to update, fix, and edit any code or errors caused by the update.
    * Copy over `spec_helper.rb`, `rails_helper.rb`, and `.rspec` from the original.
    * Copy over factories and spec files.
    * Update rspec configuration.
    * Migrate the helpers, models, controllers, factories, and test stubs.
    * Ensure all tests are working correctly.
    * Verify the GemFile.
    * Update enum syntax in all the files.
17. Run `bundle exec rails assets:clobber` in the container.
18. Ran `RAILS_ENV=test bundle exec rails assets:precompile` in the container, which did not work
19. In `aplications.js`, changes `require_tree` to `.js`, and then run the above function again.
20. Ask Claude to fix and update the code again but this time we asked really really nicely.
21. hey so that js change from earlier was just wrong undo that.
22. Copied over the tests that claude missed because its dumb
23. asked claude to fix the errors in the test suite (dont worry the step by step is coming soon i swear)


# Rails 5.2 to Rails 8.1 Migration Manual
_Prerequisites_
* Docker installed
* Basic understanding of Rails and Git

**Phase 1: Setup**
* Clone or backup your Rails 5.2 project
* Update Gemfile: Change Rails version to 8.1.2
* Update Ruby version in Dockerfile or .ruby-version to 3.4.8 or higher
* Run bundle update to install new gems
* Run rails app:upgrade (Rails provides an upgrade task)

**Phase 2: Model Updates**
* Find all enum definitions in your models
* Convert from old syntax to new syntax:
    * Old: enum status: [:approved, :rejected]
    * New: enum :status, { approved: 0, rejected: 1 }
    * Test: rails console and verify enums work

**Phase 3: Asset Pipeline**
* Remove //= require turbolinks from application.js
  * Add //= link application.css to manifest.js
* Remove 'data-turbolinks-track': 'reload' attributes from your layout views
  * Delete any .coffee files (CoffeeScript is not supported in Rails 8)

**Phase 4: Test Configuration**
* Update rails_helper.rb: Change config.fixture_path to config.fixture_paths (array)
* Update test environment config: Set config.action_controller.raise_on_missing_callback_actions = false
* Create spec/support/capybara.rb with proper test driver configuration
* Update your gems: Ensure RSpec 6.0+, Capybara, FactoryBot latest versions

**Phase 5: Database & Verification**
* Run database migrations: rails db:migrate
* Run tests: bundle exec rspec
* Start server and manually test key flows
* Check browser console for JavaScript errors
**Phase 6: Deployment**
* Update CI/CD pipeline for new Rails version
* Deploy to staging first
* Verify all features work
* Deploy to production
