require 'rails_helper'

RSpec.describe 'reports/new', type: :view do
  before(:each) do
    assign(:report, create(:report))
  end

  xit 'renders new report form' do
    render

    assert_select 'form[action=?][method=?]', reports_path, 'post' do
    end
  end
end
