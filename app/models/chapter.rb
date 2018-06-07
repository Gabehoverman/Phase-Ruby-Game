class Chapter < ActiveRecord::Base
     has_many :results
     has_many :questions

     	validates :chapter_number,
		:presence => true,
		:uniqueness => true,
		:case_sensitive => false

def number_with_title
    "#{chapter_number}: #{chapter_title}"
  end


def self.to_csv(options = {})
  CSV.generate(options) do |csv|
    csv.add_row column_names
    all.each do |foo|
      values = foo.attributes.values
      csv.add_row values
    end
  end
end
end
