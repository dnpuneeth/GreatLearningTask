class Vote < ApplicationRecord
  belongs_to :comment
  belongs_to :user

  scope :upvoted, lambda { |id| where(comment_id: id, vote: 1) }
  scope :downvoted, lambda { |id| where(comment_id: id, vote: -1) }
  scope :totalupvotes, -> { where('vote > ?', 0) }
  scope :totaldownvotes, -> { where('vote < ?', 0) }
  scope :cmt_id, lambda { |id| where(comment_id: id) }
end
