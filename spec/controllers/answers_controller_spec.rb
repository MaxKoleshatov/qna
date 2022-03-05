# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  describe 'POST #create' do
    before { login(user) }
    context 'witn valid attributes' do
      it 'save answer in database' do
        expect do
          post :create,
               params: { question_id: question, answer: attributes_for(:answer) }
        end.to change(question.answers, :count).by(1)
      end

      it 'redirect new answer' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer) }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'witn invalid attributes' do
      it 'dont save answer in database' do
        expect do
          post :create,
               params: { question_id: question, answer: attributes_for(:answer, :invalid) }
        end.to_not change(Answer, :count)
      end

      it 'render view in new answer' do
        post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) }
        expect(response).to render_template 'questions/show'
      end
    end
  end

  describe 'DELETE #destroy' do
    before { login(user) }

    context 'user author answer' do
      let!(:answer1) { create(:answer, question_id: question.id, user_id: user.id) }

      it 'deletes the answer' do
        expect { delete :destroy, params: { id: answer1 } }.to change(Answer, :count).by(-1)
      end

      it 'redirects to question' do
        delete :destroy, params: { id: answer1 }
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'user not the author answer' do
      let!(:user2) { create(:user) }
      let!(:answer2) { create(:answer, question_id: question.id, user_id: user2.id) }

      it 'answer will not be deleted' do
        expect { delete :destroy, params: { id: answer2 } }.to change(Answer, :count).by(0)
      end

      it 'redirects to question' do
        delete :destroy, params: { id: answer2 }
        expect(response).to redirect_to question_path(question)
      end
    end
  end
end
