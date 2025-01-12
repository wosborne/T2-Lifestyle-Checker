require 'rails_helper'

RSpec.describe "Questionnaires", type: :system do
  let(:auth_service) { AuthenticatePatientIdentityService }    

  it 'shows a message for a score of 3 or less' do
    response = { 'name' => 'DOE, John', 'born' => '01-01-2000', 'nhsNumber' => '1234567890' }
    allow(auth_service).to receive(:call).and_return(response)

    visit root_path
    click_link_or_button 'Continue'

    fill_in 'NHS number', with: '1234567890'
    fill_in 'Surname', with: 'Doe'
    fill_in 'Date of birth', with: '1970-01-01'
    click_button 'Continue'

    select "No", from: "select-1"
    select "No", from: "select-2"
    select "Yes", from: "select-3"

    click_button 'Submit'

    expect(page).to have_content("Thank you for answering our questions, we don't need to see you at this time. Keep up the good work!")
  end

  it 'shows a message for a score of 4 or more' do
    response = { 'name' => 'DOE, John', 'born' => '01-01-2000', 'nhsNumber' => '1234567890' }
    allow(auth_service).to receive(:call).and_return(response)

    visit root_path
    click_link_or_button 'Continue'

    fill_in 'NHS number', with: '1234567890'
    fill_in 'Surname', with: 'Doe'
    fill_in 'Date of birth', with: '1970-01-01'
    click_button 'Continue'

    select "Yes", from: "select-1"
    select "Yes", from: "select-2"
    select "No", from: "select-3"

    click_button 'Submit'

    expect(page).to have_content("We think there are some simple things you could do to improve you quality of life, please phone to book an appointment")
  end
end
