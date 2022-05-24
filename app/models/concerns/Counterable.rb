module Counterable
  extend ActiveSupport::Concern
  
  included do
    has_one :counter, dependent: :destroy, as: :counterable
  end
end