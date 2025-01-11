require 'net/http'
require 'json'

class AuthenticatePatientIdentityService < ApplicationService
  API_URL = Rails.application.credentials.dig(:patient_auth, :api_url)
  SUBSCRIPTION_KEY = Rails.application.credentials.dig(:patient_auth, :secret)

  def initialize(params)
    @nhs_number = params[:nhs_number]
    @surname = params[:surname]
    @date_of_birth = params[:date_of_birth]
  end

  def call
    response = patient_authentication_request

    return false if response.code == 404

    patient_data = JSON.parse(response.body)

    patient_data || false
  end

  private

  def uri
    URI("#{API_URL}#{@nhs_number}")
  end

  def patient_authentication_request
    request = Net::HTTP::Get.new(uri)
    request['Ocp-Apim-Subscription-Key'] = SUBSCRIPTION_KEY

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    response
  end
end