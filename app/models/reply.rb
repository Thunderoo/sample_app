class Reply < ActiveRecord::Base
  belongs_to :post
  default_scope -> { order('created_at') }

  validates :user_id, presence: true
  validates :content, presence: true
end
