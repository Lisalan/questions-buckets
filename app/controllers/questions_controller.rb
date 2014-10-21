class QuestionsController < ApplicationController

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to new_question_path
    else
      render 'new'
    end    
  end

  def index
    @unmatched = Question.unmatched
    @nonmatched = Question.nonmatched  
  end

  def update_multiple
  
    @unmatched_ids = params[:unmatched]
    @bucket_id = params["move-questions-to-bucket"]
    if @bucket_id.present? && @unmatched_ids.present?
      questions = Question.for_id(params[:unmatched])
      if @bucket_id == "nonmatched"
        questions.update_all(role: @bucket_id)
      else
        questions.update_all(bucket_id: @bucket_id, role: "matched")
      end
     
    else
      
    end

    @nonmatched_ids = params[:nonmatched]
    if @nonmatched_ids.present?
      questions = Question.for_id(params[:nonmatched])
      questions.update_all(role: "unmatched")
      
    else

    end
    redirect_to questions_path    
  end

  private

    def question_params
      params.require(:question).permit(:content)
    end

end
