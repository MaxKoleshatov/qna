# frozen_string_literal: true

module Vote
  extend ActiveSupport::Concern
  included do
    before_action :find_counter, only: %i[up_value_counter down_value_counter delete_vote]

    def create_counter
      @counter = @instance.build_counter
      @counter.user_id = current_user.id
      @counter.save
    end

    def up_value_counter
      if !@counter.vote_user.include?(current_user.id.to_s) && @counter.user.id != current_user.id
        @counter.value_plus
        @counter.vote_user << current_user.id.to_s
        @counter.save

        success_response
      end
    end

    def down_value_counter
      if !@counter.vote_user.include?(current_user.id.to_s) && @counter.user.id != current_user.id
        @counter.value_minus
        @counter.vote_user << current_user.id.to_s
        @counter.save

        success_response
      end
    end

    def delete_vote
      if @counter.vote_user.include?(current_user.id.to_s) && @counter.user.id != current_user.id
        @counter.vote_user.delete(current_user.id.to_s)
        @counter.delete_vote_user
        @counter.save

        success_response
      end
    end

    def find_counter
      @counter = model_klass.find(params[:id]).counter
    end

    def model_klass
      controller_name.classify.constantize
    end

    def success_response
      render json: {
        id: @counter.id,
        value: @counter.value
      }
    end
  end
end
