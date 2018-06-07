class Student < ActiveRecord::Base

STUDENTID_REGEX = /\A[A-Za-z]{4}\d{4}\z/
belongs_to :instructor
	has_many :results
    has_many :scores

	validates :student_id, 
		uniqueness: { :case_sensitive => false }, 
		presence: true, 
		:format => STUDENTID_REGEX
	validates :instructor_id,
	    presence: true 


def self.to_csv(options = {})
  CSV.generate(options) do |csv|
    csv.add_row column_names

    all.each do |foo|
      values = foo.attributes.values
      csv.add_row values
    end

  end

end

# def self.csv
#     all.map do |object|
#       ( object.attributes.values + object.children.map(&:student_id) ).flatten.join(',')
#     end.join("\n")

# end




def self.to_csv_masterreport(options = {})
  CSV.generate(options) do |csv|


  wanted_columns_for_student = [:student_id, :active]
  wanted_columns_for_score = [:id, :chapter_id, :is_value, :of_value, :final_score, :updated_at]
  wanted_columns_for_results = [:question_id, :student_answer, :isanswercorrect]

  displayed_columns_for_student = [:student_id, :is_student_enrolled?]
  displayed_columns_for_score = [:score_id, :chapter, :score_is_value, :score_of_value, :final_score, :score_date]
  displayed_columns_for_results = [ :question_id, :student_answer, :isanswercorrect, :question]

first_time_around = 0
    # csv.add_row displayed_columns_for_student + displayed_columns_for_score 

    all.each do |foo|

      values = foo.slice(*wanted_columns_for_student).values

scores = foo.scores.select('*')

if foo.scores.first != nil
largest_of_value = scores.maximum(:of_value)

result_columns = Array.new
(1..largest_of_value).each do |i|
  if i == 1
  result_columns =   displayed_columns_for_results
  else
result_columns = result_columns + displayed_columns_for_results
end

end

# set col headings
if first_time_around == 0
csv.add_row csv.add_row displayed_columns_for_student + displayed_columns_for_score + result_columns
end

first_time_around = first_time_around + 1 

for each in foo.scores do
thatscore = each.slice(*wanted_columns_for_score).values
results = each.results.select('*')
# csv.add_row values + thatscore 

myresult = Array.new
if results.first != nil
for result in results do

#   myresult = result.attributes.values
# if myresult != nil
question_describer = result.question.question_desc
  # myresult =  myresult << question_describer 
  myresult = myresult + result.slice(*wanted_columns_for_results).values << question_describer 
# end
  

end
 
end
csv.add_row values + thatscore  + myresult

end

else
csv.add_row values + ["no scores", "no scores", "no scores", "no scores"]
end

    end
  end
end

def self.to_csv_masterreport_debug(options = {})
  CSV.generate(options) do |csv|


  wanted_columns_for_student = [:student_id, :active]
  wanted_columns_for_score = [:chapter_id, :is_value, :of_value, :final_score, :updated_at]

  displayed_columns_for_student = [:student_id, :is_student_enrolled?]
  displayed_columns_for_score = [:chapter, :score_is_value, :score_of_value, :final_score, :score_date]

    csv.add_row wanted_columns_for_student + wanted_columns_for_score

    all.each do |foo|

      values = foo.slice(*wanted_columns_for_student).values


scores = foo.scores.select('*')

if foo.scores.first != nil
for each in foo.scores do

thatscore = each.slice(*wanted_columns_for_score).values

      csv.add_row values + thatscore

end

else
csv.add_row values
end

# values = values + first.scores.values.to_a
#       csv.add_row values
      # csv.add_row values
    end
  end
end

def self.to_csv_chapterreport_debug(options = {})
  CSV.generate(options) do |csv|


  wanted_columns_for_student = [:student_id, :active]
  wanted_columns_for_score = [:chapter_id, :is_value, :of_value, :final_score, :updated_at]

  displayed_columns_for_student = [:student_id, :is_student_enrolled?]
  displayed_columns_for_score = [:chapter, :score_is_value, :score_of_value, :final_score, :score_date]

    csv.add_row wanted_columns_for_student + wanted_columns_for_score

    all.each do |foo|

      values = foo.slice(*wanted_columns_for_student).values


scores = foo.scores.select('*')

if foo.scores.first != nil
for each in foo.scores do

thatscore = each.slice(*wanted_columns_for_score).values

      csv.add_row values + thatscore

end

else
csv.add_row values
end

# values = values + first.scores.values.to_a
#       csv.add_row values
      # csv.add_row values
    end
  end
end

def self.to_csv_chapterreport(options = {})
 CSV.generate(options) do |csv|


  wanted_columns_for_student = [:student_id, :active]
  wanted_columns_for_score = [:chapter_id, :is_value, :of_value, :final_score, :updated_at]

  displayed_columns_for_student = [:student_id, :is_student_enrolled?]
  displayed_columns_for_score = [:chapter, :score_is_value, :score_of_value, :final_score, :score_date]

    csv.add_row wanted_columns_for_student + wanted_columns_for_score

    all.each do |foo|

      values = foo.slice(*wanted_columns_for_student).values


scores = foo.scores.select('*')

if foo.scores.first != nil
for each in foo.scores do

thatscore = each.slice(*wanted_columns_for_score).values

      csv.add_row values + thatscore

end

