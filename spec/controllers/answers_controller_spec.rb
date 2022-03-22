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
               params: { question_id: question, answer: attributes_for(:answer), format: :js }
        end.to change(question.answers, :count).by(1)
      end

      it 'redirect new answer' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer), format: :js }
        expect(response).to render_template :create
      end
    end

    context 'witn invalid attributes' do
      it 'dont save answer in database' do
        expect do
          post :create,
               params: { question_id: question, answer: attributes_for(:answer, :invalid), format: :js }
        end.to_not change(Answer, :count)
      end

      it 'render view in new answer' do
        post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid), format: :js }
        expect(response).to render_template :create
      end
    end
  end

  describe 'DELETE #destroy' do
    before { login(user) }

    context 'user author answer' do
      let!(:answer1) { create(:answer, question_id: question.id, user_id: user.id) }

      it 'deletes the answer' do
        expect { delete :destroy, params: { id: answer1 }, format: :js }.to change(Answer, :count).by(-1)
      end

      it 'redirect to question' do
        delete :destroy, params: { id: answer1 }, format: :js
        expect(response).to render_template :destroy
      end
    end

    context 'user not the author answer' do
      let!(:user2) { create(:user) }
      let!(:answer2) { create(:answer, question_id: question.id, user_id: user2.id) }

      it 'answer will not be deleted' do
        expect { delete :destroy, params: { id: answer2 }, format: :js }.to change(Answer, :count).by(0)
      end

      it 'redirects to question' do
        delete :destroy, params: { id: answer2 }, format: :js
        expect(response).to render_template :destroy
      end
    end
  end

  describe 'PATH #update' do
    before { login(user) }

    let(:question) { create(:question) }
    let(:answer) { create(:answer, question_id: question.id) }

    context 'witn valid attributes' do
      it 'changes answer attributes' do
        patch :update, params: { id: answer, answer: { text: 'new' } }, format: :js
        answer.reload
        expect(answer.text).to eq 'new'
      end

      it 'render update view' do
        patch :update, params: { id: answer, answer: { text: 'new text' } }, format: :js
        expect(response).to render_template :update
      end
    end

    context 'witn invalid attributes' do
      it 'does not change answer attributes' do
        expect do
          patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js
        end.to_not change(answer, :text)
      end

      it 'render update view' do
        patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js
        expect(response).to render_template :update
      end
    end

    context 'user author answer' do
      it 'changes answer attributes' do
        patch :update, params: { id: answer, answer: { text: 'new' } }, format: :js
        answer.reload

        expect(assigns(:answer)).to eq answer
      end

      it 'render update view' do
        patch :update, params: { id: answer, answer: { text: 'new text' } }, format: :js
        expect(response).to render_template :update
      end
    end

    context 'user not author answer' do
      let(:user1) { create(:user) }
      let(:answer1) { create(:answer, question_id: question.id, user_id: user1.id) }

      it 'does not change answer attributes' do
        patch :update, params: { id: answer1, answer: { text: 'new' } }, format: :js
        answer.reload
        expect(answer1.text).to_not eq 'new'
      end
    end
  end
end
