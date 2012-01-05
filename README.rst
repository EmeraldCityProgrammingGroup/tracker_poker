=============
Tracker_Poker
=============

repo   :: https://github.com/EmeraldCityProgrammingGroup/tracker_poker
heroku :: http://tracker-poker.herokuapp.com/


DESCRIPTION
------------

Tracker_Poker is a way to automate the planning poker 
meeting on an Agile project using a mobile phone.

Tracker_Poker is still in early development, so now 
is the time to make your mark on the project.


FEATURES/PROBLEMS
------------------

* TBD


SYNOPSYS
---------

* % TBD/USAGE


INSTALL
---------

    # Checkout the project
    $ git clone git://github.com/EmeraldCityProgrammingGroup/tracker_poker
    $ cd tracker_project
    
    # Install the project dependencies
    $ gem install bundler
    # If you do not have postgres installed, use this:
    $ bundle install --without production 
    # If you do have postgres installed, use this:
    $ bundle install

    # Set up the development database.
    $ rake db:migrate

    # Start the local web server
    $ rails server

    You should then be able to navigate to `http://localhost:3000/` in a web browser.


HERKOKU SETUP
---------------

    If you wish to host a publicly available copy of Tracker_Poker,
    the easiest option is to host it on [Heroku](http://heroku.com/).

    # Make sure you have the Heroku gem
    $ gem install heroku

    # Create your app. Replace APPNAME with whatever you want to name it.
    $ heroku create APPNAME --stack bamboo-mri-1.9.2
   
    # Define where the user emails will be coming from
    # (This email address does not need to exist)
    $ heroku config:add MAILER_SENDER=noreply@example.org

    # Allow emails to be sent
    $ heroku addons:add sendgrid:starter

    # Deploy the first version
    $ git push heroku master

    To deploy it to Heroku, make sure you have a local copy of the 
    project; refer to the previous section for instuctions. Then:

    # Set up the database
    $ heroku rake db:setup

    Once that's done, you will be able to view your site at 
    `http://APPNAME.heroku.com`.


TO CONTRIBUTE
----------------

Tracker_Poker is currently welcoming contributions.  If you'd like to help:

Here are some general guidelines for contributing:

* Check the [issue queue] in Pivotal Tracker TBD-URL
    for a list of the major features which are yet to be implemented.
    These have the `feature` and `unstarted` labels.  If a feature
    you'd like isn't there, add  an issue.
* If you'd like to take ownership of one of the features, leave a
    comment on the issue queue indicating that you're working on it.

* If you'd like to discuss anything about the issue with other
    developers, do so on the [Emerald Programming Group]
    (http://groups.google.com/group/TBD) mailing list.

* Fork github project: 
    https://github.com/EmeraldCityProgrammingGroup/tracker_poker
* Make your changes on a branch, and use that branch as the base
    for pull requests.
* We encourage you try to break changes up into the smallest logical
    blocks possible. We would prefer to receive many small commits
    to one large  one in a pull request.
* Feel free to open unfinished pull requests if you'd like to discuss
    work in progress, or would like other developers to test it.
* All patches changes need to be covered by tests and should not
    break the existing tests, unless a current test is invalidated
    by a code change. 

* Read over documentation.

* Run `rake test` to check the Rails test suite is green.  

* If you have any questions please post them to the <emerald city> group.

* Also attend the <emerald city> Saturday classes.


LICENSE
---------

* **Please put your open source license here.**
* **If you need help, check out this: http://www.opensource.org/licenses **


README FORMAT
--------------

See http://docutils.sourceforge.net/docs/user/rst/quickref.html
for more information about the format used in the file. It is 
called **Restructured Text**.



