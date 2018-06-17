class Record < ActiveRecord::Base
  serialize :import
  serialize :duplicate_records
end
