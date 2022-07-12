# frozen_string_literal: true

class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :question_id, :text, :created_at, :updated_at
end
