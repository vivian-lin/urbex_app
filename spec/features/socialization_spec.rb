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
        create_categories
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

  context 'Recently added adventures' do
    Steps 'Seeing recently added adventures on your feed' do
      Given 'I am signed up, and there are categories and adventures created' do
        sign_up('user1@email.com', 'password', 'user1')
        create_categories
        create_adventure('Adventure1', 'AdventureAddress', 'AdventureDirections', 'AdventureDescription', 'option[1]')
        create_adventure('Adventure2', 'AdventureAddress', 'AdventureDirections', 'AdventureDescription', 'option[1]')
        create_adventure('Adventure3', 'AdventureAddress', 'AdventureDirections', 'AdventureDescription', 'option[1]')
        sign_out
        sign_up('user2@email.com', 'password', 'user2')
        create_adventure('Adventure4', 'AdventureAddress', 'AdventureDirections', 'AdventureDescription', 'option[1]')
      end
      Then 'I can see new adventures on my feed' do
        visit '/feed'
        expect(page).to have_content 'Adventure1'
        expect(page).to have_content 'Adventure2'
        expect(page).to have_content 'Adventure3'
        expect(page).to have_content 'Adventure4'
      end
    end
  end
  context 'posts on my feed page are truncated with links to full post' do
    Steps 'creating posts' do
      Given 'I am logged in and have posts on my feed page' do
        sign_up('panda@panda.com', 'panda1', 'LingLing')
        create_categories
        create_adventure('North Park Water Tower', 'Howard Ave and Idaho Street, San Diego, CA  92104', 'corner of Howard and Idaho', 'cool water tower, soccer fields', 'option[2]')
        click_link 'Add New Post'
        fill_in 'Title', with: 'Water Tower Photography'
        fill_in 'Body', with: 'He taught me a code. To survive. God created pudding, and then he rested. I am really more an apartment person. I am not a killer. You are a killer. I catch killers.  Under normal circumstances, I would take that as a compliment. Tonight is the night. And it is going to happen again and again. It has to happen. Like a sloth. I can do that. Oh I beg to differ, I think we have a lot to discuss. After all, you are a client.'
        click_button 'Create Post'
      end
      Then 'I can see my feed page and posts are truncated' do
        visit '/feed'
        click_link 'read more'
        expect(page).to have_content 'Water Tower Photography'
        expect(page).to have_content 'He taught me a code. To survive. God created pudding, and then he rested. I am really more an apartment person. I am not a killer. You are a killer. I catch killers.  Under normal circumstances, I would take that as a compliment. Tonight is the night. And it is going to happen again and again. It has to happen. Like a sloth. I can do that. Oh I beg to differ, I think we have a lot to discuss. After all, you are a client.'
      end
    end
  end
  context 'I can see my followers on my profile page' do
    Steps 'Accounts created and followers created' do
      Given 'I create accounts and follow others' do
        sign_up('user@email.com', 'password', 'username')
        sign_out
        sign_up('alex@alex.com', 'alexalex', 'AlexLove')
        click_link 'Explorers'
        click_link 'username'
        click_link 'Follow this Explorer'
        sign_out
        sign_up('gorilla@gorilla.com','gorilla','Harambe')
        click_link 'Explorers'
        click_link 'username'
        click_link 'Follow this Explorer'
        sign_out
      end
      And 'I can log back in to first account' do
        click_link 'sign in'
        fill_in 'user[email]', with: 'user@email.com'
        fill_in 'user[password]', with: 'password'
        click_button 'Log in'
      end
      Then 'I can see my followers' do
        visit '/profile'
        expect(page).to have_content 'AlexLove'
        expect(page).to have_content 'Harambe'
      end
    end
  end
  context 'I can see who I am following on my profile page' do
    Steps 'Accounts created and followees created' do
      Given 'I create accounts and follow others' do
        sign_up('user@email.com', 'password', 'username')
        sign_out
        sign_up('alex@alex.com', 'alexalex', 'AlexLove')
        sign_out
        sign_up('gorilla@gorilla.com','gorilla','Harambe')
        sign_out
      end
      And 'I can log back in to first account' do
        click_link 'sign in'
        fill_in 'user[email]', with: 'user@email.com'
        fill_in 'user[password]', with: 'password'
        click_button 'Log in'
      end
      Then 'I can follow other Explorers' do
        click_link 'Explorers'
        click_link 'AlexLove'
        click_link 'Follow this Explorer'
        click_link 'Explorers'
        click_link 'Harambe'
        click_link 'Follow this Explorer'
      end
      Then 'I can see who I am following' do
        visit '/profile'
        expect(page).to have_content 'AlexLove'
        expect(page).to have_content 'Harambe'
  context 'Posts in order' do
    Steps 'Viewing a post feed organized by date and time' do
      Given 'There are users created, they follow each other, and categories/adventures/posts are made' do
        create_categories
        sign_up('user1@email.com', 'password', 'user1')
        create_adventure('adventure_name', 'adventure_address', 'adventure_directions', 'adventure_description', 'option[1]')
        create_post('Title1', 'This is the Body.', 'adventure_name')
        create_post('Title2', 'This is the Body.', 'adventure_name')
        create_post('Title3', 'This is the Body.', 'adventure_name')
        sign_out
        sign_up('user2@email.com', 'password', 'user2')
        click_link 'Explorers'
        click_link 'user1'
        click_link 'Follow this Explorer'
      end
      Then 'I can go to my news feed and see all my followees posts in descending order' do
        click_link 'news feed'
        posts = page.all('div.blogPosts section')
        expect(posts[0]).to have_content 'Title3'
        expect(posts[1]).to have_content 'Title2'
        expect(posts[2]).to have_content 'Title1'
      end
    end
  end
end
