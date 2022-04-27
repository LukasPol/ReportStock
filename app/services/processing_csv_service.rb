require 'csv'

class ProcessingCsvService
  prepend SimpleCommand

  def initialize(file)
    @report = Report.new
    @file = CSV.read(file, headers: true, col_sep: ';')
    @types = ['Dividendo', 'Juros Sobre Capital Próprio']
    @stocks = normalize_name_stocks
    @filename = "tmp/csv/#{DateTime.now}.csv"
  end

  def call
    if rows?
      process
    else
      errors.add(:attachment, 'File Empty')
    end

    filename
  end

  private

  attr_reader :file, :types, :stocks, :filename, :report

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
end
