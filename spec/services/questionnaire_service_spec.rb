require 'rails_helper'

RSpec.describe QuestionnaireService, type: :service do
  let(:answers) do
    [
      { question_id: 1, value: 'yes' },
      { question_id: 2, value: 'yes' },
      { question_id: 3, value: 'no' }
    ]
  end
  let(:date_today) { Date.new(2021, 1, 1) }

  before :each do
    allow(Date).to receive(:today).and_return(date_today)
  end

  describe '#score' do
    context 'when the patient is 21 years old' do
      it 'calculates the correct score' do
        patient = { 'born' => '2000-01-01' }
        service = described_class.new(answers, patient)

        expect(service.score).to eq(4)
      end
    end

    context 'when the patient is 40 years old' do
      it 'calculates the correct score' do
        patient = { 'born' => '1981-01-01' }
        service = described_class.new(answers, patient)

        expect(service.score).to eq(7)
      end
    end

    context 'when the patient is 63 years old' do
      it 'calculates the correct score' do
        patient = { 'born' => '1958-01-01' }
        service = described_class.new(answers, patient)

        expect(service.score).to eq(7)
      end
    end

    context 'when the patient is 65 years old' do
      it 'calculates the correct score' do
        patient = { 'born' => '1956-01-01' }
        service = described_class.new(answers, patient)

        expect(service.score).to eq(7)
      end
    end
  end
end
