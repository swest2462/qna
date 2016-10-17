require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  let(:question) { create(:question) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, id: question }

    it 'assings the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in_user
    before { get :new }

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    sign_in_user
    before { get :edit, id: question }

    it 'assings the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do
      it 'saves the new question in the database' do
        expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, question: attributes_for(:invalid_question)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user

    context 'update with valid attributes' do
      it 'assigns a requested question to the variable @question' do
        patch :update, id: question, question: attributes_for(:question)
        expect(assigns(:question)).to eq question
      end

      it 'changes attributes question' do
        patch :update, id: question, question: { title: 'new title', body: 'new body' }
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it 'redirects to updated question' do
        patch :update, id: question, question: attributes_for(:question)
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      it 'to_not change attributes' do
        patch :update, id: question, question: { title: nil, body: 'new question' }
        expect(question.body).to eq 'Good question body'
      end

      it 'render edit template' do
        patch :update, id: question, question: attributes_for(:invalid_question)
        expect(response).to render_template :edit
      end
    end
  end


  describe 'DELETE #destroy' do
    sign_in_user

    context 'user is question owner' do
      before { question.update_attribute(:user_id, @user.id) }

      it 'delete own question' do
        expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
      end

      it 'redirects to :index template' do
        delete :destroy, id: question
        expect(response).to redirect_to questions_path
      end
    end

    context 'user is not question owner' do
      before { question.update_attribute(:user_id, nil) }

      it 'delete own question' do
        expect { delete :destroy, id: question }.to_not change(Question, :count)
      end

      it 'redirects to :index template' do
        delete :destroy, id: question
        expect(response).to redirect_to question_path(question)
      end
    end
  end
end