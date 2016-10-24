require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  sign_in_user

  let(:question) { create :question, user: @user }
  let(:answer) { create :answer, question: question, user: @user }
  let(:invalid_answer) { create :invalid_answer, question: question }

  describe 'POST #create' do
    context 'answer with valid data' do
      it 'save new answer for question' do
        expect { post :create, answer: attributes_for(:answer), question_id: question, format: :js }
          .to change(question.answers, :count).by(1)
      end

      it 'new answer belongs_to user' do
        expect { post :create, answer: attributes_for(:answer), question_id: question, format: :js }
          .to change(@user.answers, :count).by(1)
      end

        it 'render create template' do
        post :create, answer: attributes_for(:answer), question_id: question, format: :js
        expect(response).to render_template :create
      end
    end

    context 'answer with invalid data' do
      it 'do not save new answer anywhere' do
        expect { post :create, answer: attributes_for(:invalid_answer), question_id: question, format: :js }
          .to_not change(Answer, :count)
      end

    it 'render create template' do
        post :create, answer: attributes_for(:invalid_answer), question_id: question, format: :js
        expect(response).to render_template :create
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'User is owner' do
      before { answer }

      it 'delete answer from question' do
        expect { delete :destroy, id: answer }
          .to change(question.answers, :count).by(-1)
      end

      it 'redirect to question#show' do
        delete :destroy, id: answer
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'User is not owner' do
      let(:another_user) { create(:user) }
      let!(:another_answer) { create :answer, question: question, user: another_user }

      it 'delete answer from question' do
        expect { delete :destroy, id: another_answer }
          .to_not change(Answer, :count)
      end

      it 'redirect to question#show' do
        delete :destroy, id: another_answer
        expect(response).to render_template 'questions/show'
      end
    end
  end
end