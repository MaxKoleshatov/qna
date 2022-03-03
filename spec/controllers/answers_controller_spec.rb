require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

    describe 'POST #create' do
    before {login(user)}
      context 'witn valid attributes' do
        it 'save answer in database' do

         expect {post :create, params: {question_id: question, answer: attributes_for(:answer)}}.to change(question.answers, :count).by(1)
        end

      it 'redirect new answer' do
        post :create, params: {question_id: question.id, answer: attributes_for(:answer)}
        expect(response).to redirect_to assigns(:answer)
      end
    end

    context 'witn invalid attributes' do
      it 'dont save answer in database' do
        expect {post :create, params: {question_id: question, answer: attributes_for(:answer, :invalid)}}.to_not change(Answer, :count)
      end

      it 'render view in new answer' do
        post :create, params: {question_id: question, answer: attributes_for(:answer, :invalid)}
        expect(response).to render_template 'questions/show'
      end
    end
  end
end
