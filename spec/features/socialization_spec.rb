require 'rails_helper'

RSpec.feature 'Socialization', type: :feature do
  context 'I can follow other users' do
    Steps 'I can follow another user' do
      Given 'I create accounts' do
        sign_up('user@email.com', 'password', 'username')
        sign_out
        sign_up('alex@alex.com', 'alexalex', 'AlexLove')
      end
      And 'I am on the explorer page' do
        click_link 'Explorers'
        click_link 'username'
      end
      Then 'I can follow username' do
        click_link 'Follow this Explorer'
        expect(page).to have_content 'You are now following username'
      end
    end
  end
  context 'I can unfollow other users' do
    Steps 'I can unfollow another user' do
      Given 'I create accounts' do
        sign_up('user@email.com', 'password', 'username')
        sign_out
        sign_up('alex@alex.com', 'alexalex', 'AlexLove')
      end
      And 'I am on the explorer page' do
        click_link 'Explorers'
        click_link 'username'
      end
      Then 'I can unfollow username' do
        click_link 'Follow this Explorer'
        click_link 'Unfollow this Explorer'
        expect(page).to have_content 'You are no longer following username'
      end
    end
  end

  context 'I can see posts of myself and my followers' do
    Steps 'I follow users and see their posts on my feed page' do
      Given 'I create accounts, adventures and posts' do
        sign_up('panda@panda.com', 'panda1', 'LingLing')
        create_category('urban art')
        create_category('parks')
        create_adventure('North Park Water Tower', 'Howard Ave and Idaho Street, San Diego, CA  92104', 'corner of Howard and Idaho', 'cool water tower, soccer fields', 'option[2]')
        click_link 'Add New Post'
        fill_in 'Title', with: 'Water Tower Photography'
        fill_in 'Body', with: 'He taught me a code. To survive. God created pudding, and then he rested. I am really more an apartment person. I am not a killer. You are a killer. I catch killers.  Under normal circumstances, I would take that as a compliment. Tonight is the night. And it is going to happen again and again. It has to happen. Like a sloth. I can do that. Oh I beg to differ, I think we have a lot to discuss. After all, you are a client.'
        click_button 'Create Post'
        create_adventure('Learn Academy', '3803 Ray St, North Park, CA 92104', 'corner of Ray and North Park', 'art shows every 2nd weekend of the month', 'option[1]')
        click_link 'Add New Post'
        fill_in 'Title', with: 'Ray at Night - Learn Academy.'
        fill_in 'Body', with: 'First place chick is hot, but has an attitude, doesnt date magicians. No, I did not kill Kitty. However, I am going to oblige and answer the nice officers questions because I am an honest man with no secrets to hide.'
        click_button 'Create Post'
        sign_out
        sign_up('monkey@monkey.com', 'monkey', 'Reeses')
        create_post('Soccer Day at North Park Water Tower', 'Hodor! Hodor hodor, HODOR hodor, hodor hodor… Hodor hodor hodor hodor hodor hodor? Hodor, hodor. Hodor. Hodor, hodor… Hodor hodor hodor?! Hodor hodor, hodor. Hodor HODOR hodor, hodor hodor hodor! ', 'North Park Water Tower')
        create_post('12 Weeks at Learn Academy', 'Rails, JavaScript, HTML, CSS, Bootstrap, Postgresql, everything you wanted to know to build a ruby and rails web application', 'Learn Academy')
        sign_out
        sign_up('dolphin@dolphin.com', 'dolphin', 'Flipper')
        create_post('I met some cool people at Learn', 'Etsy doostang zoodles disqus groupon greplin oooj voxy zoodles, weebly ning heekya handango imeem plugg dopplr jibjab, movity jajah plickers sifteo edmodo ifttt zimbra. Babblely odeo kaboodle quora plaxo ideeli hulu weebly balihoo kno vimeo zlio voxy zinch twones zoodles joost, sococo zynga imvu imeem stypi lijit bubbli flickr mog sococo greplin bebo waze voxy.', 'Learn Academy')
      end
      And 'I can follow other users' do
        click_link 'Explorers'
        click_link 'LingLing'
        click_link 'Follow this Explorer'
        click_link 'Explorers'
        click_link 'Reeses'
        click_link 'Follow this Explorer'
      end
      Then 'I can see blog posts from myself and others' do
        visit '/feed'
        expect(page).to have_content 'I met some cool people at Learn'
        expect(page).to have_content 'Etsy doostang zoodles disqus groupon greplin oooj voxy'
        expect(page).to have_content 'Soccer Day at North Park Water Tower'
        expect(page).to have_content 'Hodor! Hodor hodor, HODOR hodor, hodor hodor…'
        expect(page).to have_content 'Ray at Night - Learn Academy.'
        expect(page).to have_content 'First place chick is hot, but has an attitude, doesnt date magicians.'
        expect(page).to have_content 'Water Tower Photography'
        expect(page).to have_content 'He taught me a code. To survive. God created pudding, and then he rested.'
        expect(page).to have_content 'LingLing'
        expect(page).to have_content 'Reeses'
        expect(page).to have_content 'Flipper'
      end
    end
  end
end
