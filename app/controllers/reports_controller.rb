class ReportsController < ApplicationController

before_action :confirm_logged_in

#http://localhost:3000/reports/score?score=1
def score
  begin

      
      if session[:type]== "instructor"

  @score = Score.find(params[:score])
  @students = Student.where(:instructor_id => session[:user_id]).where(:id => @score.student_id)

  if @students.first
    # @score = score_id
    # @students = students
   

   else
     flash[:failure] = "This score belongs to another instructor"
     redirect_to :conrtroller => :reports, :action => :student
   end


else
  @score = Score.find(params[:score])

  @students = Student.where(:id => @score.student_id)
   
end

rescue
   flash[:failure] = "Invalid Score ID"
redirect_to :conrtroller => :reports, :action => :student
end

end

#http://localhost:3000/reports/masterscore
def masterscore
  begin
      
if session[:type] == "instructor"
@students = Student.all.where(:instructor_id => session[:user_id])


  if @students.first
    # @score = score_id
    # @students = students
   else
     flash[:failure] = "This score belongs to another instructor"
     redirect_to :conrtroller => :reports, :action => :student
   end


else

  @students = Student.all
end

rescue
   flash[:failure] = "A problem occured"
redirect_to :conrtroller => :reports, :action => :student
end

end

def chapterscore
  begin
      
      if session[:type]== "instructor"
  @students = Student.all.where(:instructor_id => session[:user_id])
    @chapter = params[:chapter]
    # flash[:success] = @chapter
    # I think this is safe
    @query = 'scores.chapter_id = ' + @chapter

 # @students = @students.where("scores.chapter_id" => @chapter)
 #'scores.chapter_id = 2' 
  @students = @students.joins(:scores).where(@query).distinct

  if @students.first
   else
     flash[:failure] = "No scores"
     redirect_to :conrtroller => :reports, :action => :student
   end


else

  @students = Student.all
      @chapter = params[:chapter]
    # I think this is safe
    @query = 'scores.chapter_id = ' + @chapter

 # @students = @students.where("scores.chapter_id" => @chapter)
 #'scores.chapter_id = 2' 
  @students = @students.joins(:scores).where(@query).distinct
end

rescue
   flash[:failure] = "Invalid Score ID"
redirect_to :conrtroller => :reports, :action => :student
end

end


def studentscore

   begin
      
      if session[:type]== "instructor"
  @students = Student.where(:id => params[:student]).where(:instructor_id => session[:user_id])   


  if @students.first
   else
     flash[:failure] = "No scores"
     redirect_to :conrtroller => :reports, :action => :student
   end


else
  @students = Student.where(:id => params[:student])

end

rescue
   flash[:failure] = "Invalid Score ID"
redirect_to :conrtroller => :reports, :action => :student
end

end
def findscoreid
if(params[:commit] == "View Score Report")
  redirect_to :conrtroller => :reports, :action => :score, :score => params[:score][:score_id]
else



begin

  @score = Score.find(params[:score][:score_id])

  redirect_to report_scorereport_path(format: :csv, :score => @score)
   # respond_to do |format|

   #  format.html{redirect_to root_url}
   #  format.csv{send_data @students.to_csv_masterreport_debug}
   #  end

  rescue
 flash[:failure] = "Invalid Score ID"
redirect_to :conrtroller => :reports, :action => :student
end
  end

end


def scorereport 
  if session[:type]== "instructor"
    # Student.all.where(:instructor_id => session[:user_id])
  @score = Score.find(params[:score])
  @student = Student.where(:instructor_id => session[:user_id]).where(:id => @score.student_id)


if @student.first


  # flash[:success] = @student.first.id
  # @students = @students.joins(:results)
  respond_to do |format|
    format.html{redirect_to :conrtroller => :reports, :action => :student}
    format.csv{send_data @student.to_csv_masterreport}
    # @students.to_csv_with_result
    # format.csv do
    #   headers['Content-Disposition'] = "attachment; filename=\"student-list\""
    #   headers['Content-Type'] ||= 'text/csv'
    # end
  end
  else
     flash[:failure] = "This score belongs to another instructor"
     redirect_to :conrtroller => :reports, :action => :student

    end



  else 
      @score = Score.find(params[:score])

  @student = Student.where(:id => @score.student_id)

   respond_to do |format| 
    #http://localhost:3000/scorereport.csv?

    format.html{redirect_to root_url}
    format.csv{send_data @student.to_csv_masterreport}
end


end

end


