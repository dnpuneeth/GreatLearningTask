class User < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  accepts_nested_attributes_for :questions
end
