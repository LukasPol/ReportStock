class ReportsController < ApplicationController
  before_action :set_report, only: %i[show destroy]

  def show; end

  def new
    @report = Report.new
  end

  def create
    service = CreateReportService.call(report_params[:attachment])
    @report = service.result

    if service.success? && @report.valid?
      @report.save!
      redirect_to report_url(@report), notice: 'Report was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @report.destroy

    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:attachment)
  end
end
