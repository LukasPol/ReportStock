require 'rails_helper'

describe ProcessingCsvService do
  subject { described_class.call(@file) }

  describe '.call' do
    context 'send a csv' do
      it 'should returns the report valid' do
        @file = Rack::Test::UploadedFile.new('spec/fixtures/prevents.csv', 'text/csv')

        expect(subject).to be_success
      end

      it 'should returns the report invalid' do
        @file = Rack::Test::UploadedFile.new('spec/fixtures/empty.csv', 'text/csv')

        expect(subject).to be_failure
      end

      it 'should returns service with errors' do
        @file = Rack::Test::UploadedFile.new('spec/fixtures/empty.csv', 'text/csv')

        expect(subject.errors.to_json).to eq({ attachment: 'File Empty' }.to_json)
      end
    end
  end
end
