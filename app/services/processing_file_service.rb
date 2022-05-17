class ProcessingFileService
  prepend SimpleCommand

  attr_reader :file, :filename, :types, :stocks

  def initialize(file)
    @filename = "tmp/csv/#{DateTime.now}.csv"
    @file = check_file(file)
    @types = ['Dividendo', 'Juros Sobre Capital Próprio']
  end

  def call
    unless file
      errors.add(:attachment, 'File not supported')
      return
    end

    if file && rows?
      @stocks = normalize_name_stocks
      process
    else
      errors.add(:attachment, 'File Empty')
    end

    {
      filename: filename
    }
  end

  private

  def process
    write_in_file(%w[Ação Valor Provento]) # Header

    types.each do |type|
      stocks.each do |stock|
        rows = file.select { |r| r['Produto'][0..4] == stock[0..4] && r['Movimentação'] == type }

        next if rows.empty?

        price = sum_price(rows)

        write_in_file([stock, price, type])
      end
    end
  end

  def check_file(file)
    case file.content_type
    when 'text/csv'
      CSV.read(file, headers: true, col_sep: ';')
    when 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      temp_file = Roo::Excelx.new(file)
      temp_file.to_csv(filename, ';')
      CSV.read(filename, headers: true, col_sep: ';')
    else
      errors.add(:attachment, 'File not supported')
    end
  end

  def normalize_name_stocks
    stocks = @file['Produto']

    stocks.map { |stock| stock[0..4] }.uniq.sort
  end

  def sum_price(rows)
    price = 0
    rows.each do |row|
      value = row['Valor da Operação'].delete(' R$')
      value.gsub!(',', '.')
      price += value.to_f
    end

    price.round(2)
  end

  def write_in_file(row)
    CSV.open(filename, 'a', headers: true, col_sep: ';') do |csv|
      csv << row
    end
  end

  def rows?
    file.count.positive?
  end

  def file_supported?
    %w[text/csv application/vnd.openxmlformats-officedocument.spreadsheetml.sheet].include? file.content_type
  end
end
