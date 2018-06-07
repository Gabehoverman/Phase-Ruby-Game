class Result < ActiveRecord::Base

	belongs_to :student
	belongs_to :question
	belongs_to :chapter
  has_many :question_assets


	#validates :question_id,
		#:presence => true

 after_save do


   if self.isanswercorrect == nil
    #hacky idea ^ is exclusive or  (False ^ True) = True (True ^ False) = True  (False ^ False) = False (True ^ True) = False, so not that will give right answer... 
    # self.isanswercorrect = (self.student_answer ^ Question.find(self.question_id).correct_answer)
if (self.student_answer == Question.find(self.question_id).correct_answer )
self.isanswercorrect = true
else
  self.isanswercorrect = false
  end
self.save

end

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
