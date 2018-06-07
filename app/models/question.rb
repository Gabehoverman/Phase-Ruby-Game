class Question < ActiveRecord::Base
	
	 has_many :results
	 has_many :question_assets

	 validates :chapter_id,
		:presence => true
	
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
