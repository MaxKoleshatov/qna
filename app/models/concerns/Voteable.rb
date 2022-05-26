module Voteable
  extend ActiveSupport::Concern
  
  included do
    has_many :votes, dependent: :destroy, as: :voteable
  end

  def progress
    votes.sum(:value)
  end
end
