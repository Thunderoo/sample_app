class Post < ActiveRecord::Base
  belongs_to :forum
  has_many :replies
  default_scope -> { order('updated_at DESC') }

  validates :content, presence: true
  validates :title, presence: true
  validates :user_id, presence: true
  validates :forum_id, presence: true
end
