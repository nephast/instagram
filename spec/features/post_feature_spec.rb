require 'rails_helper'

feature 'empty post list' do
  context 'no post have been added' do
    scenario 'should display a prompt to add a post' do
      visit '/posts'
      expect(page).to have_content 'No post yet'
      expect(page).to have_link 'Add a post'
    end
  end

  context 'posts have been added' do
  before do
    Post.create(name: 'Holidays')
  end

    scenario 'display posts' do
      visit '/posts'
      expect(page).to have_content('Holidays')
      expect(page).not_to have_content('No post yet')
    end
  end

  context 'creating post' do
    scenario 'prompts user to fill out a form, then displays the new post' do
      visit '/posts'
      click_link 'Add a post'
      fill_in 'Name', with: 'Holidays'
      click_button 'Post'
      expect(page).to have_content 'Holidays'
      expect(current_path).to eq '/posts'
    end
  end

  context 'viewing posts' do

    let!(:holidays){ Post.create(name:'Holidays') }

    scenario 'lets a user view a specific post' do
     visit '/posts'
     click_link 'Holidays'
     expect(page).to have_content 'Holidays'
     expect(current_path).to eq "/posts/#{holidays.id}"
    end

  end

  context 'editing posts' do

  before { Post.create name: 'Holidays', description: 'Fun between friends' }

  scenario 'let a user edit a post' do
   visit '/posts'
   click_link 'Edit Holidays'
   fill_in 'Name', with: 'Holidays with friends'
   fill_in 'Description', with: 'Need more'
   click_button 'Update Post'
   expect(page).to have_content 'Holidays with friends'
   expect(page).to have_content 'Need more'
   expect(current_path).to eq '/posts'
  end
end

context 'deleting posts' do

  before { Post.create name: 'Holidays', description: 'with family' }

  scenario 'removes a post when a user clicks a delete link' do
    visit '/posts'
    click_link 'Delete Holidays'
    expect(page).not_to have_content 'Holidays'
    expect(page).to have_content 'Post deleted successfully'
  end

end

end
