class Vote < ApplicationRecord

  belongs_to :voteable, polymorphic: true
  belongs_to :user

  def up_vote
    self.value = 1
    save
  end

  def down_vote
    self.value = -1
    save
  end

  def un_vote
    self.delete
  end
end
