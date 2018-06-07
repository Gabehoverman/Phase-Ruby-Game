class QuestionBuilderController < ApplicationController
	before_action :confirm_logged_in


def makequestionandanswer
  @newQuestion= Question.create(chapter_id:  params[:new_question][:chapter], question_desc:  params[:new_question][:question_title], correct_answer: params[:new_question][:answer_title] ,active: 'true')
  !@newQuestion.save
  # @newQuestionAsset = :question_asset => {:title => params[:title], :bytes => params[:bytes], :image => params[:image],
  # # :image_cache => params[:image_cache], :isanswer => false, :chapter_id => params[:chapter], :question_id => @newQuestion.id}
 #     render(:action => :creamakequestionassette, :question_asset => {:title => params[:title], :bytes => params[:bytes], :image => params[:image],
  # :image_cache => params[:image_cache], :isanswer => false, :chapter_id => params[:chapter], :question_id => @newQuestion.id})

    @photo = QuestionAsset.new(:title => params[:new_question][:question_title], :bytes => params[:new_question][:question_bytes], :image => params[:new_question][:question_image],
  :image_cache => params[:new_question][:question_image_cache], :isanswer => false, :chapter_id => params[:new_question][:chapter], :question_id => @newQuestion.id)
    # In through-the-server mode, the image is first uploaded to the Rails server.
    # When @photo is saved, Carrierwave uploads the image to Cloudinary.
    # The upload metadata (e.g. image size) is then available in the
    # uploader object of the model (@photo.image).
    # In direct mode, the image is uploaded to Cloudinary by the browser,
    # and upload metadata is available in JavaScript (see new_direct.html.erb).
    if !@photo.save
      @error = @photo.errors.full_messages.join('. ')
        redirect_to(:action => :chapter_commandcenter, :chapter_number => params[:new_question][:chapter])
      return
    end
    if !direct_upload_mode?
      # In this sample, we want to store a part of the upload metadata
      # ("bytes" - the image size) in the Photo model.
      # In direct mode, we pass the image size via a hidden form field
      # filled by JavaScript (see new_direct.html.erb).
      # In through-the-server mode, we need to copy this field from Cloudinary
      # upload metadata. The metadata is only available after Carrierwave
      # performs the upload (in @photo.save), so we need to update the
      # already saved photo here.
      @photo.update_attributes(:bytes => @photo.image.metadata['bytes'])
      # Show upload metadata in the view
      @upload = @photo.image.metadata
    end

     @photo2 = QuestionAsset.new(:title => params[:new_question][:answer_title], :bytes => params[:new_question][:answer_bytes], :image => params[:new_question][:answer_image],
  :image_cache => params[:new_question][:answer_image_cache], :isanswer => true, :chapter_id => params[:new_question][:chapter], :question_id => @newQuestion.id)
    # In through-the-server mode, the image is first uploaded to the Rails server.
    # When @photo is saved, Carrierwave uploads the image to Cloudinary.
    # The upload metadata (e.g. image size) is then available in the
    # uploader object of the model (@photo.image).
    # In direct mode, the image is uploaded to Cloudinary by the browser,
    # and upload metadata is available in JavaScript (see new_direct.html.erb).
    if !@photo2.save
      @error = @photo2.errors.full_messages.join('. ')
        redirect_to(:action => :chapter_commandcenter, :chapter_number => params[:new_question][:chapter])
      return
    end
    if !direct_upload_mode?
      # In this sample, we want to store a part of the upload metadata
      # ("bytes" - the image size) in the Photo model.
      # In direct mode, we pass the image size via a hidden form field
      # filled by JavaScript (see new_direct.html.erb).
      # In through-the-server mode, we need to copy this field from Cloudinary
      # upload metadata. The metadata is only available after Carrierwave
      # performs the upload (in @photo.save), so we need to update the
      # already saved photo here.
      @photo2.update_attributes(:bytes => @photo2.image.metadata['bytes'])
      # Show upload metadata in the view
      @upload = @photo2.image.metadata
    end

        redirect_to(:action => :chapter_commandcenter, :chapter_number => params[:new_question][:chapter])

end



