require 'levenshtein'

class FindDuplicates

  def find_duplicates(lines, duplicates)
    lines.sort_by { |k| k["id"] }
    dups = lines.select { |e| lines.count(e) > 1 }
    create_dup_list(dups, lines, duplicates)
    secondary_duplicates(lines, duplicates)
  end

  def secondary_duplicates(lines, duplicates)
    lines.each do |line|
      lines.each do |line2|
        unless line == line2
          if line2.values.any?{|v| v.nil? || v.length == 0}
            is_dup = check_nil_fields(line, line2)
          else
            is_dup = string_difference_percent(line.values.join, line2.values.join)
          end
          is_dup ? create_dup_list([line, line2], lines, duplicates): nil
        end
      end
    end
  end

  def string_difference_percent(a, b)
    val = Levenshtein.distance(a, b)
    val <= 25 ? true : false
  end

  def check_nil_fields(line, line2)
    line2.each do |k,v|
      if v.nil?
        line.delete(k)
        line2.delete(k)
      end
    end
    string_difference_percent(line.values.join, line2.values.join)
  end

  def create_dup_list(dups, lines, duplicates)
    dups.each do |dup|
      lines.delete(dup)
      duplicates << dup
    end
  end
end
