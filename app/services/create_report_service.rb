class CreateReportService
  prepend SimpleCommand

  attr_reader :file, :report

  def initialize(file)
    @file = file
    @report = Report.new
  end

  def call
    service = ProcessingFileService.call(file)

    if service.success?
      add_file_in_report(filename: service.result[:filename])
    else
      service.errors.each_key do |key|
        add_errors(key, service.errors[key][0])
      end
    end

    report
  end

  private

  def add_file_in_report(filename:)
    report.attachment.attach(io: File.open(filename), filename: filename)

    File.delete(filename)
  end

  def file_supported?
    ['text/csv'].include? file.content_type
  end

  def add_errors(key, message)
    errors.add(key, message)
    report.errors.add(key, message)
  end
end
