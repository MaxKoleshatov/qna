require 'rails_helper'

describe Ability, type: :model do
    subject(:ability) { Ability.new(user) }
  
    describe 'for guest' do
      let(:user) { nil }
  
      it { should be_able_to :read, Question }
      it { should be_able_to :read, Answer }
      it { should be_able_to :read, Comment }
  
      it { should_not be_able_to :manage, :all }
    end
  
    describe 'for admin' do
      let(:user) { create :user, admin: true }
  
      it { should be_able_to :manage, :all }
    end
  
    describe 'for user' do
      let!(:user) { create :user }
      let(:other) { create :user }
      let!(:question1) {create :question, user_id: user.id}
      let(:answer1) {create :answer, question_id: question1.id, user_id: user.id}
  
  
      it { should_not be_able_to :manage, :all }
      it { should be_able_to :read, :all }
  
      it { should be_able_to :create, Question }
      it { should be_able_to :create, Answer }
      it { should be_able_to :create, Comment }
  
      it { should be_able_to :update, create(:question, user: user) }
      it { should_not be_able_to :update, create(:question, user: other) }

      it { should be_able_to :destroy, create(:question, user: user) }
      it { should_not be_able_to :destroy, create(:question, user: other) }
  
      it { should be_able_to :update, create(:answer, user: user) }
      it { should_not be_able_to :update, create(:answer, user: other) }

      it { should be_able_to :destroy, create(:answer, user: user) }
      it { should_not be_able_to :destroy, create(:answer, user: other) }

      it { should be_able_to :update, create(:comment, commentable: question1, user: user) }
      it { should_not be_able_to :update, create(:comment, commentable: question1, user: other) }

      it { should be_able_to :destroy, create(:comment, commentable: question1, user: user) }
      it { should_not be_able_to :destroy, create(:comment, commentable: question1, user: other) }

      it { should be_able_to :plus_vote, create(:question) }
      it { should be_able_to :minus_vote, create(:question) }
      it { should be_able_to :delete_vote, create(:question) }

      it { should be_able_to :plus_vote, create(:answer) }
      it { should be_able_to :minus_vote, create(:answer) }
      it { should be_able_to :delete_vote, create(:answer) }
    end
  end