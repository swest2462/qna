class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params.merge(user: current_user))
  end

  def destroy
    @answer = Answer.find(params[:id])
    @question = @answer.question
    if current_user.author_of?(@answer)
      @answer.destroy
      flash[:success] = 'Your answer is successfully deleted.'
      redirect_to @question
    else
      flash.now[:error] = 'You not owner of this answer'
      render 'question/show'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
