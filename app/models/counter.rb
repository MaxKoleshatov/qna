class Counter < ApplicationRecord

  belongs_to :counterable, polymorphic: true
  belongs_to :user

  def value_plus
    self.value += 1
    save
  end

  def value_minus
    self.value -= 1
    save
  end

  def delete_vote_user
    if self.value < 0
      self.value += 1
    else
      self.value -= 1
    end
  end
end
