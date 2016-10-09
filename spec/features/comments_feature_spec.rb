require 'rails_helper'

feature 'Commenting on photos' do
  before { Post.create name: 'Holidays' }

  scenario 'allows users to leave a comment using a form' do
     visit '/posts'
     click_link 'Comment Holidays'
     fill_in "Thoughts", with: "so so"
     click_button 'Comment!'

     expect(current_path).to eq '/forms'
     expect(page).to have_content('so so')
  end

end
