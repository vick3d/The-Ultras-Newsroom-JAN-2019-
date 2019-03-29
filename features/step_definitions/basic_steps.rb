When("I visit the site") do
    visit root_path
end

When("I visit the {string} page") do |title|
    article = Article.find_by_title(title)
    visit journalist_article_path(article)
end
  
Given("I visit the editor page") do
    visit editor_articles_path
end  

When("I visit the journalist new article page") do
    visit new_journalist_article_path
end

Given("the following articles exist") do |table|
    table.hashes.each do |article|
        user = User.find_by(email: article[:user])
        article["user"] = user
        category = Category.find_or_create_by(name: article[:category])
        article.except!("category")
        new_article = create(:article, article)
        new_article.categories << category
    end
end

Given("the following users exist") do |table|
    table.hashes.each do |user|
        create(:user, user)
    end
end

Given("I am logged in as {string}") do |email|
    user = User.find_by(email: email)
    login_as(user, scope: :user)
end    


And("I click the popup") do
    page.driver.browser.switch_to.alert.accept
end

When("show me the page") do
    save_and_open_page
end

When("wait for {int} seconds") do |int|
    sleep int
end

When('I fill in the payment form with valid cc credentials') do
    stripe_frame = find("iframe[name='__privateStripeFrame5']")
    within_frame stripe_frame do
      card_field = find_field('cardnumber')
      exp_date_field = find_field('exp-date')
      cvc_field = find_field('cvc')
  
      4.times { sleep 0.2; card_field.send_keys(right: '4242'); sleep 0.2; }
      exp_date_field.send_keys('1221')
      cvc_field.send_keys('123')
    end
end

When("I fill in the payment form with invalid cc credentials") do
    stripe_frame = find("iframe[name='__privateStripeFrame5']")
    within_frame stripe_frame do
      card_field = find_field('cardnumber')
      exp_date_field = find_field('exp-date')
      cvc_field = find_field('cvc')
  
      card_field.send_keys(right: '4000000000000127')
      exp_date_field.send_keys('1221')
      cvc_field.send_keys('123')
    end
  end
And("I attach dummy_image.png") do
    attach_file('article_image', "#{::Rails.root}/spec/fixtures/dummy_image.png")
end

When("(when )I click {string}") do |element|
    click_on element
end
