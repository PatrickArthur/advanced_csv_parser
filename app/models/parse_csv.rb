require 'csv'

class ParseCsv < FindDuplicates
  attr_reader :file
  attr_accessor :lines, :duplicates

  def initialize(file)
    @file = file
    @lines = []
    @duplicates = []
  end

  def read_find_dups
    CSV.foreach(file, headers: true) {|row| lines << row.to_h}
    find_duplicates(lines, duplicates)
    record = Record.create(import: lines, duplicate_records: duplicates)
  end

end
