Then("I should see {string}") do |content|
    expect(page).to have_content content
end

Then("I should not see {string}") do |content|
    expect(page).to have_no_content content
end 

Then("I should be on the landing page") do
    expect(current_path).to eq root_path
end

Then("{string} should be a {string}") do |email, role|
    user = User.find_by(email: email)
    expect(user.role).to eq role
end

Then("I should see the image {string}") do |image|
    expect(page).to have_xpath("//img[contains(@src, \"#{image}\")]")   
end

Then("I should not see the image {string}") do |image|
    expect(page).to have_no_xpath("//img[contains(@src, \"#{image}\")]")  
end

Then("I fill in {string} with {string}") do |field, input|
    fill_in field, with: input
end