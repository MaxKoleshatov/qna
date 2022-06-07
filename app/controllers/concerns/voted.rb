# frozen_string_literal: true

module Voted
  extend ActiveSupport::Concern
  included do
    before_action :find_vote, only: %i[check_vote plus_vote minus_vote delete_vote]

    def plus_vote
      @vote.up_vote unless check_vote

      success_response
    end

    def minus_vote
      @vote.down_vote unless check_vote

      success_response
    end

    def delete_vote
      @vote.un_vote

      success_response
    end

    private

    def check_vote
      current_user.author?(@vote.voteable) || !@vote.voteable.votes.where(user_id: current_user.id).empty?
    end

    def find_vote
      @vote = model_klass.find(params[:id]).votes.find_or_initialize_by(user_id: current_user.id)
    end

    def model_klass
      controller_name.classify.constantize
    end

    def success_response
      render json: {
        id: @vote.voteable.id,
        value: @vote.value,
        progress: @vote.voteable.progress
      }
    end
  end
end
