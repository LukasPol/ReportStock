FactoryBot.define do
  factory :report do
    attachment { Rack::Test::UploadedFile.new('spec/fixtures/prevents.csv', 'csv/text') }
  end
end
