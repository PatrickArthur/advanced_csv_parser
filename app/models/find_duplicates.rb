# finds duplicates and hard to find duplicates

require 'levenshtein'

class FindDuplicates
  def search_duplicates
    # takes initial lines and finds lines that equal since characters are all same
    lines.sort_by { |k| k['id'] }
    dups = lines.select { |e| lines.count(e) > 1 }
    # takes lines and dups and removes dups fron list
    create_dup_list(dups)
    # finds hard to find dups
    find_duplicates
  end

  def find_duplicates
    lines.each do |line|
      lines.each do |line2|
        next if line == line2
        is_dup = if check_nil_fields(line, line2) == true
                   true
                 else
                   string_difference_percent(line.values.join, line2.values.join)
                 end
        is_dup ? create_dup_list([line, line2]) : nil
      end
    end
  end

  def string_difference_percent(a, b)
    val = Levenshtein.distance(a, b)
    val <= 25
  end

  def check_nil_fields(line, line2)
    if line2.select { |_k, v| v.nil? }.count >= 3
      val = line2.reject { |_k, v| v.nil? }
      val2 = line.select { |k, _v| val.keys.include? k }
      string_difference_percent(val.values.join, val2.values.join)
    end
  end

  def create_dup_list(dups)
    dups.each do |dup|
      lines.delete(dup)
      dup["csv_id"] = dup.delete("id")
      import.duplicates.create(dup)
    end
  end
end
