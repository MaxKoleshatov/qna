# frozen_string_literal: true

class Answer < ApplicationRecord

  include Voteable
  
  belongs_to :question, touch: true
  belongs_to :user

  has_many_attached :files

  has_many :links, dependent: :destroy, as: :linkable
  accepts_nested_attributes_for :links, reject_if: :all_blank

  has_many :comments, dependent: :destroy, as: :commentable

  scope :sort_by_best, -> { order(best: :desc) }

  validates :text, presence: true

  def best_answer
    transaction do
      question.answers.update_all(best: false)
      update!(best: true)
      question.prize&.update!(user_id: self.user.id)
    end
  end 
end
