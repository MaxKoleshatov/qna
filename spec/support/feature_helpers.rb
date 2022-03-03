module FeatureHelpers
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  def sign_up
    visit new_user_registration_path
    fill_in 'Email', with: "user@test.com"
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'
  end

  def create_answer
    click_on 'All questions'
    click_on 'MyStringQuestion'
    fill_in 'Text', with: 'SomeText'
    click_on 'Create Answer'
  end

  def create_question
    click_on 'Create new question'
    fill_in 'Title', with: "Some Title"
    fill_in 'Body', with: "Some body"
    click_on 'Create Question'
  end
end
