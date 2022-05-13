require 'rails_helper'

RSpec.describe Prize, type: :model do
  it { should belong_to :question}
  it { should belong_to(:user).optional}

  it {should validate_presence_of :name}
  it {should validate_presence_of :image}
end
