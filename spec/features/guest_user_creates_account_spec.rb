require 'rails_helper'

RSpec.features "Guest user creates account" do
  scenario "through two factor authenitcation" do
    # When a guest user visits the root,
    # And clicks "create account"
    # And fills in username
    # And fills in password
    # And fills in cell phone
    # And they click "create account"
    # They will see a two factor authentication page
    # And they fill in the texted password
    # And they click "Submit"
    # Then they will see their profile page
  end
end