def masterreport 
  if session[:type]== "instructor"
    # Student.all.where(:instructor_id => session[:user_id])
  @students = Student.all.where(:instructor_id => session[:user_id])
  # @students = @students.joins(:results)

  respond_to do |format|
    format.html{redirect_to root_url}
    format.csv{send_data @students.to_csv_masterreport}
    # @students.to_csv_with_result
    # format.csv do
    #   headers['Content-Disposition'] = "attachment; filename=\"student-list\""
    #   headers['Content-Type'] ||= 'text/csv'
    # end
  end


  else 
  @students = Student.all

   respond_to do |format|
    format.html{redirect_to root_url}
    format.csv{send_data @students.to_csv_masterreport}
end


end

end

def findchapter

  if(params[:commit] == "View Chapter Report")
  redirect_to :conrtroller => :reports, :action => :chapterscore, :chapter => params[:chapter][:chapter_number]
else
  @chapter = Chapter.find(params[:chapter][:chapter_number])

  redirect_to report_chapterreport_path(format: :csv, :chapter => @chapter)
   # respond_to do |format|

   #  format.html{redirect_to root_url}
   #  format.csv{send_data @students.to_csv_masterreport_debug}
   #  end
 end
  end

def chapterreport
  if session[:type]== "instructor"
    # Student.all.where(:instructor_id => session[:user_id])
  @students = Student.all.where(:instructor_id => session[:user_id])
    @chapter = params[:chapter]
    # I think this is safe
    @query = 'scores.chapter_id = ' + @chapter

 # @students = @students.where("scores.chapter_id" => @chapter)
 #'scores.chapter_id = 2' 
  @students = @students.joins(:scores).where(@query).distinct
  # @students = @students.joins(:results)

  respond_to do |format|
    format.html{redirect_to root_url}
    format.csv{send_data @students.to_csv_masterreport}
    # @students.to_csv_with_result
    # format.csv do
    #   headers['Content-Disposition'] = "attachment; filename=\"student-list\""
    #   headers['Content-Type'] ||= 'text/csv'
    # end
  end


  else 
  @students = Student.all
    @chapter = params[:chapter]
    # I think this is safe
    @query = 'scores.chapter_id = ' + @chapter

 # @students = @students.where("scores.chapter_id" => @chapter)
 #'scores.chapter_id = 2' 
  @students = @students.joins(:scores).where(@query).distinct

   respond_to do |format|
    format.html{redirect_to root_url}
    format.csv{send_data @students.to_csv_masterreport}
end


end

 end

def findstudent
  if(params[:commit] == "View Student Report")
  redirect_to :conrtroller => :reports, :action => :studentscore, :student => params[:student_id][:id]
else

if params[:student_id] != nil
  @student = Student.find(params[:student_id][:id])
end

  if @student == nil
    flash[:failure] = "Please select a student"
    redirect_to :controller => :reports, :action => :student
  else
  redirect_to report_studentreport_path(format: :csv, :student => @student)
end
   # respond_to do |format|

   #  format.html{redirect_to root_url}
   #  format.csv{send_data @students.to_csv_masterreport_debug}
   #  end
 end
  end


def studentreport 
  if session[:type]== "instructor"
    # Student.all.where(:instructor_id => session[:user_id])
  @student = Student.where(:id => params[:student]).where(:instructor_id => session[:user_id])
  # @students = @students.joins(:results)
  respond_to do |format|
    format.html{redirect_to :conrtroller => :reports, :action => :student}
    format.csv{send_data @student.to_csv_masterreport}
    # @students.to_csv_with_result
    # format.csv do
    #   headers['Content-Disposition'] = "attachment; filename=\"student-list\""
    #   headers['Content-Type'] ||= 'text/csv'
    # end
  end


  else 
  @student = Student.where(:id => params[:student])

   respond_to do |format|
    format.html{redirect_to root_url}
    format.csv{send_data @student.to_csv_masterreport}
end


end

end




def download    

@students = Student.all
# find maximum number of children any parent has. Make sure to convert to integer.
@max_children = Result.select('student_id, COUNT(student_id)').group(:student_id).order('COUNT(student_id) DESC').first.count.to_i

@parent_columns = Student.column_names
@child_columns = Result.column_names

@streaming = true
@filename = "download.csv"

respond_to do |format|
   format.html{redirect_to root_url}
  format.csv
end
end


def student_params
      params.permit(:student)
end


def student_params
      params.permit(:score_id)
end


def chapter_params
      params.permit(:chapter).permit(:chapter_number)
end

def vsr_params
      params.permit(:vsr)
end

end
