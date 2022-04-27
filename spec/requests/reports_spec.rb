require 'rails_helper'

RSpec.describe '/reports', type: :request do
  let(:report) { create(:report) }

  let(:valid_attributes) do
    { attachment: Rack::Test::UploadedFile.new('spec/fixtures/prevents.csv', 'text/csv') }
  end

  let(:invalid_attributes) do
    { attachment: Rack::Test::UploadedFile.new('spec/fixtures/empty.csv', 'text/csv') }
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get report_url(report)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_report_url
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Report' do
        expect do
          post reports_url, params: { report: valid_attributes }
        end.to change(Report, :count).by(1)
      end

      it 'redirects to the created report' do
        post reports_url, params: { report: valid_attributes }
        expect(response).to redirect_to(report_url(Report.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Report' do
        expect do
          post reports_url, params: { report: invalid_attributes }
        end.to change(Report, :count).by(0)
      end
    end
  end
  describe 'DELETE /destroy' do
    it 'destroys the requested report' do
      expect do
        delete report_url(report)
      end.to change(Report, :count).by(0)
    end

    it 'redirects to the reports list' do
      delete report_url(report)
      expect(response).to redirect_to(root_url)
    end
  end
end
