class ReportsController < ApplicationController
  before_action :set_report, only: %i[show destroy download]

  def show; end

  def download
    send_data @report.attachment.download,
              type: :csv,
              filename: "#{DateTime.now}.csv"
  end

  def new
    @report = Report.new
  end

  def create
    service = CreateReportService.call(report_params[:attachment])
    @report = service.result

    if service.success? && @report.valid?
      @report.save!
      redirect_to report_url(@report), notice: t(:created, model: t(:report, scope: 'activerecord.models'))
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @report.destroy
    redirect_to root_path, notice: t(:deleted, model: t(:report, scope: 'activerecord.models'))
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:attachment)
  end
end
