# README

* Comments API Instructions
  * In order to use our comments api, you will need a token.
      - To get a token, create account on Turingphotoshare.heroku.com, and click on "Profile" at the top of the screen.  Make sure you have an email address on file, and then click "Generate API Token". A token will be sent to the email provided by you on your profile page.

  * Once you have your token, you can make requests to our comments API. To authenticate, simply pass your token in the params.

  * With our comments API, you can READ, CREATE, UPDATE, and DELETE your own album comments.

  * Read Example for all of your comments:
    - GET turingphotoshare.heroku.com/api/v1/albums/album_id/comments.json?parameters
      * Required parameters: api_token

  * Read Example for a single comment:
    - GET turingphotoshare.heroku.com/api/v1/albums/album_id/comment_id.json?parameters
      * Required parameters: api_token

  * Create Example:
    - POST turingphotoshare.heroku.com/api/v1/albums/album_id/comments.json?parameters
      * Required parameters: api_token, body(body of your comment as a string),
                             CONTENT_TYPE = 'application/json'
                             ACCEPT = 'application/json'

  * Update Example:
    - PATCH turingphotoshare.heroku.com/api/v1/albums/album_id/comment_id.json?parameters
      * Required parameters: api_token, body(body of your comment as a string),
                             CONTENT_TYPE = 'application/json'
                             ACCEPT = 'application/json'

  * Delete Example:
    - DELETE turingphotoshare.heroku.com/api/v1/albums/album_id/comment_id.json?parameters
      * Required parameters: api_token
