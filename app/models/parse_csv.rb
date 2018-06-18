# reads file, parses and finds dups

require 'csv'

class ParseCsv < FindDuplicates
  attr_reader :file
  attr_accessor :lines, :duplicates

  def self.process(file)
    new(file).read_find_dups
  end

  def initialize(file)
    @file = file
    @lines = []
    @duplicates = []
  end

  def read_find_dups
    CSV.foreach(file, headers: true) { |row| lines << row.to_h }
    search_duplicates(lines, duplicates)
    [lines, duplicates]
  end
end
