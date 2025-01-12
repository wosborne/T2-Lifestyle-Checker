require 'rails_helper'
require 'json'
require 'ostruct'

RSpec.describe AuthenticatePatientIdentityService do
  let(:api_url) { "#{AuthenticatePatientIdentityService::API_URL}#{nhs_number}" }
  let(:net_http) { Net::HTTP }
  let(:nhs_number) { '1234567890' }
  let(:surname) { 'Doe' }
  let(:dob) { '1980-01-01' }

  describe '#call' do
    subject { described_class }

    context 'when the patient is found' do
      let(:body) { { 'name' => surname, 'born' => dob, 'nhsNumber' => nhs_number } }

      it 'returns the patients details' do
        response = OpenStruct.new(code: 200, body: body.to_json)
        allow(net_http).to receive(:start).and_return(response)

        params = {
          nhs_number: nhs_number,
          surname: surname,
          date_of_birth: dob
        }

        expect(subject.call(params)).to eq body
      end
    end

    context "when a patient is found but the details don't match" do
      let(:body) { { 'name' => 'Blogs', 'born' => '1990-01-01', 'nhsNumber' => nhs_number } }

      it 'returns false' do
        response = OpenStruct.new(code: 200, body: body.to_json)
        allow(net_http).to receive(:start).and_return(response)

        params = {
          nhs_number: nhs_number,
          surname: surname,
          date_of_birth: dob
        }


        expect(subject.call(params)).to eq false
      end
    end

    context 'when the patient is not found' do
      it 'returns false' do
        response = OpenStruct.new(code: 404, body: {}.to_json)
        allow(net_http).to receive(:start).and_return(response)

        params = {}

        expect(subject.call(params)).to eq false
      end
    end
  end
end