require 'levenshtein'

class FindDuplicates

  def find_duplicates(lines, duplicates)
    #takes initial lines and finds lines that equal since characters are all same
    lines.sort_by { |k| k["id"] }
    dups = lines.select { |e| lines.count(e) > 1 }
    #takes lines and dups and removes dups fron list
    create_dup_list(dups, lines, duplicates)
    #finds hard to find dups
    find_duplicates(lines, duplicates)
  end

  def find_duplicates(lines, duplicates)
    lines.each do |line|
      lines.each do |line2|
        unless line == line2
          if check_nil_fields(line, line2) == true
            is_dup = true
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
    line_count = line.select {|k,v| v.nil?}.count
    line2_count = line2.select {|k,v| v.nil?}.count
    if line2_count >= 3
      val = line2.select {|k,v| !v.nil?}
      val2 = line.select {|k,v| val.keys.include? k}
      string_difference_percent(val.values.join, val2.values.join)
    end
  end

  def create_dup_list(dups, lines, duplicates)
    dups.each do |dup|
      lines.delete(dup)
      duplicates << dup
    end
  end
end
