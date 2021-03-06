When("I visit the site") do
    visit root_path
end

When("I visit the journalist page") do
    visit new_article_path
end

Given("the following articles exist") do |table|
    table.hashes.each do |article|
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

Given("the following categories exist") do |table|
    table.hashes.each do |category|
        create(:category, category)
    end
end

Given("I am logged in as {string}") do |email|
    user = User.find_by(email: email)
    login_as(user, scope: :user)
end    

Then("I fill in {string} with {string}") do |field, input|
    fill_in field, with: input
end

When("I click {string}") do |element|
    click_on element
end