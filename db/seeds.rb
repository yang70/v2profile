# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

post_titles = [
  "Resolving CSRF Token Issues with Rails / Angular / Devise",
  "Making Rails, PhantomJS and Heroku work together",
]

post_bodies = [
  "After working with several Angular front-end applications with back end API's in Rails that incorporate [Devise](https://github.com/plataformatec/devise) 
  and [Angular Devise](https://github.com/cloudspace/angular_devise), I've had to incorporate a work-around for the issue of getting invalid CSRF token errors. 
   The problem is described perfectly in [this](https://technpol.wordpress.com/2014/04/17/rails4-angularjs-csrf-and-devise/) blog post, but I'll try to rehash t
  he basics here.\r\n\r\nIn order to protect against [cross site request forgery](http://guides.rubyonrails.org/security.html#cross-site-request-forgery-csrf), 
  rails incorporates a security token in the HTML `<head>` that refreshes on a page reload.  This token is required for any non-GET requests to the server.\r\n\
  r\nWith Devise and Angular this becomes a problem in that a log in request (POST) will include the CSRF token and will be processed by Rails, however the gene
  ration of a new token takes place in a *before* action.  Devise then instantiates a new user session that again refreshes the token.  The problem is when the 
  response is sent back to the user, it includes the token that was generated before the Devise session refreshed it.  Therefore any subsequent requests will se
  nd an invalid token and will raise an exception.\r\n\r\nThe solution, as described in the aforementioned blog post, is to incorporate an `after_filter` that s
  ets the token into a cookie *after* the session is created.  The second part of the code will look in the request headers from Angular and set the token if it
   is there:\r\n\r\n```ruby\r\n# app/controllers/application_controller.rb\r\nafter_filter :set_csrf_cookie_for_ng\r\n\r\ndef set_csrf_cookie_for_ng\r\n    cook
  ies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?\r\nend\r\n\r\nprotected\r\n  \r\ndef verified_request?\r\n  super || form_authenticity
  _token == request.headers['X-XSRF-TOKEN']\r\nend\r\n```\r\nAfter adding this code, CSRF errors disappear!",
  "# Rails, PhantomJS and Heroku\r\nby [Matthew Yang](http://matthewgyang.com)\r\n\r\nIn a recent [project](https://github.com/yang70/football-picker), I dec
  ided to use [Capybara](https://github.com/jnicklas/capybara)/[Poltergeist](https://github.com/teampoltergeist/poltergeist)([PhantomJS](http://phantomjs.org/))
   to perform web scraping of other web sites for information.  These tools worked prefectly in development, however when trying to deploy to Heroku, PhantomJS 
  wasn't found in the running environment.  I attempted to use several different buildpacks per articles found [here](https://gist.github.com/edelpero/9257311) 
  and [here](https://discussion.heroku.com/t/running-a-headless-browser-on-heroku/97), however I could not get it to work successfully.\r\n\r\nI then came acros
  s the super-simple solution found [here](http://stackoverflow.com/questions/12495463/how-to-run-phantomjs-on-heroku).  All that is needed is to add the compil
  ed binary for PhantomJS to the `/bin` directory of your Rails app.  That's it.  No buildpacks or any other modifications are necessary, PhantomJS is available
  !\r\n\r\nThe only issue is the current version (2.0) of PhantomJS does not have a Linux 64 compiled version [available for download](http://phantomjs.org/down
  load.html) yet, you need to chose an appropriate previous version, which can be downloaded [here](https://bitbucket.org/ariya/phantomjs/downloads) or compile 
  from the source code yourself.\r\n\r\nAnyway, this is a super easy solution, but [let me know](mailto:matt@matthewgyang.com) if you are aware of any issues or
   vulnerabilities!",
]

pic_urls = ["https://s3.amazonaws.com/matthewgyang/images/devise.png", "https://s3.amazonaws.com/matthewgyang/images/phantom.png"]

post_titles.each_with_index do |title, index|
  Post.create!(title: title, body: post_bodies[index], pic_url: pic_urls[index])
end
