# reads file, parses and finds dups

require 'csv'

class ParseCsv < FindDuplicates
  attr_reader :import
  attr_accessor :lines

  def self.process(import)
    new(import).read_find_dups
  end

  def initialize(import)
    @import = import
    @lines = []
  end

  def read_find_dups
    CSV.foreach(import.file, headers: true) { |row| lines << row.to_h }
    search_duplicates
    create_records
  end

  private

  def create_records
    lines.each do |record|
      record["csv_id"] = record.delete("id")
      import.records.create(record)
    end
  end
end
