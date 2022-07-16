# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:prizes).dependent(:destroy) }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should have_many(:authorizations).dependent(:destroy) }
  it { should have_many(:subscriptions).dependent(:destroy) }

  describe '.find_for_oauth' do
    let!(:user) {create(:user)}
    let(:auth){OmniAuth::AuthHash.new(provider: 'github', uid: "84406322")}
    let(:service){double('FindForOauthService')}

    it ' calls FindForOauthService' do
      expect(FindForOauthService).to receive(:new).with(auth).and_return(service)
      expect(service).to receive(:call)
      User.find_for_oauth(auth)
    end
  end

  describe 'Author?' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:question1) { create(:question, user_id: user1.id) }

    context 'question' do
      let(:question2) { create(:question, user_id: user2.id) }

      it 'user is the author of the question' do
        expect(user1).to be_author(question1)
      end

      it 'user is not author of the question' do
        expect(user1).to_not be_author(question2)
      end
    end

    context 'answer' do
      let(:answer1) { create(:answer, question_id: question1.id, user_id: user1.id) }

      it 'user is the author of the answer' do
        expect(user1).to be_author(answer1)
      end

      it 'user is not author of the answer' do
        expect(user2).to_not be_author(answer1)
      end
    end
  end
end
