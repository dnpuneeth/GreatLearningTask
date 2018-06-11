class Comment < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :question, presence: true,
                      length: { minimum: 5 }

  scope :cmt, lambda { |id| where('question_id IN (?)', id)}
end
