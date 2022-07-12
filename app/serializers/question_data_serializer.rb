# frozen_string_literal: true

class QuestionDataSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :body, :created_at, :updated_at
  has_many :links
  has_many :comments

  def comments
    object.comments
  end

  def links
    object.links
  end
end
