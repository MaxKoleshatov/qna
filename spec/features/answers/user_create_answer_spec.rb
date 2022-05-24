# frozen_string_literal: true

require 'rails_helper'

feature 'User can answer question', %(
  to convey information
) do
  given!(:question) { create(:question) }
  given!(:counter1) {create(:counter_question, counterable_id: question.id, counterable_type: question.class)}
  # given!(:counter2) {create(:counter_answer, counterable_id: answer.id, counterable_type: answer.class)}

  describe 'Authenticated user' do
    given(:user) { create(:user) }

    scenario 'Authenticated user create answer', js: true do
      sign_in(user)

      visit question_path(question)

      fill_in 'Text', with: 'SomeText'
      click_on 'Create Answer'

      within '.answers' do
        expect(page).to have_content 'SomeText'
      end
    end

    scenario 'Authenticated user can create answer with an attached file', js: true do
      sign_in(user)

      visit question_path(question)
      fill_in 'Text', with: 'SomeText'

      attach_file 'File',
                  ["#{Rails.root}/spec/features/images/image_1.rb", "#{Rails.root}/spec/features/images/image_2.rb"]

      click_on 'Create Answer'

      expect(page).to have_link 'image_1.rb'
      expect(page).to have_link 'image_2.rb'
    end

    scenario 'Authenticated user creates response with errors', js: true do
      sign_in(user)

      visit question_path(question)
      click_on 'Create Answer'

      expect(page).to have_content "Text can't be blank"
    end
  end

  describe 'Unauthenticated user' do
    scenario 'Unauthenticated user creates answers' do
      visit root_path

      click_on 'All questions'
      click_on 'MyStringQuestion'
      fill_in 'Text', with: 'SomeText'
      click_on 'Create Answer'

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
      expect(page).not_to have_content 'SomeText'
    end

    scenario 'Unauthenticated user creates answers with attached files' do
      visit root_path

      click_on 'All questions'
      click_on 'MyStringQuestion'

      attach_file 'File',
                  ["#{Rails.root}/spec/features/images/image_1.rb", "#{Rails.root}/spec/features/images/image_2.rb"]
      click_on 'Create Answer'

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
      expect(page).not_to have_link 'image_1.rb'
      expect(page).not_to have_link 'image_2.rb'
    end
  end
end
