require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
    let(:question) { create(:question) }

    describe 'POST #create' do
      context 'witn valid attributes' do
        it 'сохраняет ответ в базе' do

         expect {post :create, params: {question_id: question, answer: attributes_for(:answer)}}.to change(Answer, :count).by(1)
        end

      it 'redirect new answer' do
        post :create, params: {question_id: question, answer: attributes_for(:answer)}
        expect(response).to redirect_to assigns(:answer)
      end
    end

    context 'witn invalid attributes' do
      it 'не сохраняет ответ в базе' do
        expect {post :create, params: {question_id: question, answer: attributes_for(:answer, :invalid)}}.to_not change(Answer, :count)
      end

      it 'render view in new answer' do
        post :create, params: {question_id: question, answer: attributes_for(:answer, :invalid)}
        expect(response).to render_template :new
      end
    end
  end
end
