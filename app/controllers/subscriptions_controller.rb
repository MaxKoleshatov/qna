class SubscriptionsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      question = Question.find(params[:question_id])

      @subscription = question.subscriptions.create(user: current_user)
    end
  
    def destroy
      subscription = current_user.subscriptions.find_by(question_id: params[:id]) if params[:id]
      
      subscription.destroy
    end
  end