def makequestion
	@newQuestion= Question.create(chapter_id:  params[:new_question][:chapter], question_desc:  params[:new_question][:title], correct_answer: params[:new_question][:correct_answer] ,active: 'true')
	!@newQuestion.save
	# @newQuestionAsset = :question_asset => {:title => params[:title], :bytes => params[:bytes], :image => params[:image],
	# # :image_cache => params[:image_cache], :isanswer => false, :chapter_id => params[:chapter], :question_id => @newQuestion.id}
 #     render(:action => :creamakequestionassette, :question_asset => {:title => params[:title], :bytes => params[:bytes], :image => params[:image],
	# :image_cache => params[:image_cache], :isanswer => false, :chapter_id => params[:chapter], :question_id => @newQuestion.id})

    @photo = QuestionAsset.new(:title => params[:new_question][:title], :bytes => params[:new_question][:bytes], :image => params[:new_question][:image],
	:image_cache => params[:new_question][:image_cache], :isanswer => true, :question_id => @newQuestion.id)
    # In through-the-server mode, the image is first uploaded to the Rails server.
    # When @photo is saved, Carrierwave uploads the image to Cloudinary.
    # The upload metadata (e.g. image size) is then available in the
    # uploader object of the model (@photo.image).
    # In direct mode, the image is uploaded to Cloudinary by the browser,
    # and upload metadata is available in JavaScript (see new_direct.html.erb).
    if !@photo.save
      @error = @photo.errors.full_messages.join('. ')
        redirect_to(:action => :chapter_commandcenter, :chapter_number => params[:new_question][:chapter])
      return
    end
    if !direct_upload_mode?
      # In this sample, we want to store a part of the upload metadata
      # ("bytes" - the image size) in the Photo model.
      # In direct mode, we pass the image size via a hidden form field
      # filled by JavaScript (see new_direct.html.erb).
      # In through-the-server mode, we need to copy this field from Cloudinary
      # upload metadata. The metadata is only available after Carrierwave
      # performs the upload (in @photo.save), so we need to update the
      # already saved photo here.
      @photo.update_attributes(:bytes => @photo.image.metadata['bytes'])
      # Show upload metadata in the view
      @upload = @photo.image.metadata
    end

        redirect_to(:action => :chapter_commandcenter, :chapter_number => params[:new_question][:chapter])

end


def inactivate

if session[:type] == "admin"
@question = Question.find(params[:question_id])
@change_to = params[:change_to]
 @chapter = params[:chapter]


  if params[:commit] == "Cancel"
      flash[:notice] = "Canceled"
              redirect_to(:action => :chapter_commandcenter, :chapter_number => @chapter)
  
  else
    @question.active = @change_to
    if @question.save
      if @change_to == 'true'
        flash[:success] = @question.question_desc + " was activated!"
              redirect_to(:action => :chapter_commandcenter, :chapter_number => @chapter)

        else
          flash[:failure] = @question.question_desc + " was deactivated!"
              redirect_to(:action => :chapter_commandcenter, :chapter_number => @chapter)

      end

      else
        flash[:failure] = "Not saved"
              redirect_to(:action => :chapter_commandcenter, :chapter_number => @chapter)
  end
end
end
end
# else
  
#  flash[:notice] = "Function not available for Instructor!"
#   # redirect_to(:controller => :menu, :action => :menu)
# end




	def index
		if session[:type] == "admin"
		else
		flash[:failure] = "Not Available for Instructor account"
    	redirect_to(:controller => :menu, :action => :menu)
		end

	end

	def findchapter
		@chapter = chapter_params
		redirect_to( :action => :chapter_commandcenter, :params => @chapter)

	end

	def chapter_commandcenter
		if session[:type] == "admin"
    @photos = QuestionAsset.all.where(:chapter_id =>params[:chapter_number]).to_a
    
  
		 @chapter = Chapter.find(params[:chapter_number])
		 @questions = Question.all.where(:chapter_id => @chapter)
		 @results = Result.all.where(:chapter_id => @chapter)
		 @corrects = Array.new()
		 @wrongs = Array.new()
		 @percentages = Array.new()

		  @questions.each_with_index do |question, index|

		 	@myquestionsresults = @results.where(:question_id => question)
		 		@correct = 0
		 		@wrong= 0
		 for myquestionsresult in @myquestionsresults
			if(myquestionsresult.isanswercorrect)
		 				@correct = @correct +1
		 			else
		 				@wrong = @wrong +1
		 			end
		 		end
		 	@corrects.push(@correct)
		 	@wrongs.push(@wrong)

		 	
		end
		 

		else
		flash[:failure] = "Not Available for Instructor account"
    	redirect_to(:controller => :menu, :action => :menu)
		end

	end


private


def chapter_params
      params.require(:chapter).permit(:chapter_number)
end

def student_params
      params.require(:student_id).permit(:id)
end

  def question_asset_params
params.require(:question_asset).permit(:title, :bytes, :image, :image_cache, :isanswer, :chapter_id, :question_id)
  end


  def direct_upload_mode?
    params[:direct].present?
  end
  
  def unsigned_mode?
    params[:unsigned].present?
  end
  
  def view_for_new
    direct_upload_mode? ? "new_direct" : "new"
  end
end
