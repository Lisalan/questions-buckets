class QuestionsController < ApplicationController

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:success] = "Create Question Success!"
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
        flash[:success] = "Move unmatched questions to nonmatched questions successfully ."
      else
        questions.update_all(bucket_id: @bucket_id, role: "matched")
        flash[:success] = "Move unmatched questions to selected bucket successfully." 
        
      end     
    else  
    end

    @nonmatched_ids = params[:nonmatched]
    if @nonmatched_ids.present?
      questions = Question.for_id(params[:nonmatched])
      questions.update_all(role: "unmatched")
      flash[:success] = "Move nonmatched questions to unmatched questions successfully ."
    else
    end
    redirect_to questions_path    
  end

  private

    def question_params
      params.require(:question).permit(:content)
    end

end
