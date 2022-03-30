# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  has_many_attached :files

  scope :sort_by_best, -> { order(best: :desc) }

  validates :text, presence: true

  def best_answer
    transaction do
      question.answers.update_all(best: false)
      update!(best: true)
    end
  end
end
