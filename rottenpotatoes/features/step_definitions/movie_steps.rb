# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    unless Movie.exists?(:title => movie[:title])
      Movie.create(:title => movie[:title], :release_date => movie[:release_date], :rating => movie[:rating])
    end
  end
  #fail "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page
Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page).to have_xpath('//*', :text => /#{e1}.*#{e2}/)

  #fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_arr = rating_list.split(%r{,\s*})
  rating_arr.each do |rating|
    if uncheck == 'un'
      uncheck("ratings[#{rating}]")
    else
      check("ratings[#{rating}]")
    end
  end
  #fail "Unimplemented"
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  movie_count = Movie.count
  page.assert_selector('table#movies tbody tr', :count => movie_count)
  #fail "Unimplemented"
end
