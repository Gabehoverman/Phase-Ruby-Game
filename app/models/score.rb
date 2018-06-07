class Score < ActiveRecord::Base
	belongs_to :student
    has_many :results
	has_many :questions
	has_many :chapters

 after_save do

 	if self.of_value == nil
    self.of_value = Question.where(:chapter_id => self.chapter_id).count
    self.save


    if self.is_value
    self.final_score = (self.is_value.to_f / self.of_value.to_f) * 100
	end
	
    self.save

	end

	if self.is_value == nil
	# self.is_value = Result.where(:isanswercorrect => true).count(:score_id => self.id)
	self.is_value = self.results.where(:isanswercorrect => true).count
	self.save


	if self.of_value
    self.final_score = (self.is_value.to_f / self.of_value.to_f) * 100
	end

	self.save

	end



end

end
