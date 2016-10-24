class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :user

  validates :user_id, :body, :title, presence: true
  validates :title,  length: { in: 5..150 }
  validates :body, length: { in: 5..1000 }
end
