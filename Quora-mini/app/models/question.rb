class Question < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :question, presence: true,
                      length: { minimum: 5 }

  accepts_nested_attributes_for :comments

  scope :usr, lambda { |id| where(user_id: id) }
  scope :recent, -> { order('created_at desc') }
end
