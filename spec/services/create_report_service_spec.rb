require 'rails_helper'

describe CreateReportService do
  subject { described_class.call(@file) }

  describe '.call' do
    context 'Create Report' do
      it 'should return service success' do
        @file = Rack::Test::UploadedFile.new('spec/fixtures/prevents.csv', 'text/csv')

        expect(subject).to be_success
      end

      it 'should return report valid' do
        @file = Rack::Test::UploadedFile.new('spec/fixtures/prevents.csv', 'text/csv')

        expect(subject.result).to be_valid
      end
    end

    context 'Report invalid' do
      it 'should return message errors `file empty`' do
        @file = Rack::Test::UploadedFile.new('spec/fixtures/empty.csv', 'text/csv')

        expect(subject.errors.to_json).to eq({ attachment: 'File Empty' }.to_json)
      end

      it 'file not supported' do
        @file = Rack::Test::UploadedFile.new('spec/fixtures/test.pdf', 'pdf')

        expect(subject.errors.to_json).to eq({ attachment: 'File not supported' }.to_json)
      end
    end
  end
end
