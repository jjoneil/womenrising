require 'rails_helper'

feature 'User can edit information' do
  let!(:user) { create :skinny_user }
  let!(:boulder) { create :location }
  let!(:detroit) { create :location, city: 'Detroit', state: 'MI' }

  before do
    login_as(user, :scope => :user)
    visit user_path(user)
  end

  scenario 'including location' do
    expect(user.location).to be_nil
    expect(page).to_not have_content 'Sign_in'
    click_on 'Edit My Profile'
    expect(page).to have_content 'Location'
    select 'Boulder, CO'
    click_on 'Submit'
    expect(user.reload.location).to_not be_nil
    expect(page).to have_content user.location.city_state
  end
end