class Import < ActiveRecord::Base
  has_many :records
  has_many :duplicates

  after_create :parse_csv

  def parse_csv
    parse = ParseCsv.process(file)
    create_records(parse.first)
    create_duplicates(parse.last)
  end

  private

  def create_records(parse)
    parse.each do |hash|
      hash['csv_id'] = hash.delete('id')
      records.create(hash)
    end
  end

  def create_duplicates(parse)
    parse.each do |hash|
      hash['csv_id'] = hash.delete('id')
      duplicates.create(hash)
    end
  end
end
