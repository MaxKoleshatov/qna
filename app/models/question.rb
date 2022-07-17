class Question < ApplicationRecord

  include Voteable
  
  has_one :prize, dependent: :destroy

  has_many :answers, dependent: :destroy
  has_many :links, dependent: :destroy, as: :linkable
  belongs_to :user

  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank
  accepts_nested_attributes_for :prize, reject_if: :all_blank

  has_many :comments, dependent: :destroy, as: :commentable
  has_many :subscriptions, dependent: :destroy
 
  validates :title, :body, presence: true

  after_create :calculate_reputation

  private

  def calculate_reputation
    ReputationJob.perform_later(self)
  end
end
