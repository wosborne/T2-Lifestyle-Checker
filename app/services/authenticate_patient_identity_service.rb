require 'net/http'
require 'json'

class AuthenticatePatientIdentityService < ApplicationService
  API_URL = Rails.application.credentials.dig(:patient_auth, :api_url)
  SUBSCRIPTION_KEY = Rails.application.credentials.dig(:patient_auth, :secret)

  def initialize(params)
    @nhs_number = params[:nhs_number]
    @surname = params[:surname]
    @date_of_birth = format_date(params[:date_of_birth])
  end

  def call
    return false if response.code == 404 
    return false unless patient_data_valid?

    patient_data
  end

  private

  def uri
    URI("#{API_URL}#{@nhs_number}")
  end

  def patient_authentication_request
    request = Net::HTTP::Get.new(uri)
    request['Ocp-Apim-Subscription-Key'] = SUBSCRIPTION_KEY

    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
  end

  def response
    @response ||= patient_authentication_request
  end

  def patient_data
    @patient_data ||= JSON.parse(response.body)
  end

  def patient_data_valid?
    patient_surname == @surname.downcase &&
    patient_data['born'] == @date_of_birth &&
    patient_data['nhsNumber'] == @nhs_number
  end

  def patient_surname
    patient_data['name']&.split(',')&.first&.downcase
  end

  def format_date(date)
    return nil if date.blank?

    Date.parse(date).strftime('%d-%m-%Y')
  rescue ArgumentError
    nil
  end
end