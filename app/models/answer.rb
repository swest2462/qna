class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :user_id, :question_id, :body, presence: true
  validates :body, length: {in: 5..1000}
end
