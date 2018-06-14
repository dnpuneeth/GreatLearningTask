class Comment < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :votes, dependent: :destroy

  validates :question, presence: true,
                      length: { minimum: 5 }

  accepts_nested_attributes_for :votes

  scope :cmt, lambda { |id| where('question_id IN (?)', id)}
end
