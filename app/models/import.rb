class Import < ActiveRecord::Base
  has_many :records
  has_many :duplicates

  after_create :parse_csv

  def parse_csv
    parse = ParseCsv.process(self)
  end
end
