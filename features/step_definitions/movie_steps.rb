# Completed step definitions for basic features: AddMovie, ViewDetails, EditMovie 

Given /^I am on the RottenPotatoes home page$/ do
  visit movies_path
 end


 When /^I have added a movie with title "(.*?)" and rating "(.*?)"$/ do |title, rating|
  visit new_movie_path
  fill_in 'Title', :with => title
  select rating, :from => 'Rating'
  click_button 'Save Changes'
 end

 Then /^I should see a movie list entry with title "(.*?)" and rating "(.*?)"$/ do |title, rating| 
   result=false
   all("tr").each do |tr|
     if tr.has_content?(title) && tr.has_content?(rating)
       result = true
       break
     end
   end  
  expect(result).to be_truthy
 end

 When /^I have visited the Details about "(.*?)" page$/ do |title|
   visit movies_path
   click_on "More about #{title}"
 end


 Then /^(?:|I )should see "([^\"]*)"$/ do |text|
    expect(page).to have_content(text)
 end
 
 When /^I have edited the movie "(.*?)" to change the rating to "(.*?)"$/ do |movie, rating|
  click_on "Edit"
  select rating, :from => 'Rating'
  click_button 'Update Movie Info'
 end


# New step definitions to be completed for HW5. 
# Note that you may need to add additional step definitions beyond these


# Add a declarative step here for populating the DB with movies.

Given /the following movies have been added to RottenPotatoes:/ do |movies_table|
  # Remove this statement when you finish implementing the test step
  movies_table.hashes.each do |movie|
    # Each returned movie will be a hash representing one row of the movies_table
    # The keys will be the table headers and the values will be the row contents.
    # Entries can be directly to the database with ActiveRecord methods
    # Add the necessary Active Record call(s) to populate the database.
    Movie.create(movie)
  end
end

When /^I have opted to see movies rated: "(.*?)"$/ do |arg1|
  # HINT: use String#split to split up the rating_list, then
  # iterate over the ratings and check/uncheck the ratings
  # using the appropriate Capybara command(s)

  Movie.all_ratings.each do |rating|
     if !arg1.split(', ').include? rating
         uncheck("ratings_#{rating}")
     end
 end
 click_button 'Refresh'
  #remove this statement after implementing the test step
end

Then /^I should see only movies rated: "(.*?)"$/ do |arg1|
  #remove this statement after implementing the test step
  i = 1
  arg1.split(', ').each do |rating|
    i = Movie.where(:rating => rating).count + i
  end
  page.all("table#movies tr").count.should == i
end

Then /^I should see all of the movies$/ do
  #remove this statement after implementing the test step
  Movie.all_ratings.each do |rating|
    page.all("table#movies tr").count.should == Movie.count + 1
    end
end

When /^I have sorted the movies alphabetically$/ do 
    click_link('Movie Title')
end

When /^I have sorted the movies in increasing order of release date$/ do
    click_link('Release Date')
end