else
csv.add_row values + ["no scores", "no scores", "no scores", "no scores"]
end

# values = values + first.scores.values.to_a
#       csv.add_row values
      # csv.add_row values
    end
  end
  
end



def self.to_csv_studentreport(options = {})
  CSV.generate(options) do |csv|

  wanted_columns_for_student = [:student_id, :active]
  wanted_columns_for_score = [:chapter_id, :is_value, :of_value, :final_score, :updated_at]

  displayed_columns_for_student = [:student_id, :is_student_enrolled?]
  displayed_columns_for_score = [:chapter, :score_is_value, :score_of_value, :final_score, :score_date]

    csv.add_row wanted_columns_for_student + wanted_columns_for_score

    all.each do |foo|

      values = foo.slice(*wanted_columns_for_student).values


scores = foo.scores.select('*')

if foo.scores.first != nil
for each in foo.scores do

thatscore = each.slice(*wanted_columns_for_score).values

      csv.add_row values + thatscore

end

else
csv.add_row values + ["no scores", "no scores", "no scores", "no scores"]
end

# values = values + first.scores.values.to_a
#       csv.add_row values
      # csv.add_row values
    end
  end
  
end



def self.to_csv_studentreport_debug(options = {})
  CSV.generate(options) do |csv|


  wanted_columns_for_student = [:student_id, :active]
  wanted_columns_for_score = [:chapter_id, :is_value, :of_value, :final_score, :updated_at]

  displayed_columns_for_student = [:student_id, :is_student_enrolled?]
  displayed_columns_for_score = [:chapter, :score_is_value, :score_of_value, :final_score, :score_date]

    csv.add_row wanted_columns_for_student + wanted_columns_for_score

    all.each do |foo|

      values = foo.slice(*wanted_columns_for_student).values


scores = foo.scores.select('*')

if foo.scores.first != nil
for each in foo.scores do

thatscore = each.slice(*wanted_columns_for_score).values

      csv.add_row values + thatscore

end

else
csv.add_row values
end

# values = values + first.scores.values.to_a
#       csv.add_row values
      # csv.add_row values
    end
  end

end




def self.to_csv_debug_original(options = {})
  CSV.generate(options) do |csv|

  wanted_columns_for_student = [:id, :student_id,  :active  ,:created_at,  :updated_at]
  wanted_columns_for_score = []

    csv.add_row column_names + first.scores.column_names

    all.each do |foo|

      values = foo.attributes.values


scores = foo.scores.select('*')

if foo.scores.first != nil
for each in foo.scores do

thatscore = each.attributes.values

      csv.add_row values + thatscore

end

else
csv.add_row values
end

# values = values + first.scores.values.to_a
#       csv.add_row values
      # csv.add_row values
    end
  end
end

def self.to_csv_with_bar(options = {})
  CSV.generate(options) do |csv|
    bar = Score.column_names
    csv.add_row column_names + bar

    all.each do |foo|

    values = foo.attributes.values
    #scores = Score.where(:student_id => foo.id)

    # for score in scores do 
      # if foo.bar
      #   values += foo.Result.attributes.values
      # end
# scores.count do |score|
      # csv.add_row values +scores.values
# end
    # end
          # csv.add_row values +scores.values.to_a
      csv.add_row values +foo.scores

    end


  end
end

def self.to_csv2(options = {})
  CSV.generate(options) do |csv|

    csv.add_row column_names  +

    all.each do |foo|
      values = foo.attributes.values

      results = Result.where(:student_id => foo.id)

      # for result in results do
      csv.add_row values + results.values.to_a
    # end
    # results = Result.where(:student_id => foo.id)
    #   csv.add_row results

    end
  end
end




def self.to_csv_with_results(options = {})
 Student.find_each do |student|
  CSV.generate do |csv|
    csv << student.to_csv
  end
  result = Result.find(:student_id => student.student_id)
  result.update_attribute :data, csv_data
end
end


def self.to_csv_table(foo_attributes = column_names, bar_attributes = bar.column_names, options = {})

  CSV.generate(options) do |csv|
    csv.add_row foo_attributes + bar_attributes

    all.each do |foo|

      values = foo.attributes.slice(*foo_attributes).values

      if foo.contact_details
        values += foo.contact_details.attributes.slice(*bar_attributes).values
      end

      csv.add_row values
    end
  end
end


  def self.to_other_csv
    all.map do |object|
      ( object.attributes.values + object.children.map(&:child_field) ).flatten.join(',')
    end.join("\n")
  end

def self.to_csv_with_result(options = {})
  CSV.generate(options) do |csv|
    csv.add_row column_names + self.result.column_names

    all.each do |result|

      values = result.attributes.values

      if foo.result
        values += foo.result.attributes.values
      end

      csv.add_row values
    end
  end
end
#http://stackoverflow.com/questions/14106863/rails-3-export-to-csv-model-and-all-its-has-many-children-models-into-one-fil
def download    

@students = Student.all
# find maximum number of children any parent has. Make sure to convert to integer.
@max_children = Result.select('student_id, COUNT(student_id)').group(:student_id).order('COUNT(student_id) DESC').first.count.to_i

@parent_columns = Student.column_names
@child_columns = Result.column_names

@streaming = true
@filename = "export.csv"

respond_to do |format|
   format.html{redirect_to root_url}
  format.csv
end
end

end
