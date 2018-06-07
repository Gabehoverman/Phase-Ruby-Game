class GamemanagementController < ApplicationController
	before_action :confirm_logged_in

	def manage
	@chapter_number = params[:chapter_number]
		if @chapter_number 
			#flash[:notice] = "TESTING: Chapter" +@chapter_number +" selected! "
		else
			@chapter_number = 1
		end

		@chapters = Chapter.order(:chapter_number).all
		@students = Student.all.where(:instructor_id => session[:user_id], :active => true)




	end

	def done
	@disable_nav = true


	end

	def findchapter
		@chapter = chapter_params
		redirect_to(:controller => :gamemanagement, :action => :manage, :params => @chapter)

	end


	def game
		 @disable_nav = true
		#uncomment this line to remove toolbar, but it causes an error need to debug game.html in views/layouts
		# render :layout => 'game'
		@student = student_params[:id]
		@chapter = chapter_params[:chapter_number]
		# flash[:notice] = @chapter

		@score = Score.new
		@score[:student_id] = @student
		@score[:chapter_id] = @chapter
		@score.save
		session[:score] = @score[:id]

	end

	def save_result
		@score = Score.find( session[:score] )
		@result = Result.new
		@result[:student_id] = params[:student_id]
		@result[:chapter_id] = params[:chapter_number]
		@result[:ongoing] = params[:ongoing]
		@result[:question_id] = params[:question_id]
		@result[:student_answer] = params[:student_answer]
		@result[:score_id] = @score[:id]

		if @result.save
			flash[:notice] = "Result was saved"
			redirect_to( :action => 'game', :student_id => Student.find( @score[:student_id] ) )
		else
			flash[:notice] = "Result was not saved..."
			redirect_to( :action => 'game', :student_id => Student.find( @score[:student_id] ) )
		end
	end

	def save_score
		@score = Score.find( session[:score] )
		@score[:is_value] = nil

		if @score.save
			#flash[:notice] = "Score was saved"
			redirect_to( :action => 'game', :student_id => Student.find( @score[:student_id] ) )
		else
			#flash[:notice] = "Score was not saved..."
			redirect_to( :action => 'game', :student_id => Student.find( @score[:student_id] ) )
		end
	end

private


def chapter_params
      params.require(:chapter).permit(:chapter_number)
end

def student_params
      params.require(:student_id).permit(:id)
end

end

