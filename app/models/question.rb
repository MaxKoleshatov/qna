class Question < ApplicationRecord
  
  has_one :prize, dependent: :destroy

  has_many :answers, dependent: :destroy
  has_many :links, dependent: :destroy, as: :linkable
  belongs_to :user

  has_many_attached :files
  

  accepts_nested_attributes_for :links, reject_if: :all_blank
  accepts_nested_attributes_for :prize, reject_if: :all_blank

  validates :title, :body, presence: true
end
