# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* Comments API Instructions
  * In order to use our comments api, you will need a token. To get a token, create account on Turingphotoshare.heroku.com, and click my account, and then click on 'Edit Account', and then make sure you have an email on file, then click 'Send me my Token'. A token will be sent to the email provided by you on your profile page.

  * Once you have your token, you can make requests to our comments API. To authenticate, simply pass your token in the params.

  * With our comments API, you can read, create, update, and delete album comments.

  * Read Example: GET turingphotoshare.heroku.com/api/v1/albums/album_id/parameters
    * Required parameters: api_token
    * Optional parameters: comment_id

  * Create Example: POST turingphotoshare.heroku.com/api/v1/albums/album_id/parameters
    * Required parameters: api_token, body(body of your comment as a string)

  * Update Example: PATCH turingphotoshare.heroku.com/api/v1/albums/album_id/parameters
    * Required parameters: api_token, body(body of your comment as a string), comment_id

  * Delete Example: DELETE turingphotoshare.heroku.com/api/v1/albums/album_id/parameters
    * Required parameters: api_token, comment_id
