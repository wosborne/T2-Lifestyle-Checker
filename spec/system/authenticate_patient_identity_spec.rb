require 'rails_helper'

RSpec.describe 'AuthenticatePatientIdentity', type: :system do
  let(:auth_service) { AuthenticatePatientIdentityService }

  it 'authenticates a patient with valid credentials' do
    response = { 'name' => 'DOE, John', 'born' => '01-01-1970', 'nhsNumber' => '1234567890' }
    allow(auth_service).to receive(:call).and_return(response)
    visit root_path
    click_link_or_button 'Continue'

    fill_in 'NHS number', with: '1234567890'
    fill_in 'Surname', with: 'Doe'
    fill_in 'Date of birth', with: '1970-01-01'
    click_button 'Continue'

    expect(page).to have_content('You have been successfully authenticated')
    expect(page).to have_content("Please answer the following questions")
  end

  it 'does not authenticate a patient with invalid credentials' do
    response = false
    allow(auth_service).to receive(:call).and_return(response)

    visit root_path
    click_link_or_button 'Continue'

    fill_in 'NHS number', with: '1234567890'
    fill_in 'Surname', with: 'Doe'
    fill_in 'Date of birth', with: '01/01/1971'
    click_button 'Continue'

    expect(page).to have_content('Your details could not be found')
    expect(page).to have_content("Enter Your Details")
  end
